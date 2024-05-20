import 'package:data/res/components/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
              Padding(
                padding: EdgeInsets.only(left: 20.0, right: 20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        radius: 40.0,
                        backgroundImage: NetworkImage(
                            'https://images.pexels.com/photos/415829/pexels-photo-415829.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500'),
                      ),
                      title: Text('Alizay Khan'),
                      subtitle: Text('Welcome'),
                      trailing: Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                            color: AppColor.whiteColor, shape: BoxShape.circle),
                        child: Center(
                          child: Icon(
                            Icons.notifications,
                            color: AppColor.blackColor,
                          ),
                        ),
                      ),
                    ),
                    Text('Text 1', style: TextStyle(color: Colors.white)),
                    Text('Text 2', style: TextStyle(color: Colors.white)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    )));
  }
}
