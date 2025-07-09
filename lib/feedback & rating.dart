import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sahara_homepage/morescreen.dart';
import 'package:sahara_homepage/postscreen.dart';
import 'functions.dart';
class FeedbackScreen extends StatefulWidget {
  @override
  _FeedbackScreenState createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  double _rating = 0.0;
  TextEditingController _feedbackController = TextEditingController();

  void _submitFeedback() async {
    if (_rating <= 0 || _feedbackController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please provide both rating and feedback")),
      );
      return;
    }

    try {
      await FirebaseFirestore.instance.collection('feedback').add({
        'rating': _rating,
        'feedback': _feedbackController.text.trim(),
        'timestamp': Timestamp.now(),
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Thank you for your feedback!")),
      );

      _feedbackController.clear();
      setState(() {
        _rating = 0.0;
      });
    } catch (e) {
      print("Error submitting feedback: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error submitting feedback. Try again!")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Feedback & Rating"),backgroundColor: Colors.orange.shade400,),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Container(
         decoration: BoxDecoration(
           color: Colors.orange.shade50,
border: Border.all(color: Colors.orangeAccent.shade400),
borderRadius: BorderRadius.all(Radius.circular(10),

)
         ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 40,),
                Text(" How do you rate our service?", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Row(
                  children: List.generate(5, (index) {
                    return IconButton(
                      icon: Icon(
                        index < _rating ? Icons.star : Icons.star_border,
                        color: Colors.orangeAccent,
                      ),
                      onPressed: () {
                        setState(() {
                          _rating = (index + 1).toDouble();
                        });
                      },
                    );
                  }),
                ), Text(" Write your feedback!", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
SizedBox(height: 10,),
                TextField(
                  controller: _feedbackController,
                  decoration: InputDecoration(
                    labelText: "Tell us more about your experience?",
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 3,
                ),
                SizedBox(height: 10),
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.orangeAccent.shade100),
                    onPressed: _submitFeedback,
                    child: Text("Send feedback",style: TextStyle(color: Colors.black),),
                  ),
                ),
                SizedBox(height: 20),
                Text(" Recent Feedback", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Expanded(child: FeedbackList()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class FeedbackList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('feedback').orderBy('timestamp', descending: true).limit(5).snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }

        var feedbacks = snapshot.data!.docs;

        return ListView(
          children: feedbacks.map((feedback) {
            return ListTile(
              leading: Icon(Icons.star, color: Colors.orangeAccent),
              title: Text(feedback['feedback']),
              subtitle: Text("Rating: ${feedback['rating']} ⭐"),
            );
          }).toList(),
        );
      },
    );
  }
}
