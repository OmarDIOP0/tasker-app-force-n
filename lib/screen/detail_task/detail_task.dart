import 'package:flutter/material.dart';
import 'package:tasker/constantes/colors.dart';
import 'package:tasker/widget/ui_custom_Form.dart';
import 'package:tasker/widget/ui_custom_profile_form.dart';
class DetailTask extends StatefulWidget {
  final String nom_tache;
  final String contenu;
  final String date;
  final String priorite;
  final String couleur;
  const DetailTask({Key? key, required this.nom_tache, required this.contenu, required this.date, required this.priorite, required this.couleur}) : super(key: key);

  @override
  State<DetailTask> createState() => _DetailTaskState();
}

class _DetailTaskState extends State<DetailTask> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("DETAIL DE LA TACHE"),
        centerTitle: true,backgroundColor:verylightgreenColor,
      ),
      body:Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [verylightgreenColor,Colors.white,verylightgreenColor],
              begin: Alignment.topCenter,
              end:Alignment.bottomCenter,
            )
        ),
        padding: const EdgeInsets.only(top: 20),
          child: Column(
            children: [
              Text('Projet :${widget.nom_tache}'),
              Text('Contenu :${widget.contenu}'),
              Text('Date :${widget.date}'),
              Text('Priorite :${widget.priorite}'),
              Text('Couleur :${widget.couleur}',style: TextStyle(backgroundColor: Colors.red),),
            ],
          ),
        ),
    );
  }
}
