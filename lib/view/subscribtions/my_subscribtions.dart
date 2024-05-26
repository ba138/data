import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:data/Res/components/colors.dart';
import 'package:data/Res/components/vertical_speacing.dart';
import 'package:data/utils/routes/routes_name.dart';
import 'package:data/view/home/widgets/subscribtion_Card.dart';

import '../../view_model/service/subscribtion_services.dart';

class MySubscribtions extends StatefulWidget {
  const MySubscribtions({super.key});

  @override
  _MySubscribtionsState createState() => _MySubscribtionsState();
}

class _MySubscribtionsState extends State<MySubscribtions> {
  bool _isLoading = false;
  List<Map<String, dynamic>> _subscriptions = [];
  String? _error;

  @override
  void initState() {
    super.initState();
    _fetchSubscriptions();
  }

  Future<void> _fetchSubscriptions() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      _subscriptions = await SubscriptionService().getUserSubscriptions();
    } catch (e) {
      setState(() {
        _error = e.toString();
      });
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
        centerTitle: true,
        title: Text(
          'My Subscriptions',
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
            Navigator.pushNamed(context, RoutesName.home);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : _error != null
                ? Center(child: Text(_error!))
                : _subscriptions.isEmpty
                    ? const Center(child: Text('No subscriptions found.'))
                    : ListView.builder(
                        itemCount: _subscriptions.length,
                        itemBuilder: (context, index) {
                          final subscription = _subscriptions[index];
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const VerticalSpeacing(30.0),
                              SubscribtionCard(
                                bgColor: AppColor.buttonColor,
                                charge:
                                    subscription['subscribtionCharges'] ?? '',
                                date: subscription['dateTime'] ?? '',
                                duration:
                                    subscription['subscriptionDuration'] ?? '',
                                ontapSubscribe: () {},
                                subscribtionStatus:
                                    subscription['subscribtionStatus'] ?? '',
                              ),
                              const VerticalSpeacing(46.0),
                              Center(
                                child: Text.rich(
                                  TextSpan(
                                    text:
                                        '41% off only for you. To get this payment\n',
                                    style: GoogleFonts.getFont(
                                      "Poppins",
                                      textStyle: const TextStyle(
                                        color: AppColor.whiteColor,
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    children: [
                                      TextSpan(
                                        text: 'collect and apply, fund ',
                                        style: GoogleFonts.getFont(
                                          "Poppins",
                                          textStyle: const TextStyle(
                                            color: AppColor.whiteColor,
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              const VerticalSpeacing(46.0),
                              Row(
                                children: [
                                  Container(
                                    height: 5,
                                    width: 20,
                                    color: AppColor.buttonColor,
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    '${subscription['subscriptionDuration'] ?? 'N/A'} regular use',
                                    style: GoogleFonts.getFont(
                                      "Poppins",
                                      textStyle: const TextStyle(
                                          color: AppColor.whiteColor,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                ],
                              ),
                              const VerticalSpeacing(20.0),
                              Row(
                                children: [
                                  Container(
                                    height: 5,
                                    width: 20,
                                    color: AppColor.buttonColor,
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    'always fund, withdraw money',
                                    style: GoogleFonts.getFont(
                                      "Poppins",
                                      textStyle: const TextStyle(
                                          color: AppColor.whiteColor,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                ],
                              ),
                              const VerticalSpeacing(20.0),
                              Text(
                                'Exp ${subscription['expiryDate'] ?? 'N/A'}',
                                style: GoogleFonts.getFont(
                                  "Poppins",
                                  textStyle: const TextStyle(
                                      color: AppColor.whiteColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
      ),
    );
  }
}
