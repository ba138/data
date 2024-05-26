import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data/Res/components/rounded_button.dart';
import 'package:data/utils/routes/routes_name.dart';
import 'package:data/view/home/add_fund/widget/fund_details_tile.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddFundDetails extends StatefulWidget {
  const AddFundDetails({super.key});

  @override
  State<AddFundDetails> createState() => _AddFundDetailsState();
}

class _AddFundDetailsState extends State<AddFundDetails> {
  final FirebaseFirestore _firestoreInstance = FirebaseFirestore.instance;
  bool _isLoading = false;
  List<Map<String, dynamic>> _bankDetails = [];
  String? _selectedBankName;
  Map<String, dynamic>? _selectedBankDetail;

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
          _selectedBankDetail = _bankDetails[0];
        }
      });
    } catch (e) {
      print(e.toString());
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bank Details'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                          _selectedBankDetail = _bankDetails.firstWhere(
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
                const SizedBox(height: 16),
                Text(
                  'Please make the payment mention below',
                  style: GoogleFonts.getFont(
                    "Poppins",
                    textStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  height: MediaQuery.of(context).size.height / 2.4,
                  color: const Color(0xff2B2C4E),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Column(
                      children: [
                        FundTile(
                          title: 'Beneficiary Name',
                          subTitle:
                              _selectedBankDetail?['accountHolderName'] ?? '',
                          onCopy: () {},
                        ),
                        const SizedBox(height: 16),
                        FundTile(
                          title: 'Bank Name',
                          subTitle: _selectedBankDetail?['bankName'] ?? '',
                          onCopy: () {},
                        ),
                        const SizedBox(height: 16),
                        FundTile(
                          title: 'Account Number',
                          subTitle: _selectedBankDetail?['accountNumber'] ?? '',
                          onCopy: () {},
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                RoundedButton(
                  title: "Add Fund Details",
                  onpress: () {
                    Navigator.pushNamed(
                      context,
                      RoutesName.addFund,
                    );
                  },
                ),
              ],
            ),
    );
  }
}
