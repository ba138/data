import 'package:data/res/components/colors.dart';
import 'package:data/res/components/custom_text_field.dart';
import 'package:data/res/components/rounded_button.dart';
import 'package:data/res/components/vertical_speacing.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const VerticalSpeacing(60),
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
                const VerticalSpeacing(80),
                Text(
                  "Enter your phone number",
                  style: GoogleFonts.getFont(
                    "Poppins",
                    textStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: AppColor.whiteColor,
                    ),
                  ),
                ),
                const VerticalSpeacing(40),
                const TextFieldCustom(
                  maxLines: 1,
                  text: 'Email Address',
                ),
                const VerticalSpeacing(40),
                RoundedButton(title: "Send", onpress: () {})
              ],
            ),
          ),
        ),
      ),
    );
  }
}
