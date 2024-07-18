import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tasker/constantes/colors.dart';
import 'package:tasker/widget/ui_custom_Form.dart';
import 'package:tasker/widget/ui_custom_add_task_desc.dart';

class AddTask extends StatefulWidget {
  const AddTask({Key? key}) : super(key: key);

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  final _keyForm = GlobalKey<FormState>();
  TextEditingController nom_tache = TextEditingController();
  TextEditingController contenu_tache = TextEditingController();
  TextEditingController date = TextEditingController();
  TextEditingController priorite = TextEditingController();
  TextEditingController couleur = TextEditingController();
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarColor: verylightgreenColor
    ));
    return Scaffold(
      appBar: AppBar(title: const Text("AJOUTER UNE TACHE"),centerTitle: true,backgroundColor: verylightgreenColor,),
      body:Container(
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [verylightgreenColor,Colors.white,verylightgreenColor],
              begin: Alignment.topCenter,
              end:Alignment.bottomCenter,
            )
          ),
          padding: const EdgeInsets.only(top: 20),
          child:Form(
            key: _keyForm,
              child: Column(
                children: [
                  UICustomForm(
                      controller: nom_tache,
                      nameField: "Nom de la Tache",
                      comment: "nom_de_la_tache",
                      icon: const Icon(Icons.task)
                  ),
                  const SizedBox(height: 20),
                  UICustomAddTAskDesc(
                      contenu_tache: contenu_tache
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding:const EdgeInsets.only(left: 20,right: 20),
                    child: TextFormField(
                      controller: date,
                      decoration: InputDecoration(
                          prefixIcon:const  Icon(Icons.date_range),
                          hintText: "Date de la tache ?",
                          border:  OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)
                          )),
                      onTap: ()async{
                        DateTime? pickeDate =await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime(2100),
                        );
                        if(pickeDate != null){
                          setState(() {
                            date.text =pickeDate.toString();
                          });
                        }
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  UICustomForm(
                      controller: priorite,
                      nameField: "priorite",
                      comment: "Priorite",
                      icon:const Icon(Icons.priority_high)
                  ),
                  const SizedBox(height: 20),
                  UICustomForm(
                      controller: couleur,
                      nameField: "couleur",
                      comment: "couleur",
                      icon:const Icon(Icons.color_lens)
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: lightgreenColor
                    ),
                    onPressed: (){
                      if(_keyForm.currentState!.validate()){
                        print("Enregistrer");
                      }
                    },
                    child: const Padding(
                      padding:EdgeInsets.all(10),
                      child:Row(

                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('Enregistrer ',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white),),
                          SizedBox(width: 10),
                          Icon(Icons.add,color: Colors.white,size: 30,),
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
