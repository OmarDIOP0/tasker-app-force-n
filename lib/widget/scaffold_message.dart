import 'package:flutter/material.dart';
import 'package:tasker/constantes/colors.dart';

void showSnackBar(BuildContext context,String message,{Color backgroundColor = lightgreenColor,
  Duration duration = const Duration(seconds: 2)})
{
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(message),
       backgroundColor: backgroundColor,
      duration: duration,
    )
  );
}