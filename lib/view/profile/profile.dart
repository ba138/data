import 'package:data/Res/components/colors.dart';
import 'package:data/Res/components/vertical_speacing.dart';
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
                  ),
                ],
              ),
              const VerticalSpeacing(16.0),
              Text.rich(
                TextSpan(
                    text: '  Hasnain Haider\n',
                    style: GoogleFonts.getFont(
                      "Poppins",
                      textStyle: const TextStyle(
                        color: AppColor.whiteColor,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    children: [
                      TextSpan(
                        text: 'hasnain@gmail.com',
                        style: GoogleFonts.getFont(
                          "Poppins",
                          textStyle: const TextStyle(
                            color: AppColor.whiteColor,
                            fontSize: 16.0,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ]),
              ),
              const VerticalSpeacing(46),
              ProfileWidgets(
                  ontap: () {
                    Navigator.pushNamed(
                      context,
                      RoutesName.myprofileview,
                    );
                  },
                  tColor: const Color(0xff40C269),
                  bColor: const Color(0xffCDFF9D),
                  icon: Icons.person_outline,
                  trIcon: Icons.arrow_forward_ios,
                  title: 'My Profile'),
              const Divider(),
              ProfileWidgets(
                  ontap: () {
                    Navigator.pushNamed(context, RoutesName.mymessages);
                  },
                  tColor: const Color(0xff46C5CA),
                  bColor: const Color(0xff6DF5FC),
                  icon: Icons.message_outlined,
                  trIcon: Icons.arrow_forward_ios,
                  title: 'My Messages'),
              const Divider(),
              ProfileWidgets(
                  ontap: () {
                    Navigator.pushNamed(context, RoutesName.mySubscribtions);
                  },
                  tColor: const Color(0xffA24ABF),
                  bColor: const Color(0xffDF9EF5),
                  icon: Icons.card_giftcard_outlined,
                  trIcon: Icons.arrow_forward_ios,
                  title: 'My subscribtions'),
              const Divider(),
              ProfileWidgets(
                  ontap: () {
                    Navigator.pushNamed(context, RoutesName.logoIn);
                  },
                  tColor: const Color(0xffFF9CCB),
                  bColor: const Color(0xffEC4091),
                  icon: Icons.logout_outlined,
                  trIcon: Icons.arrow_forward_ios,
                  title: 'Log Out'),
              const Divider(),
            ],
          ),
        ),
      ),
    );
  }
}
