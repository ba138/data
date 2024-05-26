import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data/Res/components/colors.dart';
import 'package:data/Res/components/custom_text_field.dart';
import 'package:data/Res/components/loading_manager.dart';
import 'package:data/Res/components/rounded_button.dart';
import 'package:data/Res/components/vertical_speacing.dart';
import 'package:data/utils/routes/routes_name.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EditProfileView extends StatefulWidget {
  const EditProfileView({super.key});

  @override
  _EditProfileViewState createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final User? user = FirebaseAuth.instance.currentUser;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    setState(() {
      _isLoading = true;
    });

    if (user != null) {
      try {
        final DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(user!.uid)
            .get();
        if (userDoc.exists) {
          _nameController.text = userDoc.get('name');
          _emailController.text = userDoc.get('email');
          _phoneController.text = userDoc.get('phone');
        }
      } catch (error) {
        // Handle error
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _updateUserData() async {
    if (user != null) {
      setState(() {
        _isLoading = true;
      });

      try {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user!.uid)
            .update({
          'name': _nameController.text,
          'email': _emailController.text,
          'phone': _phoneController.text,
        });
        Navigator.pushNamedAndRemoveUntil(
            context, RoutesName.home, (route) => false);
      } catch (error) {
        // Handle error
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
          'Edit Profile',
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
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFieldCustom(
                  controller: _nameController,
                  keyboardType: TextInputType.text,
                  maxLines: 1,
                  text: 'Full Name',
                  hintText: "Hiren",
                ),
                const VerticalSpeacing(16),
                TextFieldCustom(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  maxLines: 1,
                  text: 'Email Address',
                  hintText: "Hiren123@gmail.com",
                ),
                const VerticalSpeacing(16),
                TextFieldCustom(
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  maxLines: 1,
                  text: 'Phone Number',
                  hintText: "123456789",
                ),
                const VerticalSpeacing(80),
                RoundedButton(
                    title: "Save Profile Detail", onpress: _updateUserData),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
