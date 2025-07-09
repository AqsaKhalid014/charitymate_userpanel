import 'package:flutter/material.dart';
import 'package:sahara_homepage/Homescreen.dart';

import 'donatemoney.dart';

class ProfileMoreScreen extends StatelessWidget {
  const ProfileMoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(title: Text('Donate money'),
      backgroundColor: Colors.orange.shade400,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
           SizedBox(height: 35,),
            Container(
              margin: EdgeInsets.all(16),
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.orangeAccent,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.orange.withOpacity(0.4),
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Text(
                " Hadith, narrated in Sahih Muslim, encourages giving without fear of financial loss, emphasizing that Allah multiplies the blessings of those who give charitably",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(width: 12,),
            Container(
              margin: EdgeInsets.all(16),
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.orangeAccent,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.orange.withOpacity(0.4),
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Text(
                "The Prophet, upon him be peace, said: “Give charity without delay, for it stands in the way of calamity.” (Al-Tirmidhi)",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(width: 12,),
            Container(
              margin: EdgeInsets.all(16),
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.orangeAccent,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.orange.withOpacity(0.4),
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Text(
                "Send the Money to our easypaisa account 03455xxxxx",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            ElevatedButton(onPressed: ()async{
              Navigator.push(context, MaterialPageRoute(builder: (_)=>MoneyDonationPage()));
            }, child: Text("Donate",style:TextStyle(color: Colors.black),),
           style: ElevatedButton.styleFrom(
           backgroundColor: Colors.orangeAccent,
           padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(60)))
            ),
          ],
        ),
      ),




    );
  }
}
