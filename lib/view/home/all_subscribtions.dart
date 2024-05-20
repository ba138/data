import 'package:data/res/components/colors.dart';
import 'package:data/res/components/vertical_speacing.dart';
import 'package:data/view/home/widgets/subscribtion_Card.dart';
import 'package:flutter/material.dart';

class AllSubscribtionsView extends StatelessWidget {
  const AllSubscribtionsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.west,
              color: AppColor.whiteColor,
            )),
        title: const Text(
          'Subscribtions',
          style: TextStyle(color: AppColor.whiteColor),
        ),
        centerTitle: true,
      ),
      body: const Padding(
        padding: EdgeInsets.only(left: 20.0, right: 20.0),
        child: Column(
          children: [
            VerticalSpeacing(30.0),
            SubscribtionCard(bgColor: Color(0xff3F30BD)),
            VerticalSpeacing(16.0),
            SubscribtionCard(bgColor: Color(0xff3B8FE9)),
            VerticalSpeacing(16.0),
            SubscribtionCard(bgColor: Color(0xff30BD82)),
            VerticalSpeacing(16.0),
            SubscribtionCard(bgColor: Color(0xff30BD82)),
          ],
        ),
      ),
    );
  }
}
