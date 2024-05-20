import 'package:data/res/components/colors.dart';
import 'package:data/res/components/vertical_speacing.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileTextField extends StatefulWidget {
  const ProfileTextField({
    super.key,
    this.hintText,
    required int maxLines,
    required this.text,
    this.controller,
    this.keyboardType,
    this.obscureText = false,
    this.validator,
    // required this.preIcon,
    // required this.preColor,
  });

  final String text;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final bool obscureText;
  final String? hintText;
  final String? Function(String?)? validator;
  // final IconData preIcon;
  // final Color preColor;
  @override
  State<ProfileTextField> createState() => _ProfileTextFieldState();
}

class _ProfileTextFieldState extends State<ProfileTextField> {
  bool hidden = true;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.text,
          style: GoogleFonts.getFont(
            "Poppins",
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Color(0xff757F8C),
            ),
          ),
        ),
        const VerticalSpeacing(8),
        TextFormField(
          keyboardType: widget.keyboardType,
          obscureText: (widget.obscureText && hidden),
          style: GoogleFonts.getFont(
            "Poppins",
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: AppColor.whiteColor,
            ),
          ),
          controller: widget.controller,
          decoration: InputDecoration(
            // border: InputBorder.none,
            hintText: widget.hintText,
            hintStyle: GoogleFonts.getFont(
              "Poppins",
              textStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: AppColor.whiteColor,
              ),
            ),
            // filled: true,
            // prefixIcon: Icon(
            //   widget.preIcon,
            //   color: widget.preColor,
            // ),
            // suffixIcon: widget.obscureText
            //     ? GestureDetector(
            //         onTap: () {
            //           setState(() => hidden = !hidden);
            //         },
            //         child: Icon(
            //           hidden
            //               ? Icons.visibility_off_outlined
            //               : Icons.visibility_outlined,
            //           color: hidden ? AppColor.whiteColor : AppColor.whiteColor,
            //           size: 30,
            //         ),
            //       )
            //     : null,
            // fillColor: Color(0xff2B2C4E),
            enabledBorder: UnderlineInputBorder(
              borderSide:
                  BorderSide(color: const Color(0xffA6AAB4).withOpacity(0.62)),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide:
                  BorderSide(color: const Color(0xffA6AAB4).withOpacity(0.62)),
            ),
          ),
          validator: widget.validator,
        ),
      ],
    );
  }
}
