import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data/Res/components/colors.dart';
import 'package:data/view/home/home_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../utils/routes/utils.dart';

class GoogleContainer extends StatefulWidget {
  GoogleContainer({super.key, required this.isLoading});
  bool isLoading;

  @override
  State<GoogleContainer> createState() => _GoogleContainerState();
}

class _GoogleContainerState extends State<GoogleContainer> {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _authInstance = FirebaseAuth.instance;

  Future<void> signUp(BuildContext context) async {
    try {
      // Set isLoading to true to indicate loading state
      widget.isLoading = true;
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();

      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;
        final AuthCredential authCredential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken,
        );

        UserCredential result =
            await _authInstance.signInWithCredential(authCredential);

        if (result.user != null) {
          await _setupUserData(result.user!);
          // Show success message and navigate to the dashboard
          _showSuccessMessage(context);
          _navigateToDashboard(context);
        }
      }
    } on FirebaseAuthException catch (e) {
      _handleFirebaseAuthException(e, context);
    } catch (e) {
      _handleGenericError(e, context);
    } finally {
      // Set isLoading back to false after completing the task
      widget.isLoading = false;
    }
  }

  Future<void> _setupUserData(User user) async {
    await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
      'createdAt': FieldValue.serverTimestamp(),
      'email': user.email,
      'id': user.uid,
      'name': user.displayName,
      'profilePic': user.photoURL,
    });
  }

  void _showSuccessMessage(BuildContext context) {
    Utils.toastMessage('SuccessFully SignIn');
  }

  void _navigateToDashboard(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const HomeView()),
    );
  }

  void _handleFirebaseAuthException(
      FirebaseAuthException e, BuildContext context) {
    // Handle FirebaseAuthException,
    _showErrorMessage('${e.message}', context);
  }

  void _handleGenericError(dynamic e, BuildContext context) {
    // Handle generic errors,
    _showErrorMessage(e.toString(), context);
  }

  void _showErrorMessage(String message, BuildContext context) {
    Utils.flushBarErrorMessage(message, context);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        signUp(context);
      },
      child: Container(
        height: 50,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: AppColor.buttonColor),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 50,
              width: 67,
              decoration: BoxDecoration(
                  color: AppColor.whiteColor,
                  borderRadius: BorderRadius.circular(6)),
              child: Image.asset("images/google.png"),
            ),
            Text(
              "Continue with Google ",
              style: GoogleFonts.getFont(
                "Poppins",
                textStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: AppColor.whiteColor,
                ),
              ),
            ),
            const SizedBox(
              width: 30,
            ),
          ],
        ),
      ),
    );
  }
}
