import 'package:flutter/material.dart';

class UICustomForm extends StatelessWidget {
  const UICustomForm({Key? key, required this.controller,
                                required this.nameField,
                                required this.comment, required this.icon}) : super(key: key);
  final TextEditingController controller;
  final String nameField;
  final String comment;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding:const EdgeInsets.all(20),
      child: TextFormField(
          controller: controller,
          decoration: InputDecoration(
             prefixIcon: icon,
              labelText:nameField,
              hintText: comment,
              border:  OutlineInputBorder(
                borderRadius: BorderRadius.circular(10)
              )
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
