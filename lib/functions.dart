import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sahara_homepage/postscreen.dart';

class functions {
  static container(
    IconData icon,
    Color colour,
    String text,
    VoidCallback ontap,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: InkWell(
        onTap: ontap,
        child: Container(
          width: 80,
          height: 60,
          decoration: BoxDecoration(
              color: Colors.orange.shade50,
              borderRadius: BorderRadius.circular(40)),
          child: Column(
            children: [
              Spacer(),
              Icon(
                icon,
                size: 25,
                color: colour,
              ),
              Text(
                text,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
              ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  static wideaddcontainer(String imagelink) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        height: 120,
        width: 380,
        decoration: BoxDecoration(
            color: Colors.pinkAccent, borderRadius: BorderRadius.circular(15)),
        child: Image.asset(
          imagelink,
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  static container2(
    Color colour,
    String text,
    VoidCallback ontap,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: InkWell(
        onTap: ontap,
        child: Container(
          width: 120,
          height: 100,
          decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(10)),
          child: Column(
            children: [
              Spacer(),
              Text(
                text,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  static Dialogboxx(BuildContext context, String text) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(text),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Ok'))
            ],
          );
        });
  }


}
