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
      body:SingleChildScrollView(
        child: Container(
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
              const SizedBox(height: 30),
              UICustumProfileForm(
                value: widget.nom_tache,
                comment: "Nom de la tache",
                icon: const Icon(Icons.task),
              ),
              const SizedBox(height: 30),
              Padding(
                padding:const EdgeInsets.only(left: 20,right: 20),
                child: TextFormField(
                  initialValue: widget.contenu,
                  decoration: InputDecoration(
                      prefixIcon:const  Icon(Icons.description_outlined),
                      hintText: "contenu_de_la_tache",
                      border:  OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)
                      ),
                      contentPadding: const EdgeInsets.symmetric(vertical: 50,horizontal: 20)
                  ),
                ),
              ),
              const SizedBox(height: 30),
              UICustumProfileForm(
                value: 'Creation :${widget.date}',
                comment: "Creation de la tache",
                icon: const Icon(Icons.date_range),
              ),
              const SizedBox(height: 30),
              UICustumProfileForm(
                value: 'Modification :${widget.date}',
                comment: "Modification de la tache",
                icon: const Icon(Icons.date_range),
              ),
              const SizedBox(height: 30),
              UICustumProfileForm(
                value: widget.couleur,
                comment: "Couleur de la tache",
                icon: const Icon(Icons.color_lens),
              ),
              const SizedBox(height: 30),
              Row(
                children: [
                  const SizedBox(width: 20),
                  const Text("Priorite :"),
                  const SizedBox(width: 10),
                  Container(
                    padding:const EdgeInsets.symmetric(vertical: 10,horizontal: 70),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: widget.couleur == 'red'
                               ? Colors.red
                               : widget.couleur == 'green'
                               ? lightgreenColor
                               : Colors.yellow
                    ),
                    child: Text(widget.priorite),
                  ),
                ],
              )
            ],
          ),
        ),
      )
    );
  }
}
