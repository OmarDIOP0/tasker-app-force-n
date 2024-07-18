import 'package:flutter/material.dart';
class UICustomAddTAskDesc extends StatelessWidget {
  final TextEditingController contenu_tache;
  const UICustomAddTAskDesc({Key? key,required this.contenu_tache}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
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
    );
  }
}
