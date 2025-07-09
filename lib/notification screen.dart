import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:googleapis_auth/auth.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:sahara_homepage/user%20profile.dart';
//import '../models/notification_model.dart';
import 'RequesterProfileSreen.dart';
import 'notification_provider.dart';
import 'notificationmodel.dart';       // Adjust the path

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  Future<String> getAccessToken() async {
    final jsonString = await rootBundle.loadString(
        'assets/charitymate-bc611-firebase-adminsdk-fbsvc-8d75db682f.json');

    final serviceAccountCredentials =
    ServiceAccountCredentials.fromJson(jsonDecode(jsonString));

    final authClient = await clientViaServiceAccount(
      serviceAccountCredentials,
      ['https://www.googleapis.com/auth/firebase.messaging'],
    );

    final accessToken = (await authClient.credentials.accessToken).data;
    return accessToken;
  }

  void handleRequestAction(String requesterId, bool accept,{ required String? itemId, required String ? collection}) async {
    final tokenDoc = await FirebaseFirestore.instance
        .collection('user')
        .doc(requesterId)
        .get();

    final requesterToken = tokenDoc.data()?['fcmToken'];
    if (requesterToken == null) return;

    final message = {
      "message": {
        "token": requesterToken,
        "notification": {
          "title": "Request Update",
          "body": accept
              ? "Your  request was accepted!"
              : "Your  request was rejected."
        },
        "data": {
          "status": accept ? "accepted" : "rejected",
          "click_action": "FLUTTER_NOTIFICATION_CLICK",
        }
      }
    };

    final accessToken = await getAccessToken();

    final response = await http.post(
      Uri.parse('https://fcm.googleapis.com/v1/projects/charitymate-bc611/messages:send'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
      body: jsonEncode(message),
    );

    if (response.statusCode == 200) {
      print("Requester notified.");
    } else {
      print("Failed to notify requester.");
    }


    if (accept && itemId != null && collection != null) {
      await FirebaseFirestore.instance.collection(collection).doc(itemId).delete();
      print("item $itemId removed from $collection after accept request");
    }

  }

  @override
  Widget build(BuildContext context) {
    final notifications = Provider.of<NotificationProvider>(context).notifications;

    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.orange.shade400,
        title: const Text("Notifications"),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_forever),
            onPressed: () {
              Provider.of<NotificationProvider>(context, listen: false).clearNotifications();
            },
          )
        ],
      ),
      body: notifications.isEmpty
          ? const Center(child: Text("No notifications yet."))
          : ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final AppNotification notif = notifications[index];
          String? collection;          // 🔍 Determine collection name based on title

          if (notif.title == 'Food Request') collection = 'Food';
          else if (notif.title == 'Cloth Request') collection = 'clothes';
          else if (notif.title == 'Furniture Request') collection = 'Furniture';
          else if (notif.title == 'Stationary Request') collection = 'Stationery';
          else if (notif.title == 'Medical Request') collection = 'medical';
          else if (notif.title == 'other item Request') collection = 'other item';

          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 13,
                  ),

                  horizontalTitleGap: 2,
                  leading: const Icon(Icons.notifications),
                  title: Text(notif.title),
                  subtitle: Text(notif.body),
                  trailing: Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "${notif.receivedAt.hour.toString().padLeft(2, '0')}:${notif.receivedAt.minute.toString().padLeft(2, '0')}",
                          style: const TextStyle(fontSize: 12),
                        ),
                              SizedBox(width: 1,),



                      ],
                    ),
                  ),
                ),
                (["Food Request","Furniture Request","Cloth Request","Stationary Request","Medical Request","other item Request"]).contains(notif.title)?
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [

                    TextButton(onPressed: ()async{_acceptRequest(context,notif.uid);//show profile
                              // Notify requester
                               if (notif.uid != null && notif.uid.isNotEmpty && notif.itemId != null) {
                                    handleRequestAction(notif.uid, true,itemId: notif.itemId, collection: collection); // true = accepted
                                  }},

                        child: Text("Accept Request")),
                    TextButton(onPressed: ()async{
                      Provider.of<NotificationProvider>(context, listen: false).removeNotification(notif);//// Remove notification from list
                      // Notify requester
                      if (notif.uid != null && notif.uid.isNotEmpty) {
                        handleRequestAction(notif.uid, false,itemId: notif.itemId,collection: collection); // false = rejected
                      }
                    },
                     child: Text("Reject request"))
                  ],
                )
                    :const SizedBox.shrink(),
              ],
            ),
          );
        },
      ),
    );
  }
}

void _acceptRequest(BuildContext context,String? uid)async{
  if (uid == null || uid.isEmpty) {
    print("Requester UID is null or empty");
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Requester UID missing.")),
    );
    return;
  }
  print("Fetching profile for UID: $uid");
  final requesterprofile = await fetchUserProfile(uid);
  if(requesterprofile!=null){
    Navigator.push(context, MaterialPageRoute(builder: (context)=>RequesterProfileScreen(requesterUid:uid),),);
  }else
    {
      print("No profile found for UID: $uid");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Requester profile not found.")),
      );}
}
Future<Map<String, dynamic>?> fetchUserProfile(String userId) async {
  print("Fetching user profile for UID: $userId");

  final doc = await FirebaseFirestore.instance
      .collection('users personal data')
      .doc(userId)
      .get();

  if (doc.exists) {
    print("Profile data: ${doc.data()}");
    return doc.data();
  } else {
    print("No document found for UID: $userId");
  }
  return null;
}

