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
                const VerticalSpeacing(16),
                const TextFieldCustom(
                  keyboardType: TextInputType.name,
                  maxLines: 1,
                  text: 'User Name',
                  hintText: "Basit Ali",
                ),
                const VerticalSpeacing(16),
                const TextFieldCustom(
                  keyboardType: TextInputType.number,
                  maxLines: 1,
                  text: 'Phone',
                  hintText: "+912345678",
                ),
                const VerticalSpeacing(16),
                Text(
                  'Admin bank details',
                  style: GoogleFonts.getFont(
                    "Poppins",
                    textStyle: const TextStyle(
                      fontWeight: FontWeight.w400,
                      color: AppColor.whiteColor,
                      fontSize: 16.0,
                    ),
                  ),
                ),
                const VerticalSpeacing(10),
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
                const TextFieldCustom(
                  keyboardType: TextInputType.number,
                  maxLines: 1,
                  text: 'Account Number',
                  hintText: "12345678",
                ),
                const VerticalSpeacing(16),
                const TextFieldCustom(
                  keyboardType: TextInputType.number,
                  maxLines: 1,
                  text: 'Amount',
                  hintText: "150",
                ),
                const VerticalSpeacing(16),
                Text(
                  'Screen Shot',
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
                  height: 113,
                  width: 121,
                  decoration: BoxDecoration(
                    color: const Color(0xff2B2C4E),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: Center(
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.upload_outlined,
                        size: 60.0,
                        color: AppColor.whiteColor,
                      ),
                    ),
                  ),
                ),
                const VerticalSpeacing(80),
                RoundedButton(title: "Add Amount", onpress: () {}),
                const VerticalSpeacing(40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
