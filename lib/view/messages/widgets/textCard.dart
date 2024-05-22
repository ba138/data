import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../res/components/colors.dart';

class TextCard extends StatelessWidget {
  const TextCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          color: const Color(0xff2B2C4E)),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              "Lorem ipsum dolor sit amet, consec.Lorem Lorem ipsum dolor sit amet, consec.Lorem Lorem ipsum dolor sit amet, consec.Lorem Lorem ipsum dolor sit amet, consec.Lorem",
              style: GoogleFonts.getFont(
                "Poppins",
                textStyle: const TextStyle(
                  color: AppColor.whiteColor,
                  fontSize: 14.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
