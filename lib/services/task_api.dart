import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../constantes/colors.dart';
import '../widget/scaffold_message.dart';

const url = 'http://127.0.0.1:3000';
Future <void> addTask (BuildContext context,
    String title,String content,String priority,String color,String dueDate) async
{
   Map list= {
      'title': title,
      'content':content,
      'priority':priority,
      'color':color,
      'dueDate':dueDate
   };
   final response = await http.post(Uri.parse("$url/task"),
      headers: {"Content-Type":"application/json"},
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
   final response = await http.get(Uri.parse("$url/task"));
   if(response.statusCode ==200){
      List<dynamic> tasksJson = jsonDecode(response.body);
      return List<Map<String,dynamic>>.from(tasksJson);
   }
   else{
      throw Exception('Echec lors de la recuperation de la liste des tache');
   }
}
Future<Map<String, dynamic>> fetchTaskById(int id) async {
   final response = await http.get(Uri.parse("$url/task/$id"));
   if (response.statusCode == 200) {
      return jsonDecode(response.body);
   } else {
      throw Exception('Échec lors de la récupération de la tâche');
   }
}


Future<void> updateTask(BuildContext context,
    int id,String title,String content,String priority,String color,String dueDate) async{
   Map<String,dynamic> updateTask = {
      'title':title,
      'content':content,
      'priority':priority,
      'color':color,
      'dueDate':dueDate
   };
   try{
      final response = await http.patch(Uri.parse("$url/task/$id"),
          headers: {"Content-Type":"application/json"},
          body: jsonEncode(updateTask)
      );
      if(response.statusCode ==200){
         final jsonResponse = jsonDecode(response.body);
         showSnackBar(context, 'Tache " ${jsonResponse['title']}" mise a jour avec success',backgroundColor: lightgreenColor);
      }else{
         print('Erreur: ${response.statusCode}, Corps de la réponse: ${response.body}');
         showSnackBar(context, 'Erreur lors de la mise a jour de la tache',backgroundColor: Colors.redAccent);
      }
   }
   catch (e){
      print('Exception $e');
      showSnackBar(context, 'Erreur de réseau !', backgroundColor: Colors.redAccent);
   }
}

Future<void> deleteTask(BuildContext context,int id) async{
   final response = await http.delete(Uri.parse("$url/task/$id"));
   if(response.statusCode == 200){
      showSnackBar(context, 'Tâche supprimée avec succès!', backgroundColor: Colors.redAccent);
   }else{
      showSnackBar(context, 'Erreur lors de la suppression de la tâche!', backgroundColor: Colors.redAccent);
   }
}