import 'package:data/Res/components/colors.dart';
import 'package:data/Res/components/custom_text_field.dart';
import 'package:data/Res/components/google_container.dart';
import 'package:data/Res/components/loading_manager.dart';
import 'package:data/Res/components/rounded_button.dart';
import 'package:data/Res/components/vertical_speacing.dart';
import 'package:data/utils/routes/routes_name.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/routes/utils.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  bool _isLoading = false;
  final authInstance = FirebaseAuth.instance;
  void _submitFormOnLogin() async {
    final isValid = _formKey.currentState!.validate();
    if (isValid) {
      _formKey.currentState!.save();
      setState(() {
        _isLoading = true;
      });
      try {
        await authInstance.signInWithEmailAndPassword(
            email: emailController.text.toLowerCase().trim(),
            password: passwordController.text.trim());
        Utils.toastMessage('SuccessFully Login');
        Navigator.pushNamedAndRemoveUntil(
            context, RoutesName.home, (route) => false);
      } on FirebaseException catch (e) {
        Utils.flushBarErrorMessage('NetWork Error $e', context);
        setState(() {
          _isLoading = false;
        });
      } catch (e) {
        Utils.flushBarErrorMessage('SignUp Fail', context);
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
      body: SafeArea(
        child: SingleChildScrollView(
          child: LoadingManager(
            isLoading: _isLoading,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _formKey,
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
                    TextFieldCustom(
                      controller: emailController,
                      maxLines: 1,
                      text: 'Email Address',
                    ),
                    const VerticalSpeacing(16),
                    TextFieldCustom(
                      controller: passwordController,
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
                          _submitFormOnLogin();
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
                    GoogleContainer(
                      isLoading: _isLoading,
                    ),
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
        ),
      ),
    );
  }
}
