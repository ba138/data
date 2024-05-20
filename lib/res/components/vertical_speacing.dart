import 'package:flutter/material.dart';

class VerticalSpeacing extends StatelessWidget {
  const VerticalSpeacing(this.height, {super.key});

  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
    );
  }
}
