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
          body: Stack(
            children: [
              Container(height:double.infinity,width:double.infinity,child: Image.network("https://cdn.wallpapersafari.com/66/48/JwW4mI.jpg",fit: BoxFit.cover,)),
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.grey.shade500.withOpacity(0.85)
                ),
              ),
              Padding(
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
                      },child: Text("Don't have an account ? Sign up",style: TextStyle(color: Colors.blueGrey),),),
                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.blueGrey),onPressed: () async {
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
                        ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.blueGrey),onPressed: () async {
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
            ],
          ),
        )
    );
  }

}

