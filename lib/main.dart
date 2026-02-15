import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:pickup_load_update/firebase_options.dart';
import 'package:pickup_load_update/src/controllers/language/langController.dart';
import 'package:pickup_load_update/src/pages/Trip%20History/trip_history_page.dart';
import 'package:pickup_load_update/src/service/hiveService.dart';
import 'package:pickup_load_update/src/service/hiveService.dart';
import 'src/app.dart';
import 'package:vibration/vibration.dart';

import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:vibration/vibration.dart';

import 'firebase_options.dart';

// ✅ ONLY ONE GLOBAL INSTANCE (VERY IMPORTANT)
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

/// ================= BACKGROUND HANDLER =================
Future<void> myBackgroundMessageHandler(RemoteMessage message) async {
  await Firebase.initializeApp();

  if (await Vibration.hasVibrator() ?? false) {
    Vibration.vibrate();
  }

  await displayLocalNotification(message);
}

/// ================= MAIN =================
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  /// Android 13+ permission
  await FirebaseMessaging.instance.requestPermission();

  /// Register background handler
  FirebaseMessaging.onBackgroundMessage(myBackgroundMessageHandler);

  /// Local storage + services
  await GetStorage.init();
  await Get.put(HiveService()).initHive();
  Get.put(LangController()).getDefaultLang();

  /// Initialize Local Notifications
  const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');

  const initSettings = InitializationSettings(
    android: androidSettings,
  );

  await flutterLocalNotificationsPlugin.initialize( settings: initSettings);

  /// Foreground message
  FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
    await displayLocalNotification(message);
  });

  /// When user taps notification
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    Get.to(() => AllTripHistoryController());
  });

  /// Orientation lock
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.manual,
    overlays: [SystemUiOverlay.top], // only status bar shown
  );

  /// Get FCM Token
  String? token = await FirebaseMessaging.instance.getToken();
  debugPrint("FCM Token: $token");
  GetStorage().write('fcm_token', token);

  runApp(App());
}

/// ================= LOCAL NOTIFICATION =================
Future<void> displayLocalNotification(RemoteMessage message) async {
  const androidDetails = AndroidNotificationDetails(
    'high_importance_channel',
    'High Importance Notifications',
    importance: Importance.max,
    priority: Priority.high,
    playSound: true,
    enableVibration: true,
  );

  const details = NotificationDetails(android: androidDetails);

  await flutterLocalNotificationsPlugin.show(
    id: 0,
    title:message.notification?.title ?? 'Notification',
    body:message.notification?.body ?? '',
    notificationDetails: details,
    payload: message.data.toString(),
  );
}
