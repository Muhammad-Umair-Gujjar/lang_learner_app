//
// import 'package:firebase_messaging/firebase_messaging.dart';
//
// class NotificationService {
//   static final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
//
//   static Future<void> initialize() async {
//
//     await _firebaseMessaging.requestPermission(
//       alert: true,
//       badge: true,
//       sound: true,
//     );
//
//     // Handle foreground notifications
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       _showLocalNotification(message);
//     });
//   }
//
//   static void _showLocalNotification(RemoteMessage message) {
//     print('Notification received: ${message.notification?.title}');
//   }
//
//   static Future<void> scheduleStreakReminder() async {
//     print('Scheduling streak reminder...');
//   }
// }