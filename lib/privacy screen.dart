import 'package:flutter/material.dart';

class PrivacyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Privacy Policy',
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
                    'Privacy Policy & Terms',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange[800],
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    '1. By using this charity app, you agree to our privacy policy and terms of service.\n\n'
                        '2. Donations made through this app are processed securely, and we do not store your payment details.\n\n'
                        '3. We collect minimal personal information to ensure seamless donation tracking and transparency.\n\n'
                        '4. Your data will never be shared or sold to third parties without your consent.\n\n'
                        '5. Funds donated are used strictly for the causes mentioned on our platform.\n\n'
                        '6. We reserve the right to update this policy and will notify users of any major changes.\n\n'
                        '7. Misuse of this app, including fraudulent donations or misleading activities, may result in legal action.\n\n'
                        '8. For further inquiries, please refer to our full privacy policy or contact us ',
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
                      Text('Accept', style: TextStyle(color: Colors.white)),
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
