import 'package:data/Res/components/colors.dart';
import 'package:data/Res/components/rounded_button.dart';
import 'package:data/Res/components/vertical_speacing.dart';
import 'package:data/utils/routes/routes_name.dart';
import 'package:data/view/profile/widget/my_profile_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyProfileView extends StatelessWidget {
  const MyProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'My Profile',
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
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const MyProfileWidget(
              title: 'Full Name',
              subTitle: 'Hiran',
            ),
            const VerticalSpeacing(20),
            const MyProfileWidget(
              title: 'Gmail Address',
              subTitle: 'Hiran123@gmail.com',
            ),
            const VerticalSpeacing(20),
            const MyProfileWidget(
              title: 'Phone Number',
              subTitle: '123456789',
            ),
            const VerticalSpeacing(80),
            RoundedButton(
                title: "Edit Profile",
                onpress: () {
                  Navigator.pushNamed(
                    context,
                    RoutesName.editprofileview,
                  );
                })
          ],
        ),
      )),
    );
  }
}
