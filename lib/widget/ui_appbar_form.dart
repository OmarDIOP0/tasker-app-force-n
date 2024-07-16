import 'package:flutter/material.dart';
import 'package:tasker/constantes/colors.dart';
import 'package:tasker/widget/application_name.dart';
import 'package:tasker/widget/custom_appbar_clipper.dart';
class UIAppbarForm extends StatelessWidget implements PreferredSizeWidget{
  const UIAppbarForm({Key? key, required this.text}) : super(key: key);
  final String text;
 @override
 Size get preferredSize => const Size.fromHeight(400);

  @override
  Widget build(BuildContext context) {
    return ClipPath(
          clipper: CustomAppBarClipper(),
          child: SafeArea(
            child: AppBar(
              centerTitle: true,
              backgroundColor: lightgreenColor,
              flexibleSpace:Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 10),
                  Text(text,style: const TextStyle(color: Colors.white,fontSize: 15),),
                  const SizedBox(height: 30),
                  const ApplicationName(),
                ],
              ),
            ),
          )
    );
  }
}
