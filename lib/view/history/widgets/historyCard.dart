import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../Res/components/colors.dart';

class HistoryCard extends StatelessWidget {
  const HistoryCard({
    super.key,
    required this.amount,
    required this.date,
  });
  final num amount;
  final Timestamp date;

  @override
  Widget build(BuildContext context) {
    DateTime dateTime = date.toDate();
    String formattedDate = DateFormat('yyyy-MM-dd').format(dateTime);
    return Card(
      color: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              amount.toStringAsFixed(2),
              style: GoogleFonts.getFont(
                "Poppins",
                textStyle: const TextStyle(
                    color: AppColor.whiteColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
              ),
            ),
            Text(
              formattedDate,
              style: GoogleFonts.getFont(
                "Poppins",
                textStyle: const TextStyle(
                    color: AppColor.whiteColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
              ),
            )
          ],
        ),
      ),
    );
  }
}
