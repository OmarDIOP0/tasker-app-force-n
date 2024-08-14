import 'dart:convert';
import 'dart:js';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:tasker/screen/profile/profile_page.dart';
import '../constantes/colors.dart';
import '../widget/scaffold_message.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

const url = 'http://127.0.0.1:3000';

const storage =  FlutterSecureStorage();

Future <void> addTask (BuildContext context,
    String title,String content,String priority,String color,String dueDate) async
{
   String?token= await storage.read(key: 'token');
   Map list= {
      'title': title,
      'content':content,
      'priority':priority,
      'color':color,
      'dueDate':dueDate
   };
   final response = await http.post(Uri.parse("$url/task"),
      headers: {"Content-Type":"application/json","Authorization": "Bearer $token",},
      body:jsonEncode(list)
   );
   if (response.statusCode == 201){
      final jsonResponse = jsonDecode(response.body);
      showSnackBar(context, 'Tache "${jsonResponse['title']}" creer avec success !',backgroundColor: lightgreenColor);
   }
   else {
      showSnackBar(context, 'Erreur de Tache  !', backgroundColor: Colors.redAccent);
   }
}

Future <List<Map<String,dynamic>>> fetchTasks() async {
   String?token= await storage.read(key: 'token');
   if (token == null) {
      throw Exception('Token non trouvé, l\'utilisateur n\'est peut-être pas connecté.');
   }
   final response = await http.get(Uri.parse("$url/task"),
   headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token",
   }
   );
   if(response.statusCode ==200){
      List<dynamic> tasksJson = jsonDecode(response.body);
      return List<Map<String,dynamic>>.from(tasksJson);
   }
   else{
      throw Exception('Echec lors de la recuperation de la liste des tache');
   }
}
Future<Map<String, dynamic>> fetchTaskById(int id) async {
   String?token= await storage.read(key: 'token');
   final response = await http.get(Uri.parse("$url/task/$id"),
       headers: {
       "Content-Type": "application/json",
       "Authorization": "Bearer $token",
       }
   );
   if (response.statusCode == 200) {
      return jsonDecode(response.body);
   } else {
      throw Exception('Échec lors de la récupération de la tâche');
   }
}


Future<void> updateTask(
    BuildContext context,
    int id,
    String title,
    String content,
    String priority,
    String color,
    String dueDate
    ) async {
   Map<String, dynamic> updateTask = {
      'title': title,
      'content': content,
      'priority': priority,
      'color': color,
      'dueDate': dueDate,
   };
   try {
      String?token= await storage.read(key: 'token');
      final response = await http.patch(
         Uri.parse("$url/task/$id"),
         headers: {"Content-Type": "application/json","Authorization": "Bearer $token"},
         body: jsonEncode(updateTask),
      );

      if (response.statusCode == 200) {
         final jsonResponse = jsonDecode(response.body);
         showSnackBar(context, 'Tâche "${jsonResponse['title']}" mise à jour avec succès', backgroundColor: lightgreenColor,);
      } else {
         print('Erreur: ${response.statusCode}, Corps de la réponse: ${response.body}');
         showSnackBar(context, 'Erreur lors de la mise à jour de la tâche', backgroundColor: Colors.redAccent,);
      }
   } catch (e) {
      print('Exception $e');
      showSnackBar(context, 'Erreur de réseau !', backgroundColor: Colors.redAccent,);
   }
}


Future<void> deleteTask(BuildContext context,int id) async{
   String?token= await storage.read(key: 'token');
   final response = await http.delete(Uri.parse("$url/task/$id"),
      headers: {"Content-Type": "application/json","Authorization": "Bearer $token"},
   );
   if(response.statusCode == 200){
      showSnackBar(context, 'Tâche supprimée avec succès!', backgroundColor: Colors.redAccent);
   }else{
      showSnackBar(context, 'Erreur lors de la suppression de la tâche!', backgroundColor: Colors.redAccent);
   }
}
Future<void> register(BuildContext context,
    String prenom,
    String nom,
    String email,
    String password,
    String username,
    String photo) async{
   final response = await http.post(Uri.parse("$url/auths/register"),
       headers: {'Content-Type':'application/json'},
      body:jsonEncode({'prenom':prenom,'nom':nom,'email':email,'password':password,'username':username,'photo':photo}),
   );
   if(response.statusCode == 201){
      showSnackBar(context, "User add Successfully",backgroundColor: lightgreenColor);
      Navigator.pushNamed(context, '/login');
   }else{
      showSnackBar(context, "Erreur lors de l'inscription!", backgroundColor: Colors.redAccent);
      throw Exception("Erreur lors de l'inscription");
   }
}
Future<void> login(BuildContext context,
       String username,
    String password) async{
   final response = await http.post(Uri.parse("$url/auths/login"),
      headers: {'Content-Type':'application/json'},
      body:jsonEncode({'username':username,'password':password}),
   );
   if(response.statusCode ==200){
      final data = jsonDecode(response.body);
      await storage.write(key: 'token', value: data['access_token']);
      showSnackBar(context, "Login Successfully",backgroundColor: lightgreenColor);
      Navigator.pushNamed(context, '/');
   }
   else if(response.statusCode==401)
   {
      showSnackBar(context, "Utilisateur non trouve",backgroundColor: Colors.redAccent);
      throw Exception('Echec lors de la connexion');
   }
   else{
      showSnackBar(context, "Echec lors de la connexion",backgroundColor: Colors.redAccent);
      throw Exception('Echec lors de la connexion');
   }
}

Future<String?> getToken() async {
   return await storage.read(key: 'token');
}
Future<void> logout() async {
   await storage.delete(key: 'token');
}
Future<void> updateUser(
    BuildContext context,
    String prenom,
    String nom,
    String email,
    String password,
    String username,
    String photo
    ) async {
   Map<String, dynamic> updateUserData = {
      'prenom': prenom,
      'nom': nom,
      'email': email,
      'password': password,
      'username': username,
      'photo':photo
   };

   try {
      String? token = await storage.read(key: 'token');
      final response = await http.put(
         Uri.parse("$url/auths/profils"),
         headers: {"Content-Type": "application/json","Authorization": "Bearer $token"},
         body: jsonEncode(updateUserData),
      );

      if (response.statusCode == 200) {
         final jsonResponse = jsonDecode(response.body);
         print('Updated user info: $jsonResponse');
         showSnackBar(context, 'Profil mise à jour avec succès', backgroundColor: lightgreenColor,);
         await getUserProfile();
         Navigator.pushNamed(context, '/');
      } else {
         showSnackBar(context, 'Erreur lors de la mise à jour du profil', backgroundColor: Colors.redAccent,);
      }
   } catch (e) {
      print('Exception $e');
      showSnackBar(context, 'Erreur de réseau !', backgroundColor: Colors.redAccent,);
   }
}

Future<Map<String,dynamic>> getUserProfile() async {
   String? token = await storage.read(key: 'token');
   final response = await http.get(Uri.parse("$url/auths/profils"),
   headers: {"Content-Type":"application/json","Authorization": "Bearer $token"},
   );
   if (response.statusCode==200){
      return jsonDecode(response.body);
   }
   else{
      throw Exception("Echec lors de la recuperation des info de l'utilisateur");
   }
}



