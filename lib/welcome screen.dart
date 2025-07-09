import 'package:flutter/material.dart';
import 'package:sahara_homepage/loginpage.dart';
import 'package:sahara_homepage/signup%20screen.dart';
import 'package:lottie/lottie.dart';

class welcomescreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //  backgroundColor: Colors.teal,
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 105),
              Text(
                "CHARITY MATE",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Image.asset(
                'assets/images/logo image.jpeg',
                fit: BoxFit.fill,
                height: 400,
                width: double.infinity,
               // repeat: true,
              ),

            ],
          ),
        ),
      ),
    );
  }
}