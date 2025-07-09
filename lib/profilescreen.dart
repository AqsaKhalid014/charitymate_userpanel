import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sahara_homepage/privacy%20screen.dart';
import 'package:sahara_homepage/terms%20and%20condition%20screen.dart';
import 'about us screen.dart';
import 'feedback & rating.dart';
import 'loginpage.dart';
import 'main.dart';
import 'most asked question screen.dart';

class Profilescreen extends StatefulWidget {
  const Profilescreen({super.key});

  @override
  State<Profilescreen> createState() => _ProfileState();
}

class _ProfileState extends State<Profilescreen> {
  String userName = "Loading...";
  String userEmail = "Loading...";
  String userContact = "Loading...";

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  void _loadUserData() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users personal data')
          .doc(user.uid)
          .get();

      setState(() {
        userName = userDoc['name'] ?? "Unknown";
        userEmail = userDoc['email'] ?? "No Email";
        userContact = userDoc['phone'] ?? "No Contact";
      });
    }
  }

  Future<void> _showLogoutDialog(BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Logout Confirmation'),
        content: Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('No'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.of(context).pop();
              await FirebaseAuth.instance.signOut();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => loginPage()),
              );
            },
            child: Text('Yes'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange.shade50,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.orange.shade300,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: Column(
                  children: [
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 35,
                          backgroundImage: AssetImage('assets/images/logo zoom.jpg'),
                          backgroundColor: Colors.white,
                        ),
                        SizedBox(width: 15),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 10),
                            Text(
                              'CHARITY MATE',
                              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
                            ),
                            SizedBox(height: 3),
                            Text(userName,
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.white)),
                            Text(userEmail,
                                style: TextStyle(fontSize: 14, color: Colors.white)),
                            Text("Contact: $userContact",
                                style: TextStyle(fontSize: 14, color: Colors.white)),
                            SizedBox(height: 5),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(backgroundColor: Colors.orangeAccent.shade100),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    final TextEditingController _editNameController = TextEditingController(text: userName);
                                    final TextEditingController _contactController = TextEditingController(text: userContact);

                                    return AlertDialog(
                                      title: Text("Edit Profile"),
                                      content: SingleChildScrollView(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            TextField(
                                              controller: _editNameController,
                                              decoration: InputDecoration(labelText: "Edit Name"),
                                            ),
                                            TextField(
                                              controller: _contactController,
                                              decoration: InputDecoration(labelText: "Contact Number"),
                                            ),
                                          ],
                                        ),
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () => Navigator.pop(context),
                                          child: Text("Cancel"),
                                        ),
                                        TextButton(
                                          onPressed: () async {
                                            User? user = FirebaseAuth.instance.currentUser;
                                            try {
                                              // Update name if changed
                                              if (_editNameController.text.isNotEmpty && _editNameController.text != userName) {
                                                await user?.updateDisplayName(_editNameController.text);
                                                await FirebaseFirestore.instance
                                                    .collection('users personal data')
                                                    .doc(user?.uid)
                                                    .update({'name': _editNameController.text});
                                              }

                                              // Update contact number if changed
                                              if (_contactController.text.isNotEmpty && _contactController.text != userContact) {
                                                await FirebaseFirestore.instance
                                                    .collection('users personal data')
                                                    .doc(user?.uid)
                                                    .update({'phone': _contactController.text});
                                              }

                                              // Reload user data and show confirmation
                                              await user?.reload();
                                              _loadUserData();
                                              Navigator.pop(context);
                                              ScaffoldMessenger.of(context).showSnackBar(
                                                SnackBar(content: Text("Profile updated successfully")),
                                              );
                                            } catch (e) {
                                              Navigator.pop(context);
                                              ScaffoldMessenger.of(context).showSnackBar(
                                                SnackBar(content: Text("Error: $e")),
                                              );
                                            }
                                          },
                                          child: Text("Save"),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              child: Text('Edit Profile'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            buildTile(context, "Home", Icons.home_sharp, MyHomePage()),
            buildSettingsSection(context),
            buildTile(context, "Logout", Icons.logout, null, isLogout: true),
          ],
        ),
      ),
    );
  }

  Widget buildTile(BuildContext context, String title, IconData icon, Widget? page, {bool isLogout = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 7),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
        ),
        child: InkWell(
          onTap: () {
            if (isLogout) {
              _showLogoutDialog(context);
            } else if (page != null) {
              Navigator.push(context, MaterialPageRoute(builder: (context) => page));
            }
          },
          child: ListTile(
            title: Text(title),
            leading: Icon(icon, color: Colors.black),
          ),
        ),
      ),
    );
  }

  Widget buildSettingsSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 7),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Column(
          children: [
            buildSettingsTile(context, 'About Us', Icons.read_more_outlined, AboutUsScreen()),
            buildSettingsTile(context, 'Terms and Conditions', Icons.terminal_sharp, TermsAndConditionsScreen()),
            buildSettingsTile(context, 'Privacy Policy', Icons.privacy_tip_outlined, PrivacyScreen()),
            buildSettingsTile(context, 'FAQ', Icons.question_mark, FAQScreen()),
            buildSettingsTile(context, 'Rating & Feedback', Icons.feedback_outlined, FeedbackScreen()),
          ],
        ),
      ),
    );
  }

  Widget buildSettingsTile(BuildContext context, String title, IconData icon, Widget page) {
    return InkWell(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => page)),
      child: ListTile(
        title: Text(title),
        leading: Icon(icon),
      ),
    );
  }
}
