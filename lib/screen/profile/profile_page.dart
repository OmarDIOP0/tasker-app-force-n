import 'package:flutter/material.dart';
import 'package:tasker/constantes/colors.dart';
import 'package:tasker/widget/ui_custom_profile_form.dart';
import 'package:tasker/widget/ui_custom_profile_password.dart';
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
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 50),
              const UICustumProfileForm(
                  value: "Omar DIOP",
                  comment: "utilisateur",
                  icon: Icon(Icons.person)
              ),
              const SizedBox(height: 20),
              const UICustumProfileForm(
                  value: "odiop@gmail.com",
                  comment: "email",
                  icon: Icon(Icons.mail)
              ),
              const SizedBox(height: 20),
              const UICustomProfilePassword(
                  password: "omardiop1234"
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: lightgreenColor
                ),
                onPressed: (){
                  print("modifier");
                },
                child: const Padding(
                  padding:EdgeInsets.all(10),
                  child:Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Modifier ',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white),),
                      SizedBox(width: 10),
                      Icon(Icons.edit,color: Colors.white,size: 30,),
                    ],
                  ),
                ),
              )
            ],
          ),
        )
    );
  }
}
