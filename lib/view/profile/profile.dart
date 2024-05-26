import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data/Res/components/colors.dart';
import 'package:data/Res/components/loading_manager.dart';
import 'package:data/Res/components/vertical_speacing.dart';
import 'package:data/utils/routes/routes_name.dart';
import 'package:data/view/profile/widget/profile_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/routes/utils.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final authInstance = FirebaseAuth.instance;
  String? _email;
  String? _name;
  String? address;
  String? _pImage;
  bool _isLoading = false;
  final User? user = FirebaseAuth.instance.currentUser;
  String defaultProfile =
      'https://t4.ftcdn.net/jpg/00/64/67/27/360_F_64672736_U5kpdGs9keUll8CRQ3p3YaEv2M6qkVY5.jpg';
  @override
  void initState() {
    getUserData();
    super.initState();
  }

  Future<void> getUserData() async {
    setState(() {
      _isLoading = true;
    });

    final googleAuth = FirebaseAuth.instance.currentUser;
    _name = googleAuth?.displayName ?? 'You';
    _email = googleAuth?.email ?? 'ID: 5788478';
    _pImage = googleAuth?.photoURL ?? defaultProfile;
    setState(() {
      _isLoading = false;
    });
    if (user != null) {
      try {
        String _uid = user!.uid;
        final DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(_uid)
            .get();
        if (userDoc != null || userDoc.data() != null) {
          _email = userDoc.get('email');
          _name = userDoc.get('name');
          _pImage = userDoc.get('profilePic');
        }
      } catch (error) {
        setState(() {
          _isLoading = false;
        });
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'User Profile',
          style: GoogleFonts.getFont(
            "Poppins",
            textStyle: const TextStyle(
                color: AppColor.whiteColor,
                fontSize: 16,
                fontWeight: FontWeight.w400),
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.west,
            color: AppColor.whiteColor,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: LoadingManager(
        isLoading: _isLoading,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const VerticalSpeacing(10),
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: AppColor.whiteColor,
                      backgroundImage: NetworkImage(
                        _pImage ?? defaultProfile,
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 2,
                      child: Container(
                        height: 22,
                        width: 22,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColor.buttonColor),
                        child: const Center(
                            child: Icon(
                          Icons.edit_note_outlined,
                          color: AppColor.whiteColor,
                          size: 14,
                        )),
                      ),
                    ),
                  ],
                ),
                const VerticalSpeacing(16.0),
                Text.rich(
                  TextSpan(
                      text: '${_name ?? 'Default Name'}\n',
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
                          text: _email!.length > 12
                              ? "${_email!.substring(0, 12)}..."
                              : _email ?? 'Default Email',
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
                const VerticalSpeacing(46),
                ProfileWidgets(
                    ontap: () {
                      Navigator.pushNamed(
                        context,
                        RoutesName.myprofileview,
                      );
                    },
                    tColor: const Color(0xff40C269),
                    bColor: const Color(0xffCDFF9D),
                    icon: Icons.person_outline,
                    trIcon: Icons.arrow_forward_ios,
                    title: 'My Profile'),
                const Divider(),
                ProfileWidgets(
                    ontap: () {
                      Navigator.pushNamed(context, RoutesName.mymessages);
                    },
                    tColor: const Color(0xff46C5CA),
                    bColor: const Color(0xff6DF5FC),
                    icon: Icons.message_outlined,
                    trIcon: Icons.arrow_forward_ios,
                    title: 'My Messages'),
                const Divider(),
                ProfileWidgets(
                    ontap: () {
                      Navigator.pushNamed(context, RoutesName.mySubscribtions);
                    },
                    tColor: const Color(0xffA24ABF),
                    bColor: const Color(0xffDF9EF5),
                    icon: Icons.card_giftcard_outlined,
                    trIcon: Icons.arrow_forward_ios,
                    title: 'My subscribtions'),
                const Divider(),
                ProfileWidgets(
                    ontap: () async {
                      authInstance.signOut();
                      Utils.toastMessage('SuccessFully LogOut');
                      await Navigator.pushNamedAndRemoveUntil(
                          context, RoutesName.logoIn, (route) => false);
                    },
                    tColor: const Color(0xffFF9CCB),
                    bColor: const Color(0xffEC4091),
                    icon: Icons.logout_outlined,
                    trIcon: Icons.arrow_forward_ios,
                    title: 'Log Out'),
                const Divider(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
