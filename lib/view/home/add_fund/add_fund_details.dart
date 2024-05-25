import 'package:data/Res/components/colors.dart';
import 'package:data/Res/components/rounded_button.dart';
import 'package:data/Res/components/vertical_speacing.dart';
import 'package:data/utils/routes/routes_name.dart';
import 'package:data/view/home/add_fund/widget/fund_details_tile.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddFundDetails extends StatefulWidget {
  const AddFundDetails({super.key});

  @override
  State<AddFundDetails> createState() => _AddFundDetailsState();
}

class _AddFundDetailsState extends State<AddFundDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Add fund details',
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
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Please make the payment mention below',
              style: GoogleFonts.getFont(
                "Poppins",
                textStyle: const TextStyle(
                    color: AppColor.whiteColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w400),
              ),
            ),
            const VerticalSpeacing(16),
            Container(
              height: MediaQuery.of(context).size.height / 1.6,
              color: const Color(0xff2B2C4E),
              child: Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: ListView.builder(
                  itemCount:
                      10, // Number of times the FundTile should be repeated
                  itemBuilder: (context, index) {
                    return const FundTile();
                  },
                ),
              ),
            ),
            const VerticalSpeacing(16),
            RoundedButton(
                title: "Add Fund Setails",
                onpress: () {
                  Navigator.pushNamed(
                    context,
                    RoutesName.addFund,
                  );
                })
          ],
        ),
      )),
    );
  }
}
