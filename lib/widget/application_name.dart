import 'package:flutter/material.dart';

import '../constantes/colors.dart';
class ApplicationName extends StatelessWidget {

  const ApplicationName({Key? key,required this.size}) : super(key: key);
  final double size;
  @override
  Widget build(BuildContext context) {
    return const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(width: 10,),
          Text('Tasker',style:TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: deepgreenColor,)),
        ]
    );
  }
}
