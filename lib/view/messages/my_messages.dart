import 'package:data/res/components/vertical_speacing.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../res/components/colors.dart';
import 'widgets/textCard.dart';

class MyMessages extends StatelessWidget {
  const MyMessages({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'my messages',
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
      body: const SafeArea(
          child: Padding(
        padding: EdgeInsets.only(left: 16.0, right: 16.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              VerticalSpeacing(30.0),
              TextCard(),
              VerticalSpeacing(16.0),
              TextCard(),
              VerticalSpeacing(16.0),
              TextCard(),
              VerticalSpeacing(16.0),
              TextCard(),
              VerticalSpeacing(16.0),
              TextCard(),
              VerticalSpeacing(16.0),
              TextCard(),
              VerticalSpeacing(16.0),
              TextCard(),
              VerticalSpeacing(16.0),
              TextCard(),
              VerticalSpeacing(16.0),
            ],
          ),
        ),
      )),
    );
  }
}
