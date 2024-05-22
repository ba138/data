import 'package:data/view/home/widgets/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../res/components/colors.dart';
import '../../../res/components/vertical_speacing.dart';

class MySubscribtionCard extends StatelessWidget {
  const MySubscribtionCard({
    super.key,
    required this.bgColor,
  });
  final Color bgColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 156,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: bgColor,
      ),
      child: Stack(
        children: [
          Center(
            child: CustomPaint(
              size: const Size(1, 156),
              painter: DottedLinePainter(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const VerticalSpeacing(20.0),
                    Text(
                      'Popular',
                      style: GoogleFonts.getFont(
                        "Poppins",
                        textStyle: const TextStyle(
                          color: AppColor.whiteColor,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    Text(
                      '6 month',
                      style: GoogleFonts.getFont(
                        "Poppins",
                        textStyle: const TextStyle(
                          color: AppColor.whiteColor,
                          fontSize: 24.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const VerticalSpeacing(30.0),
                    Text(
                      '\$3500',
                      style: GoogleFonts.getFont(
                        "Poppins",
                        textStyle: const TextStyle(
                          color: AppColor.whiteColor,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColor.whiteColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          'Active',
                          style: TextStyle(color: AppColor.buttonColor),
                        ),
                      ),
                      Text(
                        'Exp-23/12/2024',
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
