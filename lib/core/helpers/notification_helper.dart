// class ShowLocalNotification {

//   Future<void> initNotification() async {
//     const AndroidInitializationSettings initializationSettingsAndroid =
//         AndroidInitializationSettings('@mipmap/ic_launcher');

//     const InitializationSettings initializationSettings =
//          InitializationSettings(
//       android: initializationSettingsAndroid,
//     );

//     await flutterLocalNotificationsPlugin.initialize(initializationSettings,
//         onDidReceiveNotificationResponse: (NotificationResponse response) {
//       // Handle notification tapped logic here
//     });
//   }
//   final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();

//   void shownotificaton(String title, String body) async {
//     var android = const AndroidNotificationDetails('channel id', 'channel NAME',
//         priority: Priority.high, importance: Importance.max);
//     var platform = NotificationDetails(
//       android: android,
//     );
//     await flutterLocalNotificationsPlugin.show(0, title, body, platform,
//         payload: 'Welcome to the Local Notification demo ');
//   }

//   void prayTimeNotification(String title, String body) async {
//     var android = const AndroidNotificationDetails('channel id', 'channel NAME',
//         priority: Priority.high, importance: Importance.max);
//     var platform = NotificationDetails(
//       android: android,
//     );
//     await flutterLocalNotificationsPlugin.show(0, title, body, platform,
//         payload: 'Welcome to the Local Notification demo ');
//   }
// }
