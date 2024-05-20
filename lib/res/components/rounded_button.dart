import 'package:flutter/material.dart';
import 'package:data/res/components/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class RoundedButton extends StatelessWidget {
  final String title;
  final bool loading;
  final VoidCallback onpress;

  const RoundedButton({
    super.key,
    required this.title,
    required this.onpress,
    this.loading = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onpress,
      child: Container(
        height: 56.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6.0),
          color: AppColor.buttonColor,
          boxShadow: [
            BoxShadow(
              color: const Color(0xff613EEA).withOpacity(0.32),
              blurRadius: 20,
              offset: const Offset(0, 8), // changes position of shadow
            ),
          ],
        ),
        child: Center(
          child: loading
              ? const CircularProgressIndicator(
                  color: AppColor.whiteColor,
                )
              : Text(
                  title,
                  style: GoogleFonts.getFont(
                    "Poppins",
                    textStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: AppColor.whiteColor,
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
