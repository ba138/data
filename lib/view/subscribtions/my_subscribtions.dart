import 'package:data/res/components/vertical_speacing.dart';
import 'package:data/view/subscribtions/widgets/mysubscribtionCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../res/components/colors.dart';

class MySubscribtions extends StatelessWidget {
  const MySubscribtions({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'my Subscribtions',
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
        padding: const EdgeInsets.only(left: 16.0, right: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const VerticalSpeacing(30.0),
            const MySubscribtionCard(bgColor: AppColor.buttonColor),
            const VerticalSpeacing(46.0),
            Center(
              child: Text.rich(
                TextSpan(
                  text: '41% off only for you. To get this payment\n',
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
                      text: 'collect and apply, fund ',
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
            const VerticalSpeacing(46.0),
            Row(
              children: [
                Container(
                  height: 5,
                  width: 20,
                  color: AppColor.buttonColor,
                ),
                const SizedBox(width: 10),
                Text(
                  '6 month regular use',
                  style: GoogleFonts.getFont(
                    "Poppins",
                    textStyle: const TextStyle(
                        color: AppColor.whiteColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w400),
                  ),
                )
              ],
            ),
            const VerticalSpeacing(20.0),
            Row(
              children: [
                Container(
                  height: 5,
                  width: 20,
                  color: AppColor.buttonColor,
                ),
                const SizedBox(width: 10),
                Text(
                  'always fund , withdraw money',
                  style: GoogleFonts.getFont(
                    "Poppins",
                    textStyle: const TextStyle(
                        color: AppColor.whiteColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ],
            ),
            const VerticalSpeacing(20.0),
            Text(
              'Exp 12/12/2020',
              style: GoogleFonts.getFont(
                "Poppins",
                textStyle: const TextStyle(
                    color: AppColor.whiteColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
