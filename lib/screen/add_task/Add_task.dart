import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tasker/widget/ui_custom_Form.dart';

class AddTask extends StatefulWidget {
  const AddTask({Key? key}) : super(key: key);

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  TextEditingController nom_tache = TextEditingController();
  TextEditingController contenu_tache = TextEditingController();
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.white
    ));
    return Scaffold(
      appBar: AppBar(title: Text("ADD TASK"),),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(top: 10),
          child:Column(
            children: [
              UICustomForm(
                  controller: nom_tache,
                  nameField: "Nom de la Tache",
                  comment: "nom_de_la_tache",
                  icon: const Icon(Icons.task)
              ),
              const SizedBox(height: 10),
          Padding(
            padding:const EdgeInsets.only(left: 20,right: 20),
            child: TextFormField(
                controller: contenu_tache,
                decoration: InputDecoration(
                    prefixIcon:const  Icon(Icons.description_outlined),
                    labelText:"Contenu de la Tache",
                    hintText: "contenu_de_la_tache",
                    border:  OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)
                    ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 50,horizontal: 20)
                ),
                validator: (value){
                  if(value==null || value.isEmpty){
                    return "Le champs est obligatoire";
                  }
                  return null;
                }
            ),
            )
            ],
          ),
        ),
      )
    );
  }
}
