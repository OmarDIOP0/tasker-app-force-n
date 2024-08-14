import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:tasker/constantes/colors.dart';
import 'package:tasker/screen/home/home_page.dart';
import 'package:tasker/screen/onboarding/onboarding.dart';
import 'package:tasker/screen/register/register.dart';
import 'package:tasker/services/task_api.dart';
import 'package:tasker/widget/routegenerator.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialisation conditionnelle pour sqflite_ffi
  if (!kIsWeb) {
    // Import et initialisation de sqflite_ffi si la plateforme n'est pas Web
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }

  const storage = FlutterSecureStorage();
  String? token = await storage.read(key: 'token');
  String initialRoute = token == null ? '/login' : '/';
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
