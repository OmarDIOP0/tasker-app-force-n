import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tasker/constantes/colors.dart';
import 'package:tasker/widget/routegenerator.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

Future<void> initNotifications() async{
  const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
  final InitializationSettings initializationSettings = InitializationSettings(android: initializationSettingsAndroid);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);
}

Future<void> checkAndRequestExactAlarmPermission() async {
  if (await Permission.scheduleExactAlarm.request().isGranted) {
  } else {
    throw PlatformException(
        code: 'exact_alarms_not_permitted',
        message: 'Les alarmes exactes ne sont pas autorisées');
  }
}


Future<void> scheduleNotification(int id, String title, String body, DateTime scheduledTime) async {
  await checkAndRequestExactAlarmPermission();
  tz.initializeTimeZones();
  final tz.TZDateTime scheduledDate = tz.TZDateTime.from(scheduledTime, tz.local);

  const AndroidNotificationDetails androidPlatformChannelSpecifics =
  AndroidNotificationDetails(
      'Tasker', 'Taster App',
      channelDescription: 'Application de gestion de tâches',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: false);
  const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics);

  await flutterLocalNotificationsPlugin.zonedSchedule(
    id,
    title,
    body,
    scheduledDate,
    platformChannelSpecifics,
    androidAllowWhileIdle: true,
    uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.wallClockTime,
  );
  print("Notification scheduled for $scheduledDate");
}


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  const storage = FlutterSecureStorage();
  String? token = await storage.read(key: 'token');
  String initialRoute = token == null ? '/login' : '/';
  await initNotifications();
  runApp(MyApp(initialRoute: initialRoute));
}

class MyApp extends StatelessWidget {
  final String initialRoute;

  const MyApp({Key? key, required this.initialRoute}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tasker',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: lightgreenColor),
        useMaterial3: true,
      ),
      initialRoute: initialRoute,
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
