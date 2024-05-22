import 'package:flutter/material.dart';

import '../../../res/components/colors.dart';

class ProfileWidgets extends StatelessWidget {
  const ProfileWidgets({
    super.key,
    required this.tColor,
    required this.bColor,
    required this.icon,
    required this.trIcon,
    required this.title,
    required this.ontap,
  });
  final Color tColor;
  final Color bColor;
  final IconData icon;
  final IconData trIcon;
  final String title;
  final Function() ontap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: ListTile(
        leading: Container(
          height: 40.0,
          width: 40.0,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [tColor, tColor],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: const [0.0, 1.0],
            ),
          ),
          child: Center(
            child: Icon(
              icon,
              color: AppColor.whiteColor,
            ),
          ),
        ),
        titleAlignment: ListTileTitleAlignment.threeLine,
        title: Text(
          title,
          style: TextStyle(color: AppColor.whiteColor),
        ),
        trailing: Icon(
          trIcon,
          color: AppColor.whiteColor,
        ),
      ),
    );
  }
}
