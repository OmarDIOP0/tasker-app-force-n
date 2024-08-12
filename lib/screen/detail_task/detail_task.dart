import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tasker/constantes/colors.dart';
import 'package:tasker/services/task_api.dart';
import 'package:tasker/widget/ui_custom_Form.dart';
import 'package:tasker/widget/ui_custom_profile_form.dart';
import 'package:share_plus/share_plus.dart';

class DetailTask extends StatefulWidget {
  final int id;
  final String nom_tache;
  final String contenu;
  final String date;
  final String priorite;
  final String couleur;
  const DetailTask({Key? key,required this.id, required this.nom_tache, required this.contenu, required this.date, required this.priorite, required this.couleur}) : super(key: key);

  @override
  State<DetailTask> createState() => _DetailTaskState();
}

class _DetailTaskState extends State<DetailTask> {
  Map<String, dynamic>? taskDetails;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchTaskDetails();
  }
  String formatDueDate(String dateStr){
    DateTime date = DateTime.parse(dateStr);
    return DateFormat('dd MMMM yyyy').format(date);
  }
  void fetchTaskDetails() async {
    try {
      Map<String, dynamic> details = await fetchTaskById(widget.id);
      setState(() {
        taskDetails = details;
        _isLoading = false;
      });
    } catch (error) {
      print("Erreur lors de la récupération des détails de la tâche : $error");
      setState(() {
        _isLoading = false;
      });
    }
  }
  void shareTaskDetails(){
    Share.share('Tache : $taskDetails["title"] \n Contenu : $taskDetails["content"]' );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("DÉTAIL DE LA TÂCHE"),
        centerTitle: true,
        backgroundColor: verylightgreenColor,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : taskDetails == null
          ? const Center(child: Text("Erreur de chargement"))
          : SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [verylightgreenColor, Colors.white, verylightgreenColor],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          padding: const EdgeInsets.only(top: 20),
          child: Column(
            children: [
              const SizedBox(height: 30),
              UICustumProfileForm(
                value: taskDetails!['title'] ?? 'No Title',
                comment: "Nom de la tâche",
                icon: const Icon(Icons.task),
              ),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: TextFormField(
                  initialValue: taskDetails!['content'] ?? 'No Content',
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.description_outlined),
                    hintText: "Contenu de la tâche",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    contentPadding: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              UICustumProfileForm(
                value: 'Création : ${formatDueDate(taskDetails!['createdAt'] ?? '')}',
                comment: "Création de la tâche",
                icon: const Icon(Icons.date_range),
              ),
              const SizedBox(height: 30),
              UICustumProfileForm(
                value: 'Modification : ${formatDueDate(taskDetails!['updatedAt'] ?? '')}',
                comment: "Modification de la tâche",
                icon: const Icon(Icons.date_range),
              ),
              const SizedBox(height: 30),
              UICustumProfileForm(
                value: taskDetails!['color'] ?? 'No Color',
                comment: "Couleur de la tâche",
                icon: const Icon(Icons.color_lens),
              ),
              const SizedBox(height: 30),
              Row(
                children: [
                  const SizedBox(width: 20),
                  const Text("Priorité :"),
                  const SizedBox(width: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 70),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: taskDetails!['color'] == 'red'
                          ? Colors.red
                          : taskDetails!['color'] == 'green'
                          ? lightgreenColor
                          : Colors.yellow,
                    ),
                    child: Text(taskDetails!['priority'] ?? 'No Priority'),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(onPressed: () {
                    shareTaskDetails();
                  }, icon: const Icon(Icons.share)),
                  IconButton(
                      onPressed: () {
                        updateTask(
                          context,
                          widget.id,
                          taskDetails!['title'] ?? 'No Title',
                          taskDetails!['content'] ?? 'No Content',
                          taskDetails!['priority'] ?? 'No Priority',
                          taskDetails!['color'] ?? 'yellow',
                          taskDetails!['dueDate'] ?? '',
                        );
                        Navigator.pop(context);
                        setState(() {
                          _isLoading =true;
                        });
                      },
                      icon: const Icon(Icons.edit)),
                  IconButton(
                      onPressed: () {
                        deleteTask(context, widget.id);
                        Navigator.pushNamed(context, '/');
                      },
                      icon: const Icon(Icons.delete))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

