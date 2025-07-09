import 'package:flutter/foundation.dart';
//import '../models/notification_model.dart';
import 'notificationmodel.dart' show AppNotification;

class NotificationProvider with ChangeNotifier {
  final List<AppNotification> _notifications = [];

  List<AppNotification> get notifications => _notifications;

  void addNotification(AppNotification notification) {
    _notifications.insert(0, notification); // Add newest at top
    notifyListeners();
  }

  void clearNotifications() {
    _notifications.clear();
    notifyListeners();
  }
  void removeNotification(AppNotification notification) {
    _notifications.remove(notification);
    notifyListeners();
  }

}