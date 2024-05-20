import 'package:data/res/components/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../res/components/colors.dart';
import '../../res/components/vertical_speacing.dart';
import '../home/widgets/trianglePainter.dart';

class WithdrawFundsView extends StatelessWidget {
  const WithdrawFundsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 262.0,
              width: double.infinity,
              child: Stack(
                children: [
                  CustomPaint(
                    painter: TrianglePainter(),
                    size: const Size(double.infinity, 262.0),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const VerticalSpeacing(30),
                      Row(
                        children: [
                          IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: const Icon(
                                Icons.west,
                                color: AppColor.whiteColor,
                              )),
                          const SizedBox(width: 100.0),
                          const Text(
                            'Withdraw Amount',
                            style: TextStyle(color: AppColor.whiteColor),
                          ),
                        ],
                      ),
                      const VerticalSpeacing(50.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              Text(
                                'Total Balance',
                                style: GoogleFonts.getFont(
                                  "Poppins",
                                  textStyle: const TextStyle(
                                      color: AppColor.whiteColor,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                              const VerticalSpeacing(5.0),
                              Text(
                                '\$140.00',
                                style: GoogleFonts.getFont(
                                  "Poppins",
                                  textStyle: const TextStyle(
                                    color: AppColor.whiteColor,
                                    fontSize: 40.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const VerticalSpeacing(50.0),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0),
              child: RoundedButton(title: 'Withdraw Amount', onpress: () {}),
            )
          ],
        ),
      ),
    );
  }
}
