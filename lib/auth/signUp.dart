import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../views/components/custombutton.dart';
import '../views/components/customlogoauth.dart';
import '../views/components/textformfield.dart';
import '../controller/usercontroller.dart';
import 'auth.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _LoginState();
}

class _LoginState extends State<SignUp> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  GlobalKey<FormState> formState = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20),
        child: ListView(
          children: [
            Form(
              key: formState,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(height: 50),
                  CustomlogoAuth(),
                  Container(height: 20),
                  Text(
                    "انشاء حساب",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  Container(height: 10),
                  Text(
                    "انشاء حساب لاستعمال التطبيق",
                    style: TextStyle(color: Colors.grey),
                  ),
                  Container(height: 20),
                  Text(
                    "اسم المستخدم",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  Container(height: 10),
                  CustomTextForm(
                    hintText: 'ادخل اسم المستخدم',
                    mycontroller: _usernameController,
                    validator: (val) {
                      if (val == "") {
                        return "لا يترك فارغا";
                      }
                    },
                  ),
                  Container(height: 10),
                  Text(
                    "البريد الالكتروني",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  Container(height: 10),
                  CustomTextForm(
                    hintText: 'ادخل بريدك الالكتروني',
                    mycontroller: _emailController,
                    validator: (val) {
                      if (val == "") {
                        return "لا يترك فارغا";
                      }
                    },
                  ),
                  Container(
                    height: 10,
                  ),
                  Text(
                    "كلمة السر",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  Container(height: 10),
                  CustomTextForm(
                    hintText: 'ادخل كلمة السر',
                    mycontroller: _passwordController,
                    validator: (val) {
                      if (val == "") {
                        return "لا تترك فارغة";
                      }
                    },
                  ),
                ],
              ),
            ),
            Container(
              height: 10,
            ),
            Container(height: 10),
            Custombutton(
                title: 'انشاء الحساب',
                // onPressed: () async {
                //   if (formState.currentState!.validate()) {
                //     try {
                //       final credential = await FirebaseAuth.instance
                //           .createUserWithEmailAndPassword(
                //         email: email.text,
                //         password: password.text,
                //       );

                //       Navigator.of(context).pushReplacementNamed("Login");
                //     } on FirebaseAuthException catch (e) {
                //       print(e);
                //       if (e.code == 'weak-password') {
                //         print('The password provided is too weak.');
                //       } else if (e.code == 'email-already-in-use') {
                //         print('The account already exists for that email.');
                //         AwesomeDialog(
                //           context: context,
                //           dialogType: DialogType.error,
                //           animType: AnimType.rightSlide,
                //           title: 'Error',
                //           desc: 'The account already exists for that email.',
                //         )..show();
                //       }
                //     } catch (e) {
                //       print(e);
                //     }
                //   }
                // },
                onPressed: () async {
                  String res = await AuthMethods().signUpUser(
                      email: _emailController.text,
                      password: _passwordController.text,
                      username: _usernameController.text);
                  print(res);
                }),
            Container(height: 10),
            // Text(
            //   "Don't Have an Account ? Register",
            //   textAlign: TextAlign.center,
            // ),
            InkWell(
              onTap: () {
                Navigator.of(context).pushReplacementNamed("Login");
              },
              child: Center(
                child: Text.rich(TextSpan(children: [
                  TextSpan(text: "هل تملك حساب ؟"),
                  TextSpan(
                      text: "تسجيل الدخول",
                      style: TextStyle(
                          color: Colors.green, fontWeight: FontWeight.bold)),
                ])),
              ),
            )
          ],
        ),
      ),
    );
  }
}
