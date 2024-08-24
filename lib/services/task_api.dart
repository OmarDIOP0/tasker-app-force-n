import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:tasker/services/NotificationModel.dart';
import 'package:tasker/services/notification_service.dart';
import '../constantes/colors.dart';
import '../widget/scaffold_message.dart';
import 'database_helper.dart';


const url = 'http://192.168.1.47:3000';

const storage =  FlutterSecureStorage();
final dbHelper = DatabaseHelper();

Future <void> addTask (BuildContext context,
    String title,String content,String priority,String color,String dueDate) async
{
   String?token= await storage.read(key: 'token');
   String?userId= await storage.read(key: 'userId');
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
      int taskId = jsonResponse['id'];
      DateTime parsedDueDate = DateTime.parse(dueDate);
      final dureeDeLaTache = parsedDueDate.difference(DateTime.now());
      String dureeFormat = "";
      if(dureeDeLaTache.inDays > 0){
         dureeFormat= '${dureeDeLaTache.inDays} jours';
      }else if (dureeDeLaTache.inHours > 0) {
         dureeFormat = '${dureeDeLaTache.inHours} heures';
      } else if (dureeDeLaTache.inMinutes > 0) {
         dureeFormat = '${dureeDeLaTache.inMinutes} minutes';
      } else {
         dureeFormat = '${dureeDeLaTache.inSeconds} secondes';
      }
      Map<String, dynamic> task = {
         'id': taskId,
         'title': title,
         'content': content,
         'priority': priority,
         'color': color,
         'dueDate': dueDate,
      };

      await NotificationService().showNotification(
                                 id:taskId,
                                 title:"Tâche créée",
                                 body:"La tâche '${jsonResponse['title']}' a été créée avec succès d'une durée de $dureeFormat"
                                 );

      await dbHelper.insertTask(task);
      await dbHelper.insertNotification(NotificationModel(
          id:taskId,
          title:"Tache",
          body: "La tâche '${jsonResponse['title']}' a été créée avec succès d'une durée de $dureeFormat",
          scheduledTime: DateTime.now(),
          userId: int.parse(userId!)
      ));
      showSnackBar(context, 'Tache "${jsonResponse['title']}" creer avec success !',backgroundColor: lightgreenColor);
   }
   else {
      showSnackBar(context, 'Erreur de Tache  !', backgroundColor: Colors.redAccent);
   }
}


Future<List<Map<String, dynamic>>> fetchTasks() async {
   String? token = await storage.read(key: 'token');

   try {
      final response = await http.get(Uri.parse("$url/task"),
          headers: {
             "Content-Type": "application/json",
             "Authorization": "Bearer $token",
          });

      if (response.statusCode == 200) {
         List<dynamic> tasksJson = jsonDecode(response.body);
         for (var task in tasksJson) {
            await dbHelper.insertTask(task);
         }
         return List<Map<String, dynamic>>.from(tasksJson);
      } else {
         throw Exception('Échec lors de la récupération de la liste des tâches');
      }
   } catch (e) {
      return await dbHelper.getTasks();
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
   final dbHelper = DatabaseHelper();
   final response = await http.delete(Uri.parse("$url/task/$id"),
      headers: {"Content-Type": "application/json","Authorization": "Bearer $token"},
   );
   if(response.statusCode == 200){
      dbHelper.deleteTask(id);
      dbHelper.deleteNotification(id);
      await NotificationService().showNotification(
         id: id,
         title: "Tâche Supprimée",
         body: "La tâche a été supprimée avec succès",
      );
      dbHelper.deleteNotification(id);
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
      await storage.write(key: 'userId', value: data['id'].toString());
      print("User ID stocké : ${data['id']}");
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



