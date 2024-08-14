import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tasker/constantes/colors.dart';
import 'package:tasker/services/task_api.dart';
import 'package:tasker/widget/scaffold_message.dart';
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

  const DetailTask({
    Key? key,
    required this.id,
    required this.nom_tache,
    required this.contenu,
    required this.date,
    required this.priorite,
    required this.couleur,
  }) : super(key: key);

  @override
  State<DetailTask> createState() => _DetailTaskState();
}

class _DetailTaskState extends State<DetailTask> {
  Map<String, dynamic>? taskDetails;
  bool _isLoading = true;
  final _formKey = GlobalKey<FormState>();
  late String _title;
  late String _content;
  late String _priority;
  late String _color;
  late String _dueDate;

  @override
  void initState() {
    super.initState();
    fetchTaskDetails();
    _title = widget.nom_tache;
    _content = widget.contenu;
    _priority = widget.priorite;
    _color = widget.couleur;
    _dueDate = widget.date;
  }

  Future<void> _updateTask() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      try {
        await updateTask(context, widget.id, _title, _content, _priority, _color, _dueDate);
        fetchTasks();
        Navigator.of(context).pop(true);
      } catch (e) {
        showSnackBar(context, "Erreur $e", backgroundColor: Colors.redAccent);
      }
    }
  }

  String formatDueDate(String dateStr) {
    DateTime date = DateTime.parse(dateStr);
    return DateFormat('dd MMMM yyyy').format(date);
  }

  void fetchTaskDetails() async {
    try {
      Map<String, dynamic> details = await fetchTaskById(widget.id);
      setState(() {
        taskDetails = details;
        _title = details['title'] ?? '';
        _content = details['content'] ?? '';
        _priority = details['priority'] ?? '';
        _color = details['color'] ?? '';
        _dueDate = details['dueDate'] ?? '';
        _isLoading = false;
      });
    } catch (error) {
      print("Erreur lors de la récupération des détails de la tâche : $error");
      setState(() {
        _isLoading = false;
      });
    }
  }

  void shareTaskDetails() {
    Share.share('Tâche : ${taskDetails!["title"]} \n Contenu : ${taskDetails!["content"]}');
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
        child: Form(
          key: _formKey,
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
                Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                  child: TextFormField(
                    initialValue: _title,
                    decoration: InputDecoration(
                      labelText: "Nom de la tâche",
                      prefixIcon: const Icon(Icons.task),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    onSaved: (value) => _title = value!,
                  ),
                ),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: TextFormField(
                    initialValue: _content,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.description_outlined),
                      hintText: "Contenu de la tâche",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 50, horizontal: 20),
                    ),
                    onSaved: (value) => _content = value!,
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
                  value: _color,
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
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 70),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: _color == 'red'
                            ? Colors.red
                            : _color == 'green'
                            ? lightgreenColor
                            : Colors.yellow,
                      ),
                      child: Text(_priority),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                        onPressed: () {
                          shareTaskDetails();
                        },
                        icon: const Icon(Icons.share)),
                    IconButton(
                        onPressed: () {
                          _updateTask();
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
      ),
    );
  }
}
