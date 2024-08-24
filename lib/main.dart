import 'package:flutter/material.dart';
import 'package:tasker/constantes/colors.dart';
import 'package:tasker/services/notification_service.dart';
import 'package:tasker/widget/routegenerator.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  const storage = FlutterSecureStorage();
  String? token = await storage.read(key: 'token');
  String initialRoute = token == null ? '/login' : '/';
  await NotificationService().initNotifications();
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
