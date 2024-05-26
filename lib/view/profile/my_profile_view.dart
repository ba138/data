// ignore_for_file: unnecessary_null_comparison

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data/Res/components/colors.dart';
import 'package:data/Res/components/loading_manager.dart';
import 'package:data/Res/components/rounded_button.dart';
import 'package:data/Res/components/vertical_speacing.dart';
import 'package:data/utils/routes/routes_name.dart';
import 'package:data/view/profile/widget/my_profile_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyProfileView extends StatefulWidget {
  const MyProfileView({super.key});

  @override
  State<MyProfileView> createState() => _MyProfileViewState();
}

class _MyProfileViewState extends State<MyProfileView> {
  final authInstance = FirebaseAuth.instance;
  String? _email;
  String? _name;
  String? _phone;
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
          _phone = userDoc.get('phone');
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
          'My Profile',
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
            children: [
              MyProfileWidget(
                title: 'Full Name',
                subTitle: '${_name ?? 'Default Name'}\n',
              ),
              const VerticalSpeacing(20),
              MyProfileWidget(
                title: 'Email Address',
                subTitle: '${_email ?? 'email null'}\n',
              ),
              const VerticalSpeacing(20),
              MyProfileWidget(
                title: 'Phone Number',
                subTitle: '${_phone ?? 'phone no null'}\n',
              ),
              const VerticalSpeacing(80),
              RoundedButton(
                  title: "Edit Profile",
                  onpress: () {
                    Navigator.pushNamed(
                      context,
                      RoutesName.editprofileview,
                    );
                  })
            ],
          ),
        )),
      ),
    );
  }
}
