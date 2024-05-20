import 'package:data/res/components/colors.dart';
import 'package:flutter/material.dart';

class GoogleContainer extends StatefulWidget {
  const GoogleContainer({super.key});

  @override
  State<GoogleContainer> createState() => _GoogleContainerState();
}

class _GoogleContainerState extends State<GoogleContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6), color: AppColor.buttonColor),
      child: Row(
        children: [
          Container(
            height: 50,
          )
        ],
      ),
    );
  }
}
