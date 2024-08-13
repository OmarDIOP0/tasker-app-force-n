import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tasker/constantes/colors.dart';
import 'package:tasker/services/task_api.dart';
import 'package:tasker/widget/ui_custom_profile_form.dart';
import 'package:tasker/widget/ui_custom_profile_password.dart';
import 'package:http/http.dart' as http;

import '../../widget/scaffold_message.dart';
class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Map<String,dynamic>? _userinfo;

  @override
  void initState(){
    super.initState();
    fetchProfile();
  }
  Future<void> fetchProfile() async {
    try {
      final userInfo = await getUserProfile();
      setState(() {
        _userinfo = userInfo;
      });
    } catch (e) {
      showSnackBar(context, "Erreur lors de la récupération des informations.", backgroundColor: Colors.redAccent);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(200),
          child: AppBar(
            title:_userinfo== null
                ?Center(child: CircularProgressIndicator())
                :Text("${_userinfo!['prenom']} ${_userinfo!['nom']}",style: TextStyle(color: Colors.white,fontSize: 30,fontWeight: FontWeight.bold),),
            centerTitle: true,
            automaticallyImplyLeading: false,
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
        body: _userinfo == null
            ? Center(child: CircularProgressIndicator())
            :SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 50),
               Row(
                 children: [
                   Expanded(child:UICustumProfileForm(
                       value: "${_userinfo!['prenom']}",
                       comment: "prenom",
                       icon: Icon(Icons.person)
                   ),
                   ),
                   Expanded(child:UICustumProfileForm(
                       value: "${_userinfo!['nom']}",
                       comment: "nom",
                       icon: Icon(Icons.person)
                   ),
                   ),
                 ],
               ),
              const SizedBox(height: 20),
              UICustumProfileForm(
                  value: "${_userinfo!['username']}",
                  comment: "utilisateur",
                  icon: Icon(Icons.person)
              ),
              const SizedBox(height: 20),
              UICustumProfileForm(
                  value: "${_userinfo!['email']}",
                  comment: "email",
                  icon: Icon(Icons.mail)
              ),
              const SizedBox(height: 20),
              UICustomProfilePassword(
                  password: "${_userinfo!['password']}"
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: lightgreenColor
                ),
                onPressed: (){
                  updateUser(context,
                      _userinfo!['prenom'],
                      _userinfo!['nom'],
                      _userinfo!['email'],
                      _userinfo!['password'],
                      _userinfo!['username'],
                      _userinfo!['photo']
                  );
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
