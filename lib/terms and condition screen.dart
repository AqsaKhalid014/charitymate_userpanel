import 'package:flutter/material.dart';

class TermsAndConditionsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Terms & Conditions',
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
                    'CharityMate Terms & Conditions',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange[800],
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    '1. Acceptance of Terms:\n'
                        '   By using the CharityMate app, you agree to comply with these terms and conditions. If you do not agree, please refrain from using our services.\n\n'
                        '2. Purpose of the App:\n'
                        '   CharityMate is designed to facilitate donations and charity initiatives. Users can donate funds, volunteer, or support various causes listed on our platform.\n\n'
                        '3. User Responsibilities:\n'
                        '   - Users must provide accurate personal details during registration.\n'
                        '   - Any misuse of the app, including fraudulent donations, is strictly prohibited.\n\n'
                        '4. Donations and Fund Utilization:\n'
                        '   - All donations are processed securely, and users can track where their funds are being used.\n'
                        '   - CharityMate does not guarantee refunds once a donation is made. Please verify before proceeding.\n\n'
                        '5. Privacy and Data Security:\n'
                        '   - We value your privacy and do not share your personal information without consent.\n'
                        '   - Transaction data is encrypted and stored securely to protect users from fraud.\n\n'
                        '6. Prohibited Activities:\n'
                        '   - Any attempt to manipulate donation campaigns or provide misleading information is prohibited.\n'
                        '   - Hate speech, discrimination, or any offensive content will not be tolerated.\n\n'
                        '7. Modifications to Terms:\n'
                        '   - CharityMate reserves the right to update these terms at any time. Continued use of the app signifies acceptance of any modifications.\n\n'
                        '8. Liability Disclaimer:\n'
                        '   - CharityMate is not responsible for third-party organizations that receive donations through the platform.\n'
                        '   - We strive for accuracy, but users should verify charity details before making contributions.\n\n'
                        '9. Contact Us:\n'
                        '   - For any inquiries or support, please contact us ',
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
                      Text('continue', style: TextStyle(color: Colors.white)),
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
