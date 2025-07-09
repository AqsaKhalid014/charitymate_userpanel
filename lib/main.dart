
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:sahara_homepage/notificationmodel.dart';
import 'package:sahara_homepage/postscreen.dart';
import 'package:sahara_homepage/splashscreen.dart';
import 'Homescreen.dart';
import 'notification_provider.dart';
import 'profilescreen.dart';
import 'searchscreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'notification_service.dart';
import"notification screen.dart";
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  debugPrint("Handling background message: ${message.messageId}");
}
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

final FlutterLocalNotificationsPlugin flutterLocalNotificationPlugin =
FlutterLocalNotificationsPlugin();


void main() async {
 // final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

/////
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyC3emHhfQ-yG5ixf2xMnUnkK8amgNokZzw",
          appId: '1:129550855747:android:c824144550d988bee0eef6',
          messagingSenderId: "129550855747",
          projectId: "charitymate-bc611"));
  // 🟢 Initialize Supabase
  FirebaseMessaging.instance.onTokenRefresh.listen((newToken) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await FirebaseFirestore.instance.collection('user').doc(user.uid).set({
        'fcmToken': newToken,
      }, SetOptions(merge: true));
      print(" FCM token refreshed and updated");
    }
  }
  );
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  //await NotificationService();


  const AndroidInitializationSettings initializationSettingsAndroid =
  AndroidInitializationSettings('@mipmap/ic_launcher');

  const InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
  );

  await flutterLocalNotificationPlugin.initialize(initializationSettings,
      onDidReceiveNotificationResponse:(NotificationResponse response){
    if(navigatorKey.currentState!=null){
      navigatorKey.currentState!.pushNamed("/notifications");
    }
      }
          );
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    final notification = message.notification;
    if (notification != null) {
        final data = message.data;
        final requesterId = data['requesterId'] ?? ''; //  Extract UID from notification data
        final itemId = data['itemId']??'';
      final newNotification = AppNotification(
        title: notification.title ?? "no title",
        body: notification.body ?? "no body",
        receivedAt: DateTime.now(),
        uid: requesterId,
        itemId: itemId,
        //requesterId: requesterId,

      );

      // Add to provider
      final context = navigatorKey.currentContext!;
      Provider.of<NotificationProvider>(context, listen: false)
          .addNotification(newNotification);

      // Also add local notification
      flutterLocalNotificationPlugin.show(
        0,
        notification.title ?? "no title",
        notification.body ?? "no body",
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'channel_id', 'channel_name',
            importance: Importance.max,
            priority: Priority.high,
          ),
        ),
      );
    }
  });

  runApp(MultiProvider(providers: [ChangeNotifierProvider(create: (_)=>NotificationProvider()),
  ],
      child:MyApp(),),);
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
        useMaterial3: true,
      ),
      home: SplashScreen(),
      routes: {
        '/notifications': (context) => NotificationScreen(), // <-- Add this
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();

    NotificationService.initialize(context);

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      debugPrint(" App opened via notification");
    });
  }

  int current_index = 0;
  final screen = [
    const Homepage(),
    const NotificationScreen(),
    PostScreen(),
    const Profilescreen()
  ];

  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: current_index,
          onTap: (value) {
            current_index = value;
            setState(() {});
          },
          unselectedIconTheme: IconThemeData(color: Colors.grey),
          selectedIconTheme: IconThemeData(color: Colors.black),
          unselectedFontSize: 8,
          selectedFontSize: 10,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.notification_add), label: 'Notify'),
            BottomNavigationBarItem(
                icon: Icon(Icons.camera_alt_rounded), label: 'Posting'),
            BottomNavigationBarItem(
                icon: Icon(Icons.account_circle), label: 'Profile'),
          ]),
      backgroundColor: Colors.brown.shade100,
      body: screen[current_index],
    );
  }
}
