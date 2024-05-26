// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data/Res/components/colors.dart';
import 'package:data/utils/routes/routes_name.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/routes/utils.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void startTimer() async {
    await Future.delayed(const Duration(seconds: 5), () async {
      try {
        await Firebase.initializeApp();
        User? user = FirebaseAuth.instance.currentUser;

        if (user != null) {
          DocumentSnapshot userDoc = await FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .get();

          if (userDoc.exists) {
            bool isBlock = userDoc['isBlock'];

            if (isBlock) {
              showBlockedPopup();
            } else {
              await Navigator.pushNamed(context, RoutesName.home);
            }
          } else {
            Utils.flushBarErrorMessage('User data not found', context);
          }
        } else {
          await Navigator.pushNamed(context, RoutesName.logoIn);
        }
      } catch (e) {
        Utils.flushBarErrorMessage('$e', context);
      }
    });
  }

  void showBlockedPopup() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Account Blocked"),
          content: const Text(
              "Your account has been blocked. Please contact support."),
          actions: <Widget>[
            TextButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Text(
          "Logo",
          style: GoogleFonts.getFont(
            "Poppins",
            textStyle: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w600,
              color: AppColor.whiteColor,
            ),
          ),
        ),
      )),
    );
  }
}
