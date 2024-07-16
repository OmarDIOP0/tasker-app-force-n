import 'package:flutter/material.dart';

import '../constantes/colors.dart';
class ApplicationName extends StatelessWidget {

  const ApplicationName({Key? key,required this.size}) : super(key: key);
  final double size;
  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 5),
            child: Icon(Icons.task_alt,size: size ,color:deepgreenColor),
          ),
          const SizedBox(width: 10,),
          const Text('Tasker',style:TextStyle(fontSize: 40,fontWeight: FontWeight.bold,color: deepgreenColor,)),
        ]
    );
  }
}
