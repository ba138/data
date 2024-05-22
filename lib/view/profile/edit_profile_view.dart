import 'package:data/res/components/colors.dart';
import 'package:data/res/components/custom_text_field.dart';
import 'package:data/res/components/rounded_button.dart';
import 'package:data/res/components/vertical_speacing.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EditProfileView extends StatelessWidget {
  const EditProfileView({super.key});

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
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const TextFieldCustom(
              keyboardType: TextInputType.number,
              maxLines: 1,
              text: 'Full Name',
              hintText: "Hiren",
            ),
            const VerticalSpeacing(16),
            const TextFieldCustom(
              keyboardType: TextInputType.number,
              maxLines: 1,
              text: 'Email Address',
              hintText: "Hiren123@gmail.com",
            ),
            const VerticalSpeacing(16),
            const TextFieldCustom(
              keyboardType: TextInputType.number,
              maxLines: 1,
              text: 'Phone Number',
              hintText: "123456789",
            ),
            const VerticalSpeacing(
              80,
            ),
            RoundedButton(title: "Save Profile Detail ", onpress: () {})
          ],
        ),
      ),
    );
  }
}
