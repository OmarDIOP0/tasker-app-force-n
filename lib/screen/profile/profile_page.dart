import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tasker/constantes/colors.dart';
import 'package:tasker/services/task_api.dart';
import 'package:tasker/widget/ui_custom_profile_form.dart';
import 'package:tasker/widget/ui_custom_profile_password.dart';
import '../../widget/scaffold_message.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _formKey = GlobalKey<FormState>();
  Map<String, dynamic>? _userinfo;
  late String _prenom;
  late String _nom;
  late String _username;
  late String _email;
  late String _password;
  String? _photoUrl;

  @override
  void initState() {
    super.initState();
    fetchProfile();
  }

  Future<void> _pickImage() async{
    final pickedFile= await ImagePicker().pickImage(source: ImageSource.gallery);
    if(pickedFile !=null){
      setState(() {
        _photoUrl = pickedFile.path;
      });
    }
  }

  Future<void> fetchProfile() async {
    try {
      final userInfo = await getUserProfile();
      setState(() {
        _userinfo = userInfo;
        _prenom = userInfo['prenom'];
        _nom = userInfo['nom'];
        _username = userInfo['username'];
        _email = userInfo['email'];
        _password = userInfo['password'];
        _photoUrl = userInfo['photo'];
      });
    } catch (e) {
      showSnackBar(context, "Erreur lors de la récupération des informations.", backgroundColor: Colors.redAccent);
    }
  }

  void _updateProfile() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      updateUser(context, _prenom, _nom, _email, _password, _username, _photoUrl!);
      showSnackBar(context, "Profil mis à jour avec succès.", backgroundColor: lightgreenColor);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(200),
        child: AppBar(
          title: _userinfo == null
              ? Center(child: CircularProgressIndicator())
              : Text(
            "${_userinfo?['prenom']} ${_userinfo?['nom']}",
            style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          automaticallyImplyLeading: false,
          backgroundColor: verylightgreenColor,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(50)),
          ),
          flexibleSpace: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const SizedBox(height: 20),
              GestureDetector(
                onTap: (){
                  _pickImage();
                },
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage:_photoUrl != null && _photoUrl!.isNotEmpty
                      ? FileImage(File(_photoUrl!)) as ImageProvider
                      : const AssetImage('assets/images/tasker.png') as ImageProvider,
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
      body: _userinfo == null
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: 30),
              Row(
                children: [
                  Expanded(
                    child: UICustumProfileForm(
                      value: _prenom,
                      comment: "Prénom",
                      icon: Icon(Icons.person),
                      onSaved: (newValue) {
                        _prenom = newValue!;
                      },
                    ),
                  ),
                  Expanded(
                    child: UICustumProfileForm(
                      value: _nom,
                      comment: "Nom",
                      icon: Icon(Icons.person),
                      onSaved: (newValue) {
                        _nom = newValue!;
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              UICustumProfileForm(
                value: _username,
                comment: "Nom d'utilisateur",
                icon: Icon(Icons.person),
                onSaved: (newValue) {
                  _username = newValue!;
                },
              ),
              const SizedBox(height: 20),
              UICustumProfileForm(
                value: _email,
                comment: "Email",
                icon: Icon(Icons.mail),
                onSaved: (newValue) {
                  _email = newValue!;
                },
              ),
              const SizedBox(height: 20),
              UICustomProfilePassword(
                password: _password,
                onSaved: (newValue) {
                  _password = newValue!;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(primary: lightgreenColor),
                onPressed: _updateProfile,
                child: const Padding(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Modifier ',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      SizedBox(width: 10),
                      Icon(Icons.edit, color: Colors.white, size: 30),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
