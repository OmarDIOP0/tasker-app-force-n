import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tasker/constantes/colors.dart';
import 'package:tasker/widget/application_name.dart';
import 'package:tasker/widget/ui_custom_Form.dart';
import 'package:tasker/widget/ui_custom_container.dart';

class AccueilPage extends StatefulWidget {
  const AccueilPage({Key? key}) : super(key: key);

  @override
  State<AccueilPage> createState() => _AccueilPageState();
}

class _AccueilPageState extends State<AccueilPage> {
  TextEditingController search = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        systemNavigationBarColor: verylightgreenColor
    ));
    return Scaffold(
      appBar:AppBar(leading: const Icon(Icons.menu),
        title: const ApplicationName(size: 20),
        actions: const [
          Icon(Icons.notifications_active_outlined,size: 30),
          SizedBox(width: 10),
        ],
        centerTitle: true,
        backgroundColor: verylightgreenColor,
      ),
      body:Container(
        height: double.infinity,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors:[verylightgreenColor,Colors.white,verylightgreenColor,Colors.white],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            )
        ),
        child:  SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.only(left: 15,right: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  const Text('Hello ! '),
                  const SizedBox(height: 10),
                  const Text('Omar DIOP',style: TextStyle(fontSize: 15),),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 1.0),
                    child:Form(
                        key: _formKey,
                        child: Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                  controller: search,
                                  decoration: InputDecoration(
                                      prefixIcon: const Icon(Icons.search_rounded),
                                      labelText:"Rechercher",
                                      hintText: "rechercher",
                                      border:  OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(30)
                                      ),
                                      contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0)
                                  ),
                                  validator: (value){
                                    if(value==null || value.isEmpty){
                                      return "Saisir Quelque chose";
                                    }
                                    return null;
                                  }
                              ),
                            ),
                            TextButton(onPressed: (){
                              if(_formKey.currentState!.validate()){
                                print("<Welcome>");
                              }
                            }, child:const Text("Search"))
                          ],
                        )
                    ),
                  ),
                  const SizedBox(height: 10),
                  RichText(
                      text:const TextSpan(
                          style: TextStyle(
                              fontSize: 20,
                              color:Colors.black
                          ),
                          children: <TextSpan>[
                            TextSpan(text: 'Total :'),
                            TextSpan(text: ' 6',style: TextStyle(color: deepgreenColor,fontWeight: FontWeight.bold)),
                          ]
                      )
                  ),
                  const SizedBox(height: 15),
                  const Column(
                    children: [
                      UICustomContainer(
                          projetName: "Design du projet",
                          niveau: "Eleve",
                          color: Colors.red,
                          dateTime: "27 Juin 2024"
                      ),
                      SizedBox(height: 15),
                      UICustomContainer(
                          projetName: "Creation projet Flutter",
                          niveau: "Faible",
                          color: lightgreenColor,
                          dateTime: "02 Juillet 2024"
                      ),
                      SizedBox(height: 15),
                      UICustomContainer(
                          projetName: "Integration des interfaces",
                          niveau: "Moyenne",
                          color: Colors.yellow,
                          dateTime: "17 Juillet 2024"
                      ),
                      SizedBox(height: 15),
                       UICustomContainer(
                          projetName: "Design du projet",
                          niveau: "Eleve",
                          color: Colors.red,
                          dateTime: "27 Juin 2024"
                      ),
                      SizedBox(height: 15),
                      UICustomContainer(
                          projetName: "Creation projet Flutter",
                          niveau: "Faible",
                          color: lightgreenColor,
                          dateTime: "02 Juillet 2024"
                      ),
                      SizedBox(height: 15),
                      UICustomContainer(
                          projetName: "Integration des interfaces",
                          niveau: "Moyenne",
                          color: Colors.yellow,
                          dateTime: "17 Juillet 2024"
                      ),
                    ],
                  )
                ],
              )
            )
        ),
      ),
    );
  }
}
