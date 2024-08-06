import 'package:flutter/material.dart';
import 'package:tasker/screen/add_task/Add_task.dart';
import 'package:tasker/screen/home/home_page.dart';
import 'package:tasker/screen/login/login.dart';
import 'package:tasker/screen/notification/notification.dart';
import 'package:tasker/screen/onboarding/onboarding.dart';
import 'package:tasker/screen/profile/profile_page.dart';
import 'package:tasker/screen/register/register.dart';

class RouteGenerator{
  static Route<dynamic> generateRoute(RouteSettings settings){
    switch(settings.name){
      case '/':
        return MaterialPageRoute(builder: (context)=>const HomePage());
      case '/onBoarding':
        return MaterialPageRoute(builder: (context)=>const OnBoardingPage());
      case '/register':
        return MaterialPageRoute(builder: (context)=>const RegisterPage());
      case '/login':
        return MaterialPageRoute(builder: (context)=>const LoginPage());
      case '/add-task':
        return MaterialPageRoute(builder: (context)=>const AddTask());
      case '/notification':
        return MaterialPageRoute(builder: (context)=>const NotificationPage());
      default:
        return MaterialPageRoute(builder: (context)=>Scaffold(
          appBar: AppBar(title: const Text("Error"),),
          body: const Center(child: Text("404 PAge Not Found"),),
        ));
    }
  }
}