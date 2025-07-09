import 'package:flutter/material.dart';

class AboutUsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'About Us',
         // style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.orange.shade400,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.orange[50],
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.orange),
            ),
            padding: EdgeInsets.all(16),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Who We Are',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange[800],
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'We are a non-profit organization dedicated to making a positive impact on communities in need. Our platform connects donors with those requiring assistance, ensuring transparency and efficiency in charitable giving.\n\n'
                        'Our Mission:\n'
                        '1. Provide a seamless way for people to donate to meaningful causes.\n'
                        '2. Ensure transparency in fund distribution and utilization.\n'
                        '3. Support underprivileged communities through food, shelter, and education programs.\n'
                        '4. Encourage volunteer participation to maximize social impact.\n\n'
                        'Our Vision:\n'
                        'To create a world where kindness and generosity uplift those in need, making charity accessible and impactful for everyone.\n\n'
                        'Our Values:\n'
                        '✔ Transparency – Every donation is tracked and accounted for.\n'
                        '✔ Compassion – Helping those in need with dignity and respect.\n'
                        '✔ Integrity – Maintaining trust through ethical practices.\n'
                        '✔ Collaboration – Partnering with individuals and organizations for greater impact.\n'
                        '✔ Sustainability – Creating long-term solutions for social welfare.\n\n'
                        'How You Can Help:\n'
                        '⭐ Donate – Every contribution, big or small, makes a difference.\n'
                        '⭐ Volunteer – Join our team to support on-ground initiatives.\n'
                        '⭐ Spread Awareness – Share our mission to reach more people.\n\n'
                        'For more details or to get involved, contact us ',
                    style: TextStyle(fontSize: 16, color: Colors.orange[900]),
                  ),
                  SizedBox(height: 20),
                  Align(
                    alignment: Alignment.center,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child:
                      Text('Back', style: TextStyle(color: Colors.white)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
