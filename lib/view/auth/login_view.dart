import 'package:data/Res/components/colors.dart';
import 'package:data/Res/components/custom_text_field.dart';
import 'package:data/Res/components/google_container.dart';
import 'package:data/Res/components/rounded_button.dart';
import 'package:data/Res/components/vertical_speacing.dart';
import 'package:data/utils/routes/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

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
                  text: 'Email Address',
                ),
                const VerticalSpeacing(16),
                const TextFieldCustom(
                  maxLines: 1,
                  text: 'Password',
                ),
                const VerticalSpeacing(16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          RoutesName.forget,
                        );
                      },
                      child: Text(
                        "Forgot password",
                        style: GoogleFonts.getFont(
                          "Poppins",
                          textStyle: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: AppColor.whiteColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const VerticalSpeacing(30),
                RoundedButton(
                    title: "Login",
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
                      "Don’t have an account? ",
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
                        Navigator.pushNamed(
                          context,
                          RoutesName.register,
                        );
                      },
                      child: Text(
                        "Sign Up",
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
        ),
      ),
    );
  }
}
