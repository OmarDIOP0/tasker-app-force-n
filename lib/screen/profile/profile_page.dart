import 'package:flutter/material.dart';
import 'package:tasker/constantes/colors.dart';
class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(200),
          child: AppBar(
            title:const Text('Omar DIOP',style: TextStyle(color: Colors.white,fontSize: 30,fontWeight: FontWeight.bold),),
            centerTitle: true,
            backgroundColor: verylightgreenColor,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(50)
              )
            ),
            flexibleSpace: const Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(height: 20),
                CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage('assets/images/avatar.png')
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
      ),
      body: const Center(
        child: Text("Profile Page"),
      ),
    );
  }
}
