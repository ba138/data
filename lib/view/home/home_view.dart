import 'package:flutter/material.dart';

import 'widgets/trianglePainter.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Column(
      children: [
        SizedBox(
          height: 262.0,
          width: double.infinity,
          child: Stack(
            children: [
              CustomPaint(
                painter: TrianglePainter(),
                size: const Size(double.infinity, 262.0),
              ),
              const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Text 1', style: TextStyle(color: Colors.white)),
                  Text('Text 2', style: TextStyle(color: Colors.white)),
                ],
              ),
            ],
          ),
        ),
      ],
    )));
  }
}
