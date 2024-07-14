import 'package:flutter/material.dart';

import '../constantes/colors.dart';
class ApplicationName extends StatelessWidget {
  const ApplicationName({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 5),
            child: Icon(Icons.task_alt,size: 25,color:deepgreenColor),
          ),
          SizedBox(width: 10,),
          Text('Tasker',style:TextStyle(fontSize: 40,fontWeight: FontWeight.bold,color: deepgreenColor,)),
        ]
    );
  }
}
