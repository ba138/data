import 'package:data/Res/components/colors.dart';
import 'package:data/Res/components/custom_text_field.dart';
import 'package:data/Res/components/loading_manager.dart';
import 'package:data/Res/components/rounded_button.dart';
import 'package:data/Res/components/vertical_speacing.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/routes/routes_name.dart';
import '../../utils/routes/utils.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  TextEditingController emailController = TextEditingController();
  final authInstance = FirebaseAuth.instance;

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  bool _isLoading = false;
  void _forgetPassFCT() async {
    if (emailController.text.isEmpty || !emailController.text.contains("@")) {
      Utils.flushBarErrorMessage(
          'Please enter a correct email address', context);
    } else {
      setState(() {
        _isLoading = true;
      });
      try {
        await authInstance.sendPasswordResetEmail(
            email: emailController.text.toLowerCase());

        Utils.toastMessage('An email has been sent to your email address');
        Navigator.pushNamed(context, RoutesName.logoIn);
      } on FirebaseException catch (error) {
        Utils.flushBarErrorMessage('${error.message}', context);

        setState(() {
          _isLoading = false;
        });
      } catch (error) {
        Utils.flushBarErrorMessage('$error', context);
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
      body: LoadingManager(
        isLoading: _isLoading,
        child: SafeArea(
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
                    "Enter your email to reset password",
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
                  TextFieldCustom(
                    controller: emailController,
                    maxLines: 1,
                    text: 'Email Address',
                  ),
                  const VerticalSpeacing(40),
                  RoundedButton(
                      title: "Send",
                      onpress: () {
                        _forgetPassFCT();
                      })
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
