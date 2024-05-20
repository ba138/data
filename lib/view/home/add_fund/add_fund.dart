import 'package:data/res/components/colors.dart';
import 'package:data/res/components/custom_text_field.dart';
import 'package:data/res/components/rounded_button.dart';
import 'package:data/res/components/vertical_speacing.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddFund extends StatefulWidget {
  const AddFund({super.key});

  @override
  State<AddFund> createState() => _AddFundState();
}

class _AddFundState extends State<AddFund> {
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
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Admin banck details',
                  style: GoogleFonts.getFont(
                    "Poppins",
                    textStyle: const TextStyle(
                      color: AppColor.whiteColor,
                      fontSize: 16.0,
                    ),
                  ),
                ),
                const VerticalSpeacing(10),
                Container(
                  height: 42,
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
                      dropdownColor: Colors.transparent,
                      value: selectPaymentType,
                      underline: const SizedBox(),
                      icon: const Icon(Icons.expand_more_outlined),
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
                const TextFieldCustom(
                  maxLines: 1,
                  text: 'Account Number',
                  hintText: "12345678",
                ),
                const VerticalSpeacing(100),
                RoundedButton(title: "Add Amount", onpress: () {})
              ],
            ),
          ),
        ),
      ),
    );
  }
}