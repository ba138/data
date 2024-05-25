import 'package:data/Res/components/colors.dart';
import 'package:data/Res/components/vertical_speacing.dart';
import 'package:data/utils/routes/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'widgets/subscribtion_Card.dart';
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
            clipBehavior: Clip.none,
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
                    leading: InkWell(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          RoutesName.profile,
                        );
                      },
                      child: const CircleAvatar(
                        radius: 40.0,
                        backgroundImage: NetworkImage(
                            'https://images.pexels.com/photos/415829/pexels-photo-415829.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500'),
                      ),
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
                    trailing: InkWell(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          RoutesName.myprofileview,
                        );
                      },
                      child: Container(
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
                  ),
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
                      Column(
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                context,
                                RoutesName.addfunddetails,
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColor.buttonColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: const Text(
                              'Add Fund',
                              style: TextStyle(color: AppColor.whiteColor),
                            ),
                          ),
                          const VerticalSpeacing(16.0),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, RoutesName.withdrawFund);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColor.whiteColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: const Text(
                              'Withdraw',
                              style: TextStyle(color: AppColor.blackColor),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              Positioned(
                bottom: -50, // Adjust this value as needed
                left: MediaQuery.of(context).size.width / 3 -
                    100, // Centers the container horizontally
                child: Container(
                  height: 80,
                  width: 327,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        Color(0xFF3EEAAC),
                        Color(0xFF613EEA),
                      ],
                    ),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x33000000),
                        offset: Offset(4, 4),
                        blurRadius: 6,
                        spreadRadius: 4,
                      ),
                    ],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text.rich(
                      TextSpan(
                          text: '5% increase  every month\n',
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
                              text: '  if you deposit amount',
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
                  ),
                ),
              ),
            ],
          ),
        ),
        const VerticalSpeacing(73.0),
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
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, RoutesName.allSubscriptionView);
                },
                child: Text(
                  'Vew all',
                  style: GoogleFonts.getFont(
                    "Poppins",
                    textStyle: const TextStyle(
                      color: AppColor.whiteColor,
                      fontSize: 16.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const VerticalSpeacing(20.0),
        Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0),
          child: SizedBox(
            height: MediaQuery.of(context).size.height / 2,
            child: const SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  SubscribtionCard(bgColor: Color(0xff3F30BD)),
                  VerticalSpeacing(16.0),
                  SubscribtionCard(bgColor: Color(0xff3B8FE9)),
                  VerticalSpeacing(16.0),
                  SubscribtionCard(bgColor: Color(0xff30BD82)),
                ],
              ),
            ),
          ),
        ),
      ],
    )));
  }
}
