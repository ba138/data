import 'package:data/res/components/colors.dart';
import 'package:data/res/components/vertical_speacing.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const VerticalSpeacing(40),
        Text(
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
      ],
    )));
  }
}
