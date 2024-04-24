import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../views/components/custombutton.dart';
import '../views/components/customlogoauth.dart';
import '../views/components/textformfield.dart';
import 'auth.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  // Future<void> signInWithGoogle(BuildContext context) async {
  //   try {
  //     // Trigger the authentication flow
  //     final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  //     // Obtain the auth details from the request
  //     final GoogleSignInAuthentication? googleAuth =
  //         await googleUser?.authentication;

  //     // Create a new credential
  //     final credential = GoogleAuthProvider.credential(
  //       accessToken: googleAuth?.accessToken,
  //       idToken: googleAuth?.idToken,
  //     );

  //     // Once signed in, return the UserCredential
  //     await FirebaseAuth.instance.signInWithCredential(credential);
  //     Navigator.of(context)
  //         .pushNamedAndRemoveUntil("FirstPage", (route) => false);
  //   } catch (e) {
  //     // Handle error appropriately, such as displaying an error message to the user
  //     print('Error signing in with Google: $e');
  // ScaffoldMessenger.of(context).showSnackBar(
  //   SnackBar(
  //     content: Text('An error occurred while signing in with Google.'),
  //   ),
  // );
  //     // Pop the current route to return to the previous screen
  //     Navigator.of(context)
  //         .pushNamedAndRemoveUntil("Homepage", (route) => false);
  //   }
  //   final user = FirebaseAuth.instance.currentUser;
  //   if (user != null) {
  //     // Name, email address, and profile photo URL
  //     final name = user.displayName;
  //     print('///////////////////////////');
  //     print(name);
  //     print('///////////////////////////');
  //     final email = user.email;
  //     final photoUrl = user.photoURL;

  //     // Check if user's email is verified
  //     final emailVerified = user.emailVerified;

  //     // The user's ID, unique to the Firebase project. Do NOT use this value to
  //     // authenticate with your backend server, if you have one. Use
  //     // User.getIdToken() instead.
  //     final uid = user.uid;
  //   }
  // }

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
                    "تسجيل الدخول",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  Container(height: 10),
                  Text(
                    "سجل الدخول لتستعمل التطبيق",
                    style: TextStyle(color: Colors.grey),
                  ),
                  Container(height: 20),
                  Text(
                    "البريد الالكتروني",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  Container(height: 10),
                  CustomTextForm(
                    hintText: 'ادخل بريدك الالكتروني',
                    mycontroller: email,
                    validator: (val) {
                      if (val == "") {
                        return "لا يترك فارغ";
                      }
                    },
                  ),
                  Container(height: 10),
                  Text(
                    "كلمة المرور",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  Container(height: 10),
                  CustomTextForm(
                    hintText: 'ادخل كلمة المرور',
                    mycontroller: password,
                    validator: (val) {
                      if (val == "") {
                        return "لا يترك فارغ";
                      }
                    },
                  ),
                  InkWell(
                    onTap: () async {
                      if (email.text == "") {
                        AwesomeDialog(
                          context: context,
                          dialogType: DialogType.error,
                          animType: AnimType.rightSlide,
                          title: 'خطأ',
                          desc: 'اكتب بريدك الالكتروني اولا',
                        )..show();
                        return;
                      }
                      try {
                        await FirebaseAuth.instance
                            .sendPasswordResetEmail(email: email.text);
                        AwesomeDialog(
                          context: context,
                          dialogType: DialogType.success,
                          animType: AnimType.rightSlide,
                          title: 'تم بنجاح',
                          desc: 'لقد ارسلنا اليك بريد الكتروني',
                        )..show();
                      } catch (e) {
                        AwesomeDialog(
                          context: context,
                          dialogType: DialogType.error,
                          animType: AnimType.rightSlide,
                          title: 'خطأ',
                          desc: 'تحقق من بريدك الالكتروني',
                        )..show();
                      }
                    },
                    child: Container(
                      margin: EdgeInsets.only(top: 10, bottom: 20),
                      alignment: Alignment.topRight,
                      child: Text(
                        "هل نسيت كلمة السر؟",
                        textAlign: TextAlign.right,
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Custombutton(
              title: 'الدخول',
              onPressed: () async {
                if (formState.currentState!.validate()) {
                  try {
                    final credential = await FirebaseAuth.instance
                        .signInWithEmailAndPassword(
                            email: email.text, password: password.text);
                    if (credential.user!.emailVerified) {
                      final user = FirebaseAuth.instance.currentUser;
                      if (user != null) {
                        // Name, email address, and profile photo URL
                        final name = user.displayName;
                        print('///////////////////////////');
                        print(name);
                        print('///////////////////////////');
                        final email = user.email;

                        // Check if user's email is verified
                        final emailVerified = user.emailVerified;

                        // The user's ID, unique to the Firebase project. Do NOT use this value to
                        // authenticate with your backend server, if you have one. Use
                        // User.getIdToken() instead.
                        final uid = user.uid;
                      }
                      Navigator.of(context)
                          .pushReplacementNamed("Firstpageever-");
                    } else {
                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.error,
                        animType: AnimType.rightSlide,
                        title: 'خطأ',
                        desc: 'تحقق من بريدك الالكتروني',
                      )..show();
                    }
                  } on FirebaseAuthException catch (e) {
                    print(e);
                    // We Used One condition because "Email enumeration is a type of
                    // brute-force attack in which a malicious actor attempts to guess
                    // or confirm users in a system by passing an email address to the
                    // API and checking the response."

                    AwesomeDialog(
                      context: context,
                      dialogType: DialogType.error,
                      animType: AnimType.rightSlide,
                      title: 'خطأ',
                      desc: 'تحقق من البريد الالكتروني و كلمة السر',
                    )..show();
                  }
                } else {
                  print("Non Valid");
                }
              },
            ),
            Container(height: 10),
            Text(
              "أو",
              textAlign: TextAlign.center,
            ),
            Container(height: 10),

            MaterialButton(
              onPressed: () async {
                var result = await AuthMethods().signInWithGoogle(context);

                if (result != null) {
                  print("23§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§gp");
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      'Firstpageever', (route) => false);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Failed to sign in with Google.'),
                    ),
                  );
                }
              },
              height: 50,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              color: Colors.green,
              textColor: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("سجل الدخول بحساب قوقل"),
                  Container(
                    width: 10,
                  ),
                  Image.asset(
                    "images/google.png",
                    width: 20,
                  )
                ],
              ),
            ),
            Container(height: 10),
            // Text(
            //   "Don't Have an Account ? Register",
            //   textAlign: TextAlign.center,
            // ),
            InkWell(
              onTap: () {
                Navigator.of(context).pushReplacementNamed("Signup");
              },
              child: Center(
                child: Text.rich(TextSpan(children: [
                  TextSpan(text: "لا تملك حساب "),
                  TextSpan(
                      text: "انشاء حساب",
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
