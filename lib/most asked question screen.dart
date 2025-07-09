import 'package:flutter/material.dart';

class FAQScreen extends StatefulWidget {
  @override
  _FAQScreenState createState() => _FAQScreenState();
}

class _FAQScreenState extends State<FAQScreen> {
  Map<int, bool> _expanded = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Text(
          'Frequently Asked Questions'
          //  style: TextStyle(color: Colors.white),
        ),backgroundColor: Colors.orange.shade400,

      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(_faqList.length, (index) {
              return faqItem(index, _faqList[index]['question']!, _faqList[index]['answer']!);
            }),
          ),
        ),
      ),
    );
  }

  Widget faqItem(int index, String question, String answer) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 4,
              offset: Offset(2, 2),
            ),
          ],
        ),
        child: ExpansionTile(
          title: Text(
            question,
            style: TextStyle(
              fontSize: 16,
             // fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                answer,
                style: TextStyle(fontSize: 16, color: Colors.orange[900]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

List<Map<String, String>> _faqList = [
  {
    'question': 'What is CharityMate?',
    'answer': 'CharityMate is a platform that connects donors with various charitable organizations and individuals in need. We aim to make giving easy, transparent, and impactful.'
  },
  {
    'question': 'How do I make a donation?',
    'answer': 'You can donate by selecting a cause, choosing a payment method, and confirming your contribution. All donations are processed securely.'
  },
  {
    'question': 'Is my donation tax-deductible?',
    'answer': 'It depends on the charity you are donating to. Please check with the respective organization for tax deduction eligibility.'
  },
  {
    'question': 'How do I track my donations?',
    'answer': 'You can track your past donations in the "My Donations" section of the app. We also send email confirmations for each transaction.'
  },
  {
    'question': 'Are my payment details secure?',
    'answer': 'Yes, we use encrypted transactions and secure payment gateways to ensure your data is protected.'
  },
  {
    'question': 'Can I volunteer through CharityMate?',
    'answer': 'Yes! We provide opportunities to volunteer for various causes. Check out the "Volunteer" section in the app to get involved.'
  },
  {
    'question': 'What if I have issues with my donation?',
    'answer': 'If you face any issues, please contact our support team at support@charitymate.com, and we will assist you as soon as possible.'
  },
  {
    'question': 'How can I verify the authenticity of a charity?',
    'answer': 'We carefully vet each charity on our platform, but we encourage users to do their own research before donating.'
  },
  {
    'question': 'Can I set up a recurring donation?',
    'answer': 'Yes, you can enable recurring donations in your settings to support your favorite charities on a regular basis.'
  },
  {
    'question': 'Is there a minimum donation amount?',
    'answer': 'Most charities accept donations of any amount, but some may have a minimum donation requirement.'
  },
  {
    'question': 'How can I get involved besides donating?',
    'answer': 'You can volunteer, spread awareness, or even start your own fundraising campaign through the app.'
  },
  {
    'question': 'Can I cancel a donation after making it?',
    'answer': 'Once a donation is processed, it is typically non-refundable. Please check the specific charity’s refund policy.'
  },
  {
    'question': 'How does CharityMate ensure transparency in fund usage?',
    'answer': 'We work with verified charities and provide detailed reports on how donations are utilized.'
  },
  {
    'question': 'Can I donate items instead of money?',
    'answer': 'Yes! Some charities accept item donations. You can check the "Item Donations" section in the app for more details.'
  },
  {
    'question': 'Does CharityMate charge any fees for donations?',
    'answer': 'CharityMate does not take a cut from your donation, but payment processors may charge a small transaction fee.'
  },
  {
    'question': 'How do I contact CharityMate for partnership opportunities?',
    'answer': 'For partnerships, please reach out to us at partnerships@charitymate.com.'
  },
];
