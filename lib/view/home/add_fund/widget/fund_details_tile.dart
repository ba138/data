import 'package:data/Res/components/colors.dart';
import 'package:data/Res/components/vertical_speacing.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FundTile extends StatelessWidget {
  const FundTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(
            'UPI',
            style: GoogleFonts.getFont(
              "Poppins",
              textStyle: const TextStyle(
                  color: AppColor.whiteColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w400),
            ),
          ),
          subtitle: Text(
            '2345895432398543456977888',
            style: GoogleFonts.getFont(
              "Poppins",
              textStyle: const TextStyle(
                  color: AppColor.whiteColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w400),
            ),
          ),
          trailing: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.copy,
                color: AppColor.whiteColor,
              )),
        ),
        const VerticalSpeacing(8),
        const Divider(
          color: AppColor.whiteColor,
        ),
      ],
    );
  }
}
