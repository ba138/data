import 'package:data/res/components/colors.dart';
import 'package:data/res/components/vertical_speacing.dart';
import 'package:data/utils/routes/routes_name.dart';
import 'package:data/view/profile/widget/profile_text_field.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'User Profile',
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const VerticalSpeacing(10),
              Stack(
                children: [
                  const CircleAvatar(
                    radius: 40,
                    backgroundColor: AppColor.whiteColor,
                    backgroundImage: NetworkImage(
                        "https://images.pexels.com/photos/415829/pexels-photo-415829.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500"),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 2,
                    child: Container(
                      height: 22,
                      width: 22,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: AppColor.buttonColor),
                      child: const Center(
                          child: Icon(
                        Icons.edit_note_outlined,
                        color: AppColor.whiteColor,
                        size: 14,
                      )),
                    ),
                  )
                ],
              ),
              const VerticalSpeacing(24),
              const ProfileTextField(
                maxLines: 1,
                text: "Full name",
                hintText: "Basit Ali",
              ),
              const VerticalSpeacing(24),
              const ProfileTextField(
                maxLines: 1,
                text: "Email address",
                hintText: "BasitAlyShah51214@gmail.com",
              ),
              const VerticalSpeacing(24),
              const ProfileTextField(
                maxLines: 1,
                text: "Phone number",
                hintText: "123456789",
              ),
              const VerticalSpeacing(24),
              InkWell(
                onTap: () {
                  Navigator.pushNamedAndRemoveUntil(
                      context, RoutesName.logoIn, (route) => false);
                },
                child: Row(
                  children: [
                    const Icon(
                      Icons.logout_outlined,
                      color: AppColor.whiteColor,
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    Text(
                      "Log Out",
                      style: GoogleFonts.getFont(
                        "Poppins",
                        textStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: AppColor.whiteColor,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
