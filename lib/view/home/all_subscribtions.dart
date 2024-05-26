import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data/Res/components/colors.dart';
import 'package:data/Res/components/loading_manager.dart';
import 'package:data/view/home/widgets/subscribtion_Card.dart';
import 'package:flutter/material.dart';

class AllSubscribtionsView extends StatefulWidget {
  const AllSubscribtionsView({super.key});

  @override
  State<AllSubscribtionsView> createState() => _AllSubscribtionsViewState();
}

class _AllSubscribtionsViewState extends State<AllSubscribtionsView> {
  final _firestoreInstance = FirebaseFirestore.instance;
  final List _allsubscrbtions = [];
  bool _isLoading = false;
  fetchallSubscribtions() async {
    try {
      setState(() {
        _isLoading = true;
      });
      QuerySnapshot qn =
          await _firestoreInstance.collection('Subscriptions').get();
      setState(() {
        for (int i = 0; i < qn.docs.length; i++) {
          _allsubscrbtions.add({
            'charges': qn.docs[i]['charges'],
            'date': qn.docs[i]['date'],
            'duration': qn.docs[i]['duration'],
            'uuid': qn.docs[i]['uuid'],
          });
        }
      });
      return qn.docs;
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    fetchallSubscribtions();

    super.initState();
  }

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
      body: LoadingManager(
        isLoading: _isLoading,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
          child: ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _allsubscrbtions.length,
            itemBuilder: (context, index) {
              final subscription = _allsubscrbtions[index];
              return SubscribtionCard(
                bgColor: const Color(0xff30BD82),
                charge: subscription['charges'],
                date: subscription['date'],
                duration: subscription['duration'],
                ontapSubscribe: () {},
              );
            },
            separatorBuilder: (context, index) => const SizedBox(height: 10.0),
          ),
        ),
      ),
    );
  }
}
