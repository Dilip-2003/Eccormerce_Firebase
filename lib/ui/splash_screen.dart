import 'package:ecommerce_firebase/const/colors.dart';
import 'package:ecommerce_firebase/ui/login.dart';
import 'package:flutter/material.dart';
// Import the home screen

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (BuildContext context) => const Login(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColor.primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'E-Commerce App',
              style: TextStyle(
                fontSize: 40,
                color: MyColor.white,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            CircularProgressIndicator(
              color: MyColor.white,
              strokeWidth: 7.5,
            )
          ],
        ),
      ),
    );
  }
}
