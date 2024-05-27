import 'package:data/utils/routes/routes_name.dart';
import 'package:data/view/auth/forget_password.dart';
import 'package:data/view/auth/login_view.dart';
import 'package:data/view/auth/register_screen.dart';
import 'package:data/view/auth/splash_view.dart';
import 'package:data/view/history/increment_history.dart';
import 'package:data/view/home/add_fund/add_fund.dart';
import 'package:data/view/home/add_fund/add_fund_details.dart';
import 'package:data/view/home/all_subscribtions.dart';
import 'package:data/view/home/home_view.dart';
import 'package:data/view/subscribtions/my_subscribtions.dart';
import 'package:data/view/profile/edit_profile_view.dart';
import 'package:data/view/profile/my_profile_view.dart';
import 'package:data/view/withdrawFund/withdrawView.dart';

import 'package:data/view/profile/profile.dart';
import 'package:flutter/material.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.splash:
        return MaterialPageRoute(
            builder: (BuildContext context) => const SplashScreen());
      case RoutesName.logoIn:
        return MaterialPageRoute(
            builder: (BuildContext context) => const LoginView());
      case RoutesName.home:
        return MaterialPageRoute(
            builder: (BuildContext context) => const HomeView());
      case RoutesName.register:
        return MaterialPageRoute(
            builder: (BuildContext context) => const RegisterScreen());
      case RoutesName.forget:
        return MaterialPageRoute(
            builder: (BuildContext context) => const ForgetPasswordScreen());
      case RoutesName.profile:
        return MaterialPageRoute(
            builder: (BuildContext context) => const ProfileScreen());
      case RoutesName.allSubscriptionView:
        return MaterialPageRoute(
            builder: (BuildContext context) => const AllSubscribtionsView());
      case RoutesName.addFund:
        return MaterialPageRoute(
            builder: (BuildContext context) => const AddFund());
      case RoutesName.withdrawFund:
        return MaterialPageRoute(
            builder: (BuildContext context) => const WithdrawFundsView());
      case RoutesName.mySubscribtions:
        return MaterialPageRoute(
            builder: (BuildContext context) => const MySubscribtions());
      case RoutesName.addfunddetails:
        return MaterialPageRoute(
            builder: (BuildContext context) => const AddFundDetails());
      case RoutesName.myprofileview:
        return MaterialPageRoute(
            builder: (BuildContext context) => const MyProfileView());
      case RoutesName.editprofileview:
        return MaterialPageRoute(
            builder: (BuildContext context) => const EditProfileView());
      case RoutesName.incrementHistory:
        return MaterialPageRoute(
            builder: (BuildContext context) =>  IncrementHistory());
      default:
        return MaterialPageRoute(builder: (_) {
          return const Scaffold(
            body: Center(
              child: Text('No routes define'),
            ),
          );
        });
    }
  }
}
