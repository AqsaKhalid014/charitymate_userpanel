import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RequesterProfileScreen extends StatelessWidget {
 final String requesterUid;

 const RequesterProfileScreen({required this.requesterUid, super.key});

 Future<Map<String, dynamic>?> fetchUserData() async {
  final doc = await FirebaseFirestore.instance
      .collection('users personal data')
      .doc(requesterUid)
      .get();

  if (doc.exists) {
   return doc.data();
  }
  return null;
 }

 @override
 Widget build(BuildContext context) {
  return Scaffold(
   appBar: AppBar(title: Text("Requester Profile")),
   body: FutureBuilder<Map<String, dynamic>?>(
   future: fetchUserData(),
    builder: (context, snapshot) {
     if (snapshot.connectionState == ConnectionState.waiting)
      return Center(child: CircularProgressIndicator());

     if (!snapshot.hasData || snapshot.data == null)
      return Center(child: Text("User profile not found"));

     final data = snapshot.data!;
     return Padding(
      padding: const EdgeInsets.all(16),
      child: Card(
       elevation: 5,
       child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
         mainAxisSize: MainAxisSize.min,
         children: [
          Text("Name: ${data['name']}", style: TextStyle(fontSize: 18)),
          SizedBox(height: 10),
          Text("Email: ${data['email']}", style: TextStyle(fontSize: 18)),
          SizedBox(height: 10),
          Text("Phone: ${data['phone']}", style: TextStyle(fontSize: 18)),
         ],
        ),
       ),
      ),
     );
    },
   ),
  );
 }
}
