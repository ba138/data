// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data/Res/components/colors.dart';
import 'package:data/Res/components/loading_manager.dart';
import 'package:data/Res/components/vertical_speacing.dart';
import 'package:data/utils/routes/routes_name.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uuid/uuid.dart';
import '../../utils/routes/utils.dart';
import 'widgets/subscribtion_Card.dart';
import 'widgets/trianglePainter.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final _firestoreInstance = FirebaseFirestore.instance;
  final List _subsCrbtions = [];
  bool _isLoading = false;
  fetchSubscribtions() async {
    try {
      setState(() {
        _isLoading = true;
      });
      QuerySnapshot qn =
          await _firestoreInstance.collection('Subscriptions').get();
      setState(() {
        for (int i = 0; i < qn.docs.length; i++) {
          _subsCrbtions.add({
            'charges': qn.docs[i]['charges'],
            'date': qn.docs[i]['date'],
            'duration': qn.docs[i]['duration'],
            'uuid': qn.docs[i]['uuid'],
          });
        }
      });
      return qn.docs;
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  final authInstance = FirebaseAuth.instance;
  String? _name;
  String? _pImage;
  num? _totalAmount;
  final User? user = FirebaseAuth.instance.currentUser;
  String subscribtionStatus = 'Subscribe';
  String defaultProfile =
      'https://t4.ftcdn.net/jpg/00/64/67/27/360_F_64672736_U5kpdGs9keUll8CRQ3p3YaEv2M6qkVY5.jpg';

  Future<void> getUserData() async {
    setState(() {
      _isLoading = true;
    });

    final googleAuth = FirebaseAuth.instance.currentUser;
    _name = googleAuth?.displayName ?? 'You';
    _pImage = googleAuth?.photoURL ?? defaultProfile;
    setState(() {
      _isLoading = false;
    });
    if (user != null) {
      try {
        String uid = user!.uid;
        final DocumentSnapshot userDoc =
            await FirebaseFirestore.instance.collection('users').doc(uid).get();
        if (userDoc.exists) {
          setState(() {
            _name = userDoc.get('name') ?? 'You';
            _pImage = userDoc.get('profilePic') ?? defaultProfile;
          });
        }
      } catch (e) {
        debugPrint('$e');
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> createSubscriptionRequest(
      Map<String, dynamic> subscription) async {
    setState(() {
      _isLoading = true;
    });

    final currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser == null) {
      Utils.toastMessage("No user is signed in.");
      setState(() {
        _isLoading = false;
      });
      return;
    }

    final userDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser.uid)
        .get();

    final uuid = const Uuid().v1();
    final subscriptionRequestData = {
      'userName': userDoc.get('name') ?? 'Unknown User',
      'userId': currentUser.uid,
      'usercurrentBalance': userDoc.get('balance') ?? 0,
      'subscribtionCharges': subscription['charges'],
      'dateTime': subscription['date'],
      'subscribtionId': subscription['uuid'],
      'Uuid': uuid,
      'subscribtionStatus': subscribtionStatus,
      'subscriptionDuration': subscription['duration'],
    };

    try {
      // Check if the subscription request already exists for this user
      final existingRequest = await FirebaseFirestore.instance
          .collection('subscriptionRequests')
          .where('userId', isEqualTo: currentUser.uid)
          .get();

      if (existingRequest.docs.isNotEmpty) {
        Utils.toastMessage('You have already requested the subscription.');

        setState(() {
          _isLoading = false;
        });
        return;
      }
      await FirebaseFirestore.instance
          .collection('subscriptionRequests')
          .doc(uuid)
          .set(subscriptionRequestData);
      await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser.uid)
          .collection('subscriptionRequests')
          .doc(uuid)
          .set(subscriptionRequestData);

      Utils.toastMessage('Subscription request sent successfully');
    } catch (e) {
      Utils.toastMessage('Failed to create subscription request: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    fetchSubscribtions();
    getUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoadingManager(
        isLoading: _isLoading,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 262.0,
                  width: double.infinity,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      CustomPaint(
                        painter: TrianglePainter(),
                        size: const Size(double.infinity, 262.0),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const VerticalSpeacing(30),
                          ListTile(
                            leading: InkWell(
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  RoutesName.profile,
                                );
                              },
                              child: CircleAvatar(
                                radius: 40.0,
                                backgroundImage: NetworkImage(
                                  _pImage ?? defaultProfile,
                                ),
                              ),
                            ),
                            title: Text(
                              _name ?? 'Default Name',
                              style: GoogleFonts.getFont(
                                "Poppins",
                                textStyle: const TextStyle(
                                  color: AppColor.whiteColor,
                                ),
                              ),
                            ),
                            subtitle: Text(
                              'Welcome',
                              style: GoogleFonts.getFont(
                                "Poppins",
                                textStyle: const TextStyle(
                                  color: AppColor.whiteColor,
                                ),
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    'Total Balance',
                                    style: GoogleFonts.getFont(
                                      "Poppins",
                                      textStyle: const TextStyle(
                                          color: AppColor.whiteColor,
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                  const VerticalSpeacing(5.0),
                                  StreamBuilder<DocumentSnapshot>(
                                      stream: FirebaseFirestore.instance
                                          .collection('users')
                                          .doc(user?.uid)
                                          .snapshots(),
                                      builder: (context, snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return const CircularProgressIndicator();
                                        }
                                        if (snapshot.hasError) {
                                          return Text(
                                              'Error: ${snapshot.error}');
                                        }
                                        if (!snapshot.hasData ||
                                            !snapshot.data!.exists) {
                                          return const Text('N/A');
                                        }

                                        final userDoc = snapshot.data!;
                                        _totalAmount =
                                            userDoc.get('balance') ?? 0;

                                        return Text(
                                          _totalAmount != null
                                              ? '₹${_totalAmount!.toStringAsFixed(0)}'
                                              : 'N/A',
                                          style: GoogleFonts.getFont(
                                            "Poppins",
                                            textStyle: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 30.0,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        );
                                      }),
                                ],
                              ),
                              Column(
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.pushNamed(
                                        context,
                                        RoutesName.addfunddetails,
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColor.buttonColor,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    child: const Text(
                                      'Add Fund',
                                      style:
                                          TextStyle(color: AppColor.whiteColor),
                                    ),
                                  ),
                                  const VerticalSpeacing(16.0),
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.pushNamed(
                                          context, RoutesName.withdrawFund);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColor.whiteColor,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    child: const Text(
                                      'Withdraw',
                                      style:
                                          TextStyle(color: AppColor.blackColor),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      Positioned(
                        bottom: -50, // Adjust this value as needed
                        left: MediaQuery.of(context).size.width / 3 -
                            100, // Centers the container horizontally
                        child: Container(
                          height: 80,
                          width: 327,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [
                                Color(0xFF3EEAAC),
                                Color(0xFF613EEA),
                              ],
                            ),
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0x33000000),
                                offset: Offset(4, 4),
                                blurRadius: 6,
                                spreadRadius: 4,
                              ),
                            ],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text.rich(
                              TextSpan(
                                  text: '5% increase  every month\n',
                                  style: GoogleFonts.getFont(
                                    "Poppins",
                                    textStyle: const TextStyle(
                                      color: AppColor.whiteColor,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  children: [
                                    TextSpan(
                                      text: '  if you deposit amount',
                                      style: GoogleFonts.getFont(
                                        "Poppins",
                                        textStyle: const TextStyle(
                                          color: AppColor.whiteColor,
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  ]),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const VerticalSpeacing(73.0),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Subscrptions',
                        style: GoogleFonts.getFont(
                          "Poppins",
                          textStyle: const TextStyle(
                            color: AppColor.whiteColor,
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                              context, RoutesName.allSubscriptionView);
                        },
                        child: Text(
                          'Vew all',
                          style: GoogleFonts.getFont(
                            "Poppins",
                            textStyle: const TextStyle(
                              color: AppColor.whiteColor,
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 20.0),
                  child: ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _subsCrbtions.length,
                    itemBuilder: (context, index) {
                      final subscription = _subsCrbtions[index];
                      return SubscribtionCard(
                        bgColor: const Color(0xff3F30BD),
                        charge: subscription['charges'],
                        date: subscription['date'],
                        duration: subscription['duration'],
                        subscribtionStatus: subscribtionStatus,
                        ontapSubscribe: () {
                          createSubscriptionRequest(subscription);
                        },
                      );
                    },
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 10.0),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
