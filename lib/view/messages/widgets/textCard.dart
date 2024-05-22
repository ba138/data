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
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(16.0),
            bottomLeft: Radius.circular(16.0),
            bottomRight: Radius.circular(16.0),
          ),
          color: Color(0xff2B2C4E)),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 12, right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "Today",
                  style: GoogleFonts.getFont(
                    "Poppins",
                    textStyle: const TextStyle(
                      color: AppColor.whiteColor,
                      fontSize: 12.0,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16, bottom: 12),
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
