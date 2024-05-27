import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data/Res/components/custom_text_field.dart';
import 'package:data/Res/components/loading_manager.dart';
import 'package:data/Res/components/rounded_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uuid/uuid.dart';

import '../../Res/components/colors.dart';
import '../../Res/components/vertical_speacing.dart';
import '../../utils/routes/routes_name.dart';
import '../../utils/routes/utils.dart';
import '../home/widgets/trianglePainter.dart';

class WithdrawFundsView extends StatefulWidget {
  const WithdrawFundsView({super.key});

  @override
  State<WithdrawFundsView> createState() => _WithdrawFundsViewState();
}

class _WithdrawFundsViewState extends State<WithdrawFundsView> {
  TextEditingController nameController = TextEditingController();
  TextEditingController accountController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController bankController = TextEditingController();
  bool _isLoading = false;
  num? _totalAmount;
  final User? user = FirebaseAuth.instance.currentUser;
  final FirebaseFirestore _firestoreInstance = FirebaseFirestore.instance;
  List<Map<String, dynamic>> _bankDetails = [];
  String? _selectedBankName;
  @override
  void initState() {
    super.initState();
    getBankDetails();
  }

  getBankDetails() async {
    try {
      setState(() {
        _isLoading = true;
      });

      QuerySnapshot qn =
          await _firestoreInstance.collection('BankDetails').get();
      List<Map<String, dynamic>> bankDetails = [];
      for (var doc in qn.docs) {
        bankDetails.add({
          'accountHolderName': doc['accountHolderName'],
          'accountNumber': doc['accountNumber'],
          'bankName': doc['bankName'],
          'uuid': doc['uuid'],
        });
      }

      setState(() {
        _bankDetails = bankDetails;
        if (_bankDetails.isNotEmpty) {
          _selectedBankName = _bankDetails[0]['bankName'];
        }
      });
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void withDrawFun() async {
    if (nameController.text.isEmpty ||
        accountController.text.isEmpty ||
        amountController.text.isEmpty) {
      Utils.toastMessage('Please fill all the fields');
      return;
    }

    final User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      Utils.flushBarErrorMessage('Please login first', context);
      return;
    }

    setState(() {
      _isLoading = true;
    });

    final DocumentSnapshot userDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser.uid)
        .get();

    final totalBalance = userDoc.get('balance') ?? 0;
    final requestBalance = double.tryParse(amountController.text) ?? 0.0;

    if (requestBalance != totalBalance) {
      setState(() {
        _isLoading = false;
      });
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Insufficient Balance'),
            content: const Text(
                'Your current balance is less than the withdraw request.\nplease add funds'),
            actions: <Widget>[
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
      return;
    }

    try {
      var uuid = const Uuid().v1();
      final currentuser = FirebaseAuth.instance.currentUser;
      if (currentuser != null) {
        await FirebaseFirestore.instance
            .collection('withdraw_requests')
            .doc(uuid)
            .set({
          'Total Balance': totalBalance,
          'AccountHolderName': nameController.text,
          'PaymentType': _selectedBankName,
          'AccountNumber': accountController.text,
          'Request balance': requestBalance,
          'uuId': uuid,
          'currentUserId': currentuser.uid,
          'date': DateTime.now(),
        });
        Navigator.pushNamedAndRemoveUntil(
            context, RoutesName.home, (route) => false);

        Utils.toastMessage('Successfully Submitted Request');
      } else {
        Utils.toastMessage('No current user found');
      }
    } catch (e) {
      Utils.toastMessage('Failed to add: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoadingManager(
        isLoading: _isLoading,
        child: SafeArea(
          child: SingleChildScrollView(
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
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const VerticalSpeacing(30),
                          Row(
                            children: [
                              IconButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  icon: const Icon(
                                    Icons.west,
                                    color: AppColor.whiteColor,
                                  )),
                              const SizedBox(width: 100.0),
                              const Text(
                                'Withdraw Amount',
                                style: TextStyle(color: AppColor.whiteColor),
                              ),
                            ],
                          ),
                          const VerticalSpeacing(50.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    'Total Balance',
                                    style: GoogleFonts.getFont(
                                      "Poppins",
                                      textStyle: const TextStyle(
                                          color: AppColor.whiteColor,
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                  const VerticalSpeacing(5.0),
                                  StreamBuilder<DocumentSnapshot>(
                                      stream: FirebaseFirestore.instance
                                          .collection('users')
                                          .doc(user?.uid)
                                          .snapshots(),
                                      builder: (context, snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return const CircularProgressIndicator();
                                        }
                                        if (snapshot.hasError) {
                                          return Text(
                                              'Error: ${snapshot.error}');
                                        }
                                        if (!snapshot.hasData ||
                                            !snapshot.data!.exists) {
                                          return const Text('N/A');
                                        }

                                        final userDoc = snapshot.data!;
                                        _totalAmount =
                                            userDoc.get('balance') ?? 0;

                                        return Text(
                                          _totalAmount != null
                                              ? '₹$_totalAmount'
                                              : 'N/A',
                                          style: GoogleFonts.getFont(
                                            "Poppins",
                                            textStyle: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 30.0,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        );
                                      }),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const VerticalSpeacing(16),
                      TextFieldCustom(
                        keyboardType: TextInputType.name,
                        controller: nameController,
                        maxLines: 1,
                        text: 'Account Holder Name',
                        hintText: "Enter Your Name",
                      ),
                      const VerticalSpeacing(16),
                      Text(
                        'Select Bank',
                        style: GoogleFonts.getFont(
                          "Poppins",
                          textStyle: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: AppColor.whiteColor,
                          ),
                        ),
                      ),
                      const VerticalSpeacing(10),
                      Container(
                        height: 50,
                        color: const Color(0xff2B2C4E),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: DropdownButton<String>(
                            isExpanded: true,
                            style: GoogleFonts.getFont(
                              "Poppins",
                              textStyle: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                              ),
                            ),
                            dropdownColor: const Color(0xff191A2F),
                            value: _selectedBankName,
                            underline: const SizedBox(),
                            icon: const Icon(
                              Icons.expand_more_outlined,
                              color: Colors.white,
                            ),
                            iconSize: 24,
                            elevation: 16,
                            onChanged: (String? newValue) {
                              setState(() {
                                _selectedBankName = newValue!;
                              });
                            },
                            items: _bankDetails.map<DropdownMenuItem<String>>(
                                (Map<String, dynamic> value) {
                              return DropdownMenuItem<String>(
                                value: value['bankName'],
                                child: Text(value['bankName']),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                      const VerticalSpeacing(16),
                      TextFieldCustom(
                        keyboardType: TextInputType.number,
                        controller: accountController,
                        maxLines: 1,
                        text: 'Account Number',
                        hintText: "*******",
                      ),
                      const VerticalSpeacing(16),
                      TextFieldCustom(
                        keyboardType: TextInputType.number,
                        controller: amountController,
                        maxLines: 1,
                        text: 'Amount',
                        hintText: "150",
                      ),
                      const VerticalSpeacing(50),
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                        child: RoundedButton(
                          title: 'Withdraw Amount',
                          onpress: withDrawFun,
                        ),
                      ),
                    ],
                  ),
                ),
                const VerticalSpeacing(40.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
