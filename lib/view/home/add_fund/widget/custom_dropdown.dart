import 'package:data/Res/components/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomDropdown extends StatefulWidget {
  const CustomDropdown({super.key});

  @override
  State<CustomDropdown> createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  String doctorLanguage = "UPI Bank";

  @override
  Widget build(BuildContext context) {
    return Container(
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
          value: doctorLanguage,
          underline: const SizedBox(),
          icon: const Icon(Icons.expand_more_outlined),
          iconSize: 24,
          elevation: 16,
          // Replace with your desired color
          onChanged: (String? newValue) {
            setState(() {
              doctorLanguage = newValue!;
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
    );
  }
}
