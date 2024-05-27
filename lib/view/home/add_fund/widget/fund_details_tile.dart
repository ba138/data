import 'package:data/Res/components/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FundTile extends StatelessWidget {
  final String title;
  final String subTitle;
  final Function onCopy;
  const FundTile({
    super.key,
    required this.title,
    required this.subTitle,
    required this.onCopy,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(
            title,
            style: GoogleFonts.getFont(
              "Poppins",
              textStyle: const TextStyle(
                  color: AppColor.whiteColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w400),
            ),
          ),
          subtitle: Text(
            subTitle,
            style: GoogleFonts.getFont(
              "Poppins",
              textStyle: const TextStyle(
                  color: AppColor.whiteColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w400),
            ),
          ),
          trailing: IconButton(
              onPressed: () {
                onCopy();
              },
              icon: const Icon(
                Icons.copy,
                color: AppColor.whiteColor,
              )),
        ),
      ],
    );
  }
}
