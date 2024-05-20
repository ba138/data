import 'package:flutter/material.dart';
import 'package:data/res/components/colors.dart';

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
                  style: const TextStyle(
                    color: AppColor.whiteColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
        ),
      ),
    );
  }
}
