import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tasker/constantes/colors.dart';
import 'package:tasker/screen/home/home_page.dart';
import 'package:tasker/screen/onboarding/onboarding.dart';
import 'package:tasker/screen/register/register.dart';
import 'package:tasker/widget/routegenerator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tasker',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: lightgreenColor),
        useMaterial3: true,
      ),
      initialRoute: '/onBoarding',
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}

