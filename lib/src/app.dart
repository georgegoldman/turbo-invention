import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'views/screens/home.dart';

class AppEntryPoint extends StatelessWidget {
  const AppEntryPoint({super.key});
  static const String titleValue = "Home";

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}
