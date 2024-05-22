import 'package:data/res/components/colors.dart';
import 'package:data/res/components/rounded_button.dart';
import 'package:data/res/components/vertical_speacing.dart';
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
  String selectPaymentType = "UPI Bank";

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
            Container(
              height: 50,
              color: const Color(0xff2B2C4E),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: DropdownButton<String>(
                  isExpanded: true,
                  style: GoogleFonts.getFont(
                    "Poppins",
                    textStyle: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: AppColor.whiteColor,
                    ),
                  ),
                  dropdownColor: const Color(0xff191A2F),
                  value: selectPaymentType,
                  underline: const SizedBox(),
                  icon: const Icon(
                    Icons.expand_more_outlined,
                    color: AppColor.whiteColor,
                  ),
                  iconSize: 24,
                  elevation: 16,
                  // Replace with your desired color
                  onChanged: (String? newValue) {
                    setState(() {
                      selectPaymentType = newValue!;
                    });
                  },
                  items: <String>[
                    'UPI Bank',
                    'WALLET',
                    'CARD',
                  ] // Add more options as needed
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
            ),
            const VerticalSpeacing(16),
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
              height: MediaQuery.of(context).size.height / 2.4,
              color: const Color(0xff2B2C4E),
              child: const Padding(
                  padding: EdgeInsets.only(top: 16.0),
                  child: Column(
                    children: [
                      FundTile(
                        title: 'Beneficiary Name',
                        subTitle: 'Hiren',
                      ),
                      VerticalSpeacing(16),
                      FundTile(
                        title: 'Bank Name',
                        subTitle: 'UPI',
                      ),
                      VerticalSpeacing(16),
                      FundTile(
                        title: 'Account Number',
                        subTitle: '12345678',
                      ),
                    ],
                  )),
            ),
            const VerticalSpeacing(30),
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
