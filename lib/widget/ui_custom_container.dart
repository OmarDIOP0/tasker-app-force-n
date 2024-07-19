import 'package:flutter/material.dart';
import 'package:tasker/constantes/colors.dart';

class UICustomContainer extends StatelessWidget {
  final String projetName ;
  final String niveau;
  final Color color;
  final String dateTime;

  const UICustomContainer({Key? key, required this.projetName, required this.niveau, required this.color, required this.dateTime}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
      //GestureDetector(
      //onTap: (){
       // print("Vous avez clique sur le projet : $projetName");
      //},
     // child:
    ClipRRect(
        child: Container(
          padding:const EdgeInsets.only(left: 10,top: 0,bottom: 2),
          height: 120,
          decoration: BoxDecoration(
            border: Border.all(color: deepgreenColor,width: 2),
            borderRadius:BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.light_mode_sharp,color: lightgreenColor,),
                      const SizedBox(width: 10),
                      Text(projetName ,style: const TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                    ],
                  ),
                  Row(
                    children: [
                      PopupMenuButton<String>(
                        onSelected: (value){
                          print("Action selectionnée : $value");
                        },
                        itemBuilder: (BuildContext context){
                          return {'Modifier','Supprimer'}
                              .map((String choice){
                            return PopupMenuItem<String>(
                              value: choice,
                              child: Text(choice),
                            );
                          }).toList();
                        },
                        icon: const Icon(Icons.more_vert),
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 15),
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(niveau, style: const TextStyle(color: Colors.white),),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Icon(Icons.date_range),
                  const SizedBox(width: 10),
                  Text(dateTime)
                ],
              )

            ],
          ),
        ),
     // ),
    );
  }
}
