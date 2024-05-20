import 'package:data/utils/routes/routes.dart';
import 'package:data/utils/routes/routes_name.dart';
import 'package:flutter/material.dart';

import 'utils/routes/routes.dart';
import 'utils/routes/routes_name.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xff191A2F),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
      ),
      initialRoute: RoutesName.splash,

      onGenerateRoute: Routes.generateRoute,
    );
  }
}
