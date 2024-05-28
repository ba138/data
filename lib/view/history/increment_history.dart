import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data/view/history/widgets/historyCard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../Res/components/colors.dart';

class IncrementHistory extends StatelessWidget {
  IncrementHistory({super.key});
  final ScrollController _scrollController = ScrollController();
  User? user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Increment History',
          style: GoogleFonts.getFont(
            "Poppins",
            textStyle: const TextStyle(
                color: AppColor.whiteColor,
                fontSize: 16,
                fontWeight: FontWeight.w400),
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.west,
            color: AppColor.whiteColor,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0),
          child: Column(
            children: [
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("users")
                      .doc(user!.uid)
                      .collection('IncrementHistory')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text(
                        'Error: ${snapshot.error}',
                        style: const TextStyle(color: AppColor.whiteColor),
                      );
                    }

                    if (!snapshot.hasData) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    final documents = snapshot.data!.docs;
                    // Check if there are any documents
                    if (documents.isEmpty) {
                      return const Center(
                        child: Text(
                          'No History',
                          style: TextStyle(color: AppColor.whiteColor),
                        ),
                      );
                    }
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      _scrollController.animateTo(
                        _scrollController.position.maxScrollExtent,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeOut,
                      );
                    });

                    return ListView.separated(
                      shrinkWrap: true,
                      controller: _scrollController,
                      itemCount: documents.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        final bankDetails =
                            documents[index].data() as Map<String, dynamic>;
                        // final String deposit = bankDetails['Action'] ?? '';
                        final Timestamp date = bankDetails['date'] ?? '';
                        final num amount = bankDetails['amount'] ?? '';

                        return HistoryCard(amount: amount, date: date);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
