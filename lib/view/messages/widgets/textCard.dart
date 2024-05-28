import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data/Res/components/vertical_speacing.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../Res/components/colors.dart';

class TextCard extends StatelessWidget {
  const TextCard({
    super.key,
    required this.mesg,
    required this.date,
  });
  final String mesg;
  final Timestamp date;

  @override
  Widget build(BuildContext context) {
    DateTime dateTime = date.toDate();
    String formattedDate = DateFormat('yyyy-MM-dd').format(dateTime);
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(16.0),
            bottomLeft: Radius.circular(16.0),
            bottomRight: Radius.circular(16.0),
          ),
          color: Color(0xff2B2C4E)),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 12, right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  formattedDate,
                  style: GoogleFonts.getFont(
                    "Poppins",
                    textStyle: const TextStyle(
                      color: AppColor.whiteColor,
                      fontSize: 12.0,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16, bottom: 12),
            child: Text(
              mesg.toString(),
              style: GoogleFonts.getFont(
                "Poppins",
                textStyle: const TextStyle(
                  color: AppColor.whiteColor,
                  fontSize: 14.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
