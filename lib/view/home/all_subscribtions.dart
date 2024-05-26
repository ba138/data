import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data/Res/components/colors.dart';
import 'package:data/Res/components/loading_manager.dart';
import 'package:data/view/home/widgets/subscribtion_Card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../../utils/routes/utils.dart';
import '../subscribtions/my_subscribtions.dart';

class AllSubscribtionsView extends StatefulWidget {
  const AllSubscribtionsView({super.key});

  @override
  State<AllSubscribtionsView> createState() => _AllSubscribtionsViewState();
}

class _AllSubscribtionsViewState extends State<AllSubscribtionsView> {
  final _firestoreInstance = FirebaseFirestore.instance;
  final List _allsubscrbtions = [];
  bool _isLoading = false;
  final String subscribtionStatus = 'pending';
  fetchallSubscribtions() async {
    try {
      setState(() {
        _isLoading = true;
      });
      QuerySnapshot qn =
          await _firestoreInstance.collection('Subscriptions').get();
      setState(() {
        for (int i = 0; i < qn.docs.length; i++) {
          _allsubscrbtions.add({
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
      'dateTime': DateTime.now(),
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
        Utils.toastMessage('You have already requested this subscription.');
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return MySubscribtions(
            duration: subscription['duration'],
            subscrintionCharges: subscription['charges'],
            subscrintionStatus: subscribtionStatus,
            date: subscription['date'],
          );
        }));
        setState(() {
          _isLoading = false;
        });
        return;
      }
      await FirebaseFirestore.instance
          .collection('subscriptionRequests')
          .doc(uuid)
          .set(subscriptionRequestData);

      Utils.toastMessage('Subscription request sent successfully');
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return MySubscribtions(
          duration: subscription['duration'],
          subscrintionCharges: subscription['charges'],
          subscrintionStatus: subscribtionStatus,
          date: subscription['date'],
        );
      }));
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
    fetchallSubscribtions();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.west,
              color: AppColor.whiteColor,
            )),
        title: const Text(
          'Subscribtions',
          style: TextStyle(color: AppColor.whiteColor),
        ),
        centerTitle: true,
      ),
      body: LoadingManager(
        isLoading: _isLoading,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
          child: ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _allsubscrbtions.length,
            itemBuilder: (context, index) {
              final subscription = _allsubscrbtions[index];
              return SubscribtionCard(
                bgColor: const Color(0xff30BD82),
                charge: subscription['charges'],
                date: subscription['date'],
                duration: subscription['duration'],
                ontapSubscribe: () {
                  createSubscriptionRequest(subscription);
                },
                subscribtionStatus: subscribtionStatus,
              );
            },
            separatorBuilder: (context, index) => const SizedBox(height: 10.0),
          ),
        ),
      ),
    );
  }
}
