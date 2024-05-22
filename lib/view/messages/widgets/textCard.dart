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
      height: 110,
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          color: const Color(0xff2B2C4E)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Center(
              child: Text.rich(
                TextSpan(
                  text: 'Lorem ipsum dolor sit amet, consec.Lorem\n',
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
                      text: 'Lorem ipsum dolor sit amet,\n',
                      style: GoogleFonts.getFont(
                        "Poppins",
                        textStyle: const TextStyle(
                          color: AppColor.whiteColor,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    TextSpan(
                      text: 'Lorem ipsum dolor sit amet,ipsum\n',
                      style: GoogleFonts.getFont(
                        "Poppins",
                        textStyle: const TextStyle(
                          color: AppColor.whiteColor,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
