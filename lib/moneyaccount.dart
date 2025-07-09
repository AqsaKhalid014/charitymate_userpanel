import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sahara_homepage/Homescreen.dart';
import 'package:sahara_homepage/main.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:android_intent_plus/android_intent.dart';

class EasyPaisaPage extends StatelessWidget {
  Future<void> _launchEasyPaisa() async {
    try {
      final intent = AndroidIntent(
        action: 'android.intent.action.MAIN',
        package: 'pk.com.telenor.phoenix',
        componentName: 'pk.com.telenor.phoenix.ui.activity.SplashActivity',
        category: 'android.intent.category.LAUNCHER',
      );
      await intent.launch();
    } catch (e) {
      print("Error launching Easypaisa: $e");
      final fallbackIntent = AndroidIntent(
        action: 'android.intent.action.VIEW',
        data: 'https://play.google.com/store/apps/details?id=pk.com.telenor.phoenix',
      );
      await fallbackIntent.launch();
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
           title: Text("EasyPaisa"),backgroundColor: Colors.orange.shade400
      ),
      body:
      Stack(
        children: [
// 🔶 Background Image with Low Opacity
      Positioned.fill(
      child: Opacity(
      opacity: 0.4,
        child: Image.asset(
          'assets/images/img.png', // Your image path
          fit: BoxFit.cover,
          width: double.infinity,
        ),
      ),
    ),

// 🔸 Foreground Content
    SafeArea(
    child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
// Top content (optional)
    Padding(
    padding: const EdgeInsets.only(top: 40),
    child: Center(
      child: Text(
      "Welcome to CharityMate!\n\n\n",
      style: TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.bold,
      color: Colors.black,
      ),
      textAlign: TextAlign.center,
      ),
    ),
    ),

    Padding(
    padding: const EdgeInsets.only(bottom: 30),
    child: ElevatedButton(
    onPressed: _launchEasyPaisa,
    child: Text("Continue", style: TextStyle(color: Colors.black)),
       style: ElevatedButton.styleFrom(
       backgroundColor: Colors.orange,
       padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
       shape: RoundedRectangleBorder(
       borderRadius: BorderRadius.circular(30),
            ),
           ),
          ),
         ),
       ],
     ),
    )
    ],
      )
    );
  }
}
