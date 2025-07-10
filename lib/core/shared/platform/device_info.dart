// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:stream_chat_flutter/stream_chat_flutter.dart';

// import '../../injection_container.dart';
// import '../user/data/databases/user_local_database.dart';
// import '../user/data/databases/user_remote_database.dart';
// import '../util/TLoggerHelper.dart';

// /// Interacts with the device
// abstract class DeviceInfo {
//   /// Initialize local notification
//   Future<void> initializeNotification(StreamChatClient client);
// }

// /// Implements [DeviceInfo]
// class DeviceInfoImpl implements DeviceInfo {
//   /// Constructor
//   DeviceInfoImpl(this.localNotification);

//   /// local notification plugin
//   final FlutterLocalNotificationsPlugin localNotification;

//   @override
//   Future<void> initializeNotification(StreamChatClient client) async {
//     const initializationSettings = InitializationSettings(
//         android: AndroidInitializationSettings('@mipmap/launcher_icon'), iOS: DarwinInitializationSettings());
//     await localNotification.initialize(initializationSettings);

//     const channel = AndroidNotificationChannel(
//         'com.ulllest.app', // id
//         'Ullest', // title
//         importance: Importance.high,
//         enableLights: true);

//     /// Update the iOS foreground notification presentation options to allow
//     /// heads up notifications.
//     await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(alert: true, badge: true, sound: true);

//     FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
//       try {
//         final data = message.data;
//         final notification = message.notification;
//         final android = message.notification?.android;

//         print('data $data');
//         print('type of data ${data['type'].runtimeType}');

//         if (data['type'] == 'message.new') {
//           final messageId = data['id'].toString();
//           print('id $messageId id type ${messageId.runtimeType}');
//           final response = await client.getMessage(messageId);
//           await localNotification.show(
//             messageId.hashCode,
//             'New message from ${response.message.user!.name} in ${response.channel!.name}',
//             response.message.text,
//             NotificationDetails(android: AndroidNotificationDetails(channel.id, channel.name)),
//           );
//         }

//         if (data['type'] == 'profile.update') {
//           try {
//             final user = await sl<UserLocalDatabase>().retrieve();
//             final remoteUser = await sl<UserRemoteDatabase>().retrieveProfile(user.id);

//             await sl<UserLocalDatabase>().create(remoteUser);

//             await localNotification.show(message.hashCode, notification!.title, notification.body,
//                 NotificationDetails(android: AndroidNotificationDetails(channel.id, channel.name)));
//           } on Exception catch (e) {
//             // TODO
//             TLoggerHelper.error('Notification user update error $e');
//           }
//         }

//         if (notification != null && android != null) {
//           await localNotification.show(
//             message.hashCode,
//             message.notification!.title,
//             message.notification!.body,
//             NotificationDetails(android: AndroidNotificationDetails(channel.id, channel.name)),
//           );
//         }
//       } on Exception catch (e) {
//         TLoggerHelper.error('Notification Listener Error: $e');
//       }
//     });
//   }
// }
