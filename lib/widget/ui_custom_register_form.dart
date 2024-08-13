import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UICustumRegisterForm extends StatelessWidget {
  const UICustumRegisterForm(this.controller, this.nameField, this.comment, this.icon, {Key? key}) : super(key: key);
  final TextEditingController controller;
  final String nameField;
  final String comment;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:const EdgeInsets.only(left: 20,right: 20),
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
