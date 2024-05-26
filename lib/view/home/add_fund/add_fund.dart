// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data/Res/components/colors.dart';
import 'package:data/Res/components/custom_text_field.dart';
import 'package:data/Res/components/rounded_button.dart';
import 'package:data/Res/components/vertical_speacing.dart';
import 'package:data/res/components/common_firebase_storage.dart';
import 'package:data/res/components/loading_manager.dart';
import 'package:data/utils/routes/routes_name.dart';
import 'package:data/utils/routes/utils.dart';
import 'package:data/view/messages/widgets/image_picker_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uuid/uuid.dart';

class AddFund extends StatefulWidget {
  const AddFund({super.key});

  @override
  State<AddFund> createState() => _AddFundState();
}

class _AddFundState extends State<AddFund> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController accountNumberController = TextEditingController();
  TextEditingController balanceController = TextEditingController();

  final FirebaseFirestore _firestoreInstance = FirebaseFirestore.instance;
  bool isLoading = false;
  List<Map<String, dynamic>> _bankDetails = [];
  String? _selectedBankName;
  Map<String, dynamic>? selectedBankDetail;
  File? image;
  void pickImage() async {
    final pickedImage = await pickImageFromGallery(context);

    setState(() {
      image = pickedImage;
    });
  }

  bool _isLoading = false;

  void storeData() async {
    try {
      setState(() {
        _isLoading = true;
      });

      var fireStore = FirebaseFirestore.instance.collection("deposite_request");
      var uuid = const Uuid().v1();
      var userId = FirebaseAuth.instance.currentUser!.uid;
      String? imageUrl;

      if (userNameController.text.isEmpty ||
          phoneController.text.isEmpty ||
          _selectedBankName == null ||
          accountNumberController.text.isEmpty ||
          balanceController.text.isEmpty ||
          image == null) {
        Utils.flushBarErrorMessage("Please fill all the fields", context);
        setState(() {
          _isLoading = false;
        });
        return; // Stop execution if any required field is empty
      }

      if (image != null) {
        CommonFirebaseStorage commonStorage = CommonFirebaseStorage();
        imageUrl = await commonStorage.storeFileFileToFirebase(
            'profile/$uuid', image!);
      }

      Map<String, dynamic> depositeData = {
        "userName": userNameController.text,
        "phoneNumber": phoneController.text,
        "bankName": _selectedBankName,
        "accountNumber": accountNumberController.text,
        "amount": balanceController.text,
        "userId": userId,
        "uuid": uuid,
        "slipImageUrl": imageUrl, // Store image URL instead of the image object
      };

      await fireStore.doc(uuid).set(depositeData);
      setState(() {
        _isLoading = false;
      });
      Utils.toastMessage("Request has been sent");
      Navigator.pushNamedAndRemoveUntil(
          context, RoutesName.home, (route) => false);
      // Optionally, navigate to another screen or show a success message.
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      debugPrint("An error occurred while storing data: $e");
      Utils.flushBarErrorMessage("Failed to store data", context);
    }
  }

  @override
  void initState() {
    super.initState();
    getBankDetails();
  }

  getBankDetails() async {
    try {
      setState(() {
        isLoading = true;
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
          selectedBankDetail = _bankDetails[0];
        }
      });
    } catch (e) {
      print(e.toString());
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Deposit Details',
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
        child: SingleChildScrollView(
          child: LoadingManager(
            isLoading: _isLoading,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const VerticalSpeacing(16),
                  TextFieldCustom(
                    keyboardType: TextInputType.name,
                    controller: userNameController,
                    maxLines: 1,
                    text: 'User Name',
                    hintText: "",
                  ),
                  const VerticalSpeacing(16),
                  TextFieldCustom(
                    controller: phoneController,
                    keyboardType: TextInputType.number,
                    maxLines: 1,
                    text: 'Phone',
                    hintText: "",
                  ),
                  const VerticalSpeacing(16),
                  Text(
                    'Admin bank details',
                    style: GoogleFonts.getFont(
                      "Poppins",
                      textStyle: const TextStyle(
                        fontWeight: FontWeight.w400,
                        color: AppColor.whiteColor,
                        fontSize: 16.0,
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
                            color: Colors.white, // Use the color directly
                          ),
                        ),
                        dropdownColor: const Color(0xff191A2F),
                        value: _selectedBankName,
                        underline: const SizedBox(),
                        icon: const Icon(
                          Icons.expand_more_outlined,
                          color: Colors.white, // Use the color directly
                        ),
                        iconSize: 24,
                        elevation: 16,
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedBankName = newValue!;
                            selectedBankDetail = _bankDetails.firstWhere(
                                (element) => element['bankName'] == newValue);
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
                    controller: accountNumberController,
                    keyboardType: TextInputType.number,
                    maxLines: 1,
                    text: 'Account Number',
                    hintText: "",
                  ),
                  const VerticalSpeacing(16),
                  TextFieldCustom(
                    keyboardType: TextInputType.number,
                    controller: balanceController,
                    maxLines: 1,
                    text: 'Amount',
                    hintText: "",
                  ),
                  const VerticalSpeacing(16),
                  Text(
                    'Screen Shot',
                    style: GoogleFonts.getFont(
                      "Poppins",
                      textStyle: const TextStyle(
                        color: AppColor.whiteColor,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                  const VerticalSpeacing(10),
                  Container(
                    height: 94,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: const Color(0xff2B2C4E),
                        borderRadius: BorderRadius.circular(4.0),
                        image: DecorationImage(
                          image: image == null
                              ? const NetworkImage(
                                  "url") // Use a placeholder network image if image is null
                              : FileImage(image!) as ImageProvider<
                                  Object>, // Cast FileImage to ImageProvider<Object>
                          fit: BoxFit
                              .cover, // Adjusts the image to cover the entire container
                        )),
                    child: Center(
                      child: IconButton(
                        onPressed: () {
                          pickImage();
                        },
                        icon: const Icon(
                          Icons.upload_outlined,
                          size: 60.0,
                          color: Colors
                              .white, // Changed to use built-in white color
                        ),
                      ),
                    ),
                  ),
                  const VerticalSpeacing(80),
                  RoundedButton(
                      title: "Deposite Amount",
                      onpress: () {
                        storeData();
                      }),
                  const VerticalSpeacing(40),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
