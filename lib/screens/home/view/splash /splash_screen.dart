import 'dart:async';

import 'package:ecommerce_app/utils/firebase_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isLogin = false;
  @override
  void initState() {
    super.initState();
    isLogin = FireBaseHelper.fireBaseHelper.checkUser();
  }
  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 3),() => Get.offAndToNamed(isLogin==false?'/signin':'/welcome'));
    return SafeArea(child: Scaffold(
      body: Center(
        child: FlutterLogo(size: 80,),
      ),
    ));
  }

}
