import 'package:ecommerce_app/utils/firebase_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
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
                SizedBox(height: 10,),
                TextButton(onPressed: () {
                  Get.toNamed('/signup');
                  },child: Text("Don't have an account ? Sign up"),),
                SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(onPressed: () async {
                      String? msg = await FireBaseHelper.fireBaseHelper.googleSignin();
                      if(msg=="success")
                      {
                        Get.toNamed('/welcome');
                      }
                      else
                        {
                          Get.snackbar("", "$msg");
                        }
                    }, child: Text("Google")),
                    ElevatedButton(onPressed: () async {
                      String email = txtemail.text;
                      String password = txtpass.text;
                      String? isLogin = await FireBaseHelper.fireBaseHelper.signIn(email: email, password: password);
                      if(isLogin == "success")
                        {
                          Get.snackbar("firebase", "successfull");
                          Get.offAndToNamed('/welcome');
                        }else
                          {
                            Get.snackbar("$isLogin","");
                          }
                    }, child: Text("Login")),
                  ],
                ),
              ],
            ),
          ),
        )
    );
  }

}

