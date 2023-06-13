import 'package:ecommerce_app/screens/home/view/add/add_screen.dart';
import 'package:ecommerce_app/screens/home/view/signIn/signin_screen.dart';
import 'package:ecommerce_app/screens/home/view/signUp/signup_screen.dart';
import 'package:ecommerce_app/screens/home/view/welcome/welcome_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'screens/home/view/splash /splash_screen.dart';
Future<void> main()
async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    Sizer(builder: (context, orientation, deviceType) => GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: [
        GetPage(name: '/', page: () => SplashScreen()),
        GetPage(name: '/signup', page: () => SignUpScreen()),
        GetPage(name: '/signin', page: () => SignInScreen()),
        GetPage(name: '/welcome', page: () => WelcomeScreen()),
        GetPage(name: '/add', page: () => AddScreen()),
      ],
    ),),
  );
}
