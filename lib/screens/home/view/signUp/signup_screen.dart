import 'package:ecommerce_app/utils/firebase_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController txtemail = TextEditingController();
  TextEditingController txtpass = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(controller: txtemail,
                  decoration: InputDecoration(hintText: "Enter your email",labelText: "Email",enabledBorder: OutlineInputBorder(),focusedBorder: OutlineInputBorder()),),
                SizedBox(height: 10,),
                TextField(
                  controller: txtpass,
                  decoration: InputDecoration(hintText: "Enter your Password",labelText: "Password",enabledBorder: OutlineInputBorder(),focusedBorder: OutlineInputBorder()),),
               ElevatedButton(onPressed: () {
                 FireBaseHelper.fireBaseHelper.signUp(email: txtemail.text, password: txtpass.text);
                 Get.toNamed('/signin');
               }, child: Text("Sign up"))
              ],
            ),
          ),
    ));
  }
}
