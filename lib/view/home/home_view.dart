import 'package:data/res/components/colors.dart';
import 'package:data/res/components/vertical_speacing.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'widgets/trianglePainter.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
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
                  ListTile(
                    leading: const CircleAvatar(
                      radius: 40.0,
                      backgroundImage: NetworkImage(
                          'https://images.pexels.com/photos/415829/pexels-photo-415829.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500'),
                    ),
                    title: Text(
                      'Alizay Khan',
                      style: GoogleFonts.getFont(
                        "Poppins",
                        textStyle: const TextStyle(
                          color: AppColor.whiteColor,
                        ),
                      ),
                    ),
                    subtitle: Text(
                      'Welcome',
                      style: GoogleFonts.getFont(
                        "Poppins",
                        textStyle: const TextStyle(
                          color: AppColor.whiteColor,
                        ),
                      ),
                    ),
                    trailing: Container(
                      height: 30,
                      width: 30,
                      decoration: const BoxDecoration(
                          color: AppColor.whiteColor, shape: BoxShape.circle),
                      child: const Center(
                        child: Icon(
                          Icons.notifications,
                          color: AppColor.blackColor,
                        ),
                      ),
                    ),
                  ),
                  const VerticalSpeacing(14.0),
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
        ),
        const VerticalSpeacing(20.0),
        Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Subscrptions',
                style: GoogleFonts.getFont(
                  "Poppins",
                  textStyle: const TextStyle(
                    color: AppColor.whiteColor,
                    fontSize: 16.0,
                  ),
                ),
              ),
              Text(
                'Vew all',
                style: GoogleFonts.getFont(
                  "Poppins",
                  textStyle: const TextStyle(
                    color: AppColor.whiteColor,
                    fontSize: 16.0,
                  ),
                ),
              ),
            ],
          ),
        ),
        const VerticalSpeacing(20.0),
        Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0),
          child: Column(
            children: [
              Container(
                height: 156,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Color(0xff3F30BD),
                ),
              ),
            ],
          ),
        ),
      ],
    )));
  }
}
