import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DisplayScreen extends StatelessWidget {
  final File image;
  final String name;
  final String location;
  final String description;

  DisplayScreen({
    required this.image,
    required this.name,
    required this.location,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Display Page'),backgroundColor: Colors.orange.shade400),
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.file(image, height: 200, width: 200, fit: BoxFit.cover),
              SizedBox(height: 20),
              Text("Name: $name", style: TextStyle(fontSize: 20)),
              SizedBox(height: 10),
              Text("Location: $location", style: TextStyle(fontSize: 20)),
              SizedBox(height: 10),
              Text("Description: $description", style: TextStyle(fontSize: 20)),
            ],
          ),
        ),
      ),
    );
  }
}
