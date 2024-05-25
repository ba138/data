// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:data/Res/components/colors.dart';
import 'package:data/Res/components/vertical_speacing.dart';

class MyProfileWidget extends StatelessWidget {
  const MyProfileWidget({
    super.key,
    required this.title,
    required this.subTitle,
  });
  final String title;
  final String subTitle;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.getFont(
            "Poppins",
            textStyle: const TextStyle(
                color: AppColor.whiteColor,
                fontSize: 16,
                fontWeight: FontWeight.w400),
          ),
        ),
        const VerticalSpeacing(8),
        Text(
          subTitle,
          style: GoogleFonts.getFont(
            "Poppins",
            textStyle: const TextStyle(
                color: Color(0xff898989),
                fontSize: 14,
                fontWeight: FontWeight.w400),
          ),
        ),
        const VerticalSpeacing(16),
        const Divider(
          color: AppColor.whiteColor,
        )
      ],
    );
  }
}
