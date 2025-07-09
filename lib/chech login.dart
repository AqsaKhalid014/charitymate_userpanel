import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sahara_homepage/Homescreen.dart';
import 'package:sahara_homepage/loginpage.dart';
import 'package:sahara_homepage/main.dart';
import 'package:sahara_homepage/welcome%20screen.dart';

class checkuserloginstatus extends StatelessWidget {
  const checkuserloginstatus({super.key});

  @override
  Widget build(BuildContext context) {
    return  checkuser();
  }
  checkuser(){
    final user=FirebaseAuth.instance.currentUser;
    if(user!=null){
      return MyHomePage();
    }
    else
      {
        return loginPage();
      }
  }
}
