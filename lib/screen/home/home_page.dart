import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tasker/constantes/colors.dart';
import 'package:tasker/screen/accueil/accueil_page.dart';
import 'package:tasker/screen/profile/profile_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex=0;
  final List _childreenPage =[
      const AccueilPage(),
      const ProfilePage()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _childreenPage[_currentIndex],
      bottomNavigationBar:BottomNavigationBar(
            unselectedItemColor: Colors.white,
            selectedItemColor: deepgreenColor,
            backgroundColor: verylightgreenColor,
            currentIndex: _currentIndex,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.task_alt),label: "Tache"),
              BottomNavigationBarItem(icon: Icon(Icons.person),label: "Profile")
            ],
            onTap: (index){
              setState(() {
                _currentIndex=index;
              });
            },
      )
    );
  }
}

