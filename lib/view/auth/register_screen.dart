import 'package:data/res/components/colors.dart';
import 'package:data/res/components/custom_text_field.dart';
import 'package:data/res/components/google_container.dart';
import 'package:data/res/components/rounded_button.dart';
import 'package:data/res/components/vertical_speacing.dart';
import 'package:data/utils/routes/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const VerticalSpeacing(80),
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
            const TextFieldCustom(
              maxLines: 1,
              text: 'Name',
            ),
            const VerticalSpeacing(16),
            const TextFieldCustom(
              maxLines: 1,
              text: 'Email Address',
            ),
            const VerticalSpeacing(16),
            const TextFieldCustom(
              maxLines: 1,
              text: 'Password',
            ),
            const VerticalSpeacing(16),
            const TextFieldCustom(
              maxLines: 1,
              text: 'Confrom Password',
            ),
            const VerticalSpeacing(30),
            RoundedButton(
                title: "Register",
                onpress: () {
                  Navigator.pushNamed(
                    context,
                    RoutesName.home,
                  );
                }),
            const VerticalSpeacing(30),
            Text(
              "Or Continue With",
              style: GoogleFonts.getFont(
                "Poppins",
                textStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: AppColor.whiteColor,
                ),
              ),
            ),
            const VerticalSpeacing(30),
            const GoogleContainer(),
            const VerticalSpeacing(30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Already have an account? ",
                  style: GoogleFonts.getFont(
                    "Poppins",
                    textStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: AppColor.whiteColor,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Sign In",
                    style: GoogleFonts.getFont(
                      "Poppins",
                      textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColor.buttonColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    )));
  }
}
