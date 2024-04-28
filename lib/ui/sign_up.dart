import 'package:ecommerce_firebase/const/colors.dart';
import 'package:ecommerce_firebase/ui/login.dart';
import 'package:ecommerce_firebase/ui/user_details.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({
    super.key,
    required this.text1,
    required this.text2,
    required this.text3,
    required this.text4,
    required this.text5,
  });
  final String text1, text2, text3, text4, text5;

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  // signUp() async {
  //   try {
  //     print(passwordController.text.toString());
  //     UserCredential userCredential =
  //         await FirebaseAuth.instance.createUserWithEmailAndPassword(
  //       email: emailController.text,
  //       password: passwordController.text,
  //     );
  //     var authCredential = userCredential.user;
  //     print('user id : ${authCredential!.uid}');

  //     if (authCredential.uid.isNotEmpty) {
  //       Navigator.push(
  //           context,
  //           MaterialPageRoute(
  //             builder: (context) => UserDetails(emailController: ,),
  //           ));
  //     } else {
  //       print('something went wrong');
  //     }
  //   } on FirebaseAuthException catch (e) {
  //     if (e.code == 'weak-password') {
  //       print('the password provided is to weak');
  //     } else if (e.code == 'email-already-in-use') {
  //       print('the account is already in use');
  //     }
  //   } catch (e) {
  //     print(e);
  //   }
  // }
  signUp() async {
    try {
      if (kDebugMode) {
        print(passwordController.text);
      }
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      var authCredential = userCredential.user;
      print('user id : ${authCredential!.uid}');

      if (authCredential.uid.isNotEmpty) {
        print('everything is okay');
      } else {
        print('something went wrong');
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('the password provided is to weak');
      }
      if (e.code == 'email-already-in-use') {
        print('the account is already in use');
        Navigator.push(
          // ignore: use_build_context_synchronously
          context,
          MaterialPageRoute(
            builder: (context) => const Login(),
          ),
        );
      } else {
        Navigator.push(
            // ignore: use_build_context_synchronously
            context,
            MaterialPageRoute(
              builder: (context) => Container(
                color: Colors.blue,
              ),
            ));
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.sizeOf(context).height;
    var width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      backgroundColor: MyColor.primaryColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: height * 0.2,
              padding: EdgeInsets.only(
                top: height * 0.1,
                left: width * 0.1,
              ),
              child: Text(
                widget.text1,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                  color: MyColor.white,
                ),
              ),
            ),
            Container(
              height: height * 0.8,
              width: width,
              padding: EdgeInsets.symmetric(
                  horizontal: width * 0.05, vertical: height * 0.05),
              decoration: BoxDecoration(
                color: MyColor.white,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.text2,
                    style: TextStyle(
                      fontSize: 25,
                      color: MyColor.primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    widget.text3,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey.shade400,
                    ),
                  ),
                  SizedBox(
                    height: height * 0.05,
                  ),
                  TextField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        label: Text(
                          'Email',
                          style: TextStyle(
                            fontSize: 18,
                            color: MyColor.primaryColor,
                          ),
                        ),
                        prefixIcon: Icon(
                          Icons.email_outlined,
                          color: Colors.grey.shade400,
                        )),
                  ),
                  SizedBox(
                    height: height * 0.05,
                  ),
                  TextField(
                    controller: passwordController,
                    keyboardType: TextInputType.text,
                    obscureText: true,
                    decoration: InputDecoration(
                        label: Text(
                          'Password',
                          style: TextStyle(
                            fontSize: 18,
                            color: MyColor.primaryColor,
                          ),
                        ),
                        prefixIcon: Icon(
                          Icons.lock,
                          color: Colors.grey.shade400,
                        )),
                  ),
                  SizedBox(
                    height: height * 0.1,
                  ),
                  InkWell(
                    onTap: () {
                      signUp();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UserDetails(
                            emailController: emailController.text.toString(),
                            paswordController:
                                passwordController.text.toString(),
                          ),
                        ),
                      );
                      print('button click');
                    },
                    child: Container(
                      height: height * 0.07,
                      width: width * 0.9,
                      decoration: BoxDecoration(
                          color: MyColor.primaryColor,
                          borderRadius: BorderRadius.circular(5)),
                      child: Center(
                        child: Text(
                          widget.text4,
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w500,
                            color: MyColor.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text(
                        "Do you have an account??",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginScreen(
                                text1: 'Sign In',
                                text2: 'Welcome Back',
                                text3: 'Glad to see back my buddy!!',
                                text4: 'SIGN IN',
                                text5: 'SIGN UP',
                              ),
                            ),
                          );
                        },
                        child: Text(
                          widget.text5,
                          style: TextStyle(
                            fontSize: 14,
                            color: MyColor.primaryColor,
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
