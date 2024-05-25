import 'package:data/Res/components/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FundTile extends StatelessWidget {
  final String title;
  final String subTitle;
  const FundTile({
    Key? key,
    required this.title,
    required this.subTitle,
  }) : super(key: key);

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
              onPressed: () {},
              icon: const Icon(
                Icons.copy,
                color: AppColor.whiteColor,
              )),
        ),
      ],
    );
  }
}
