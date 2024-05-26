import 'dart:async';

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
        if (FirebaseAuth.instance.currentUser != null) {
          await Navigator.pushNamed(context, RoutesName.home);
        } else {
          await Navigator.pushNamed(context, RoutesName.logoIn);
        }
      } catch (e) {
        Utils.flushBarErrorMessage(
            '$e', context); // Handle Firebase initialization error
      }
    });
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
