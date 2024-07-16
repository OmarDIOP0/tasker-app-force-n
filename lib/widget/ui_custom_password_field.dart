import "package:flutter/material.dart";
class UICustomPasswordField extends StatefulWidget {
  const UICustomPasswordField({Key? key, required this.controller, required this.nameField, required this.comment}) : super(key: key);

  final TextEditingController controller;
  final String nameField;
  final String comment;

  @override
  State<UICustomPasswordField> createState() => _UICustomPasswordFieldState();
}

class _UICustomPasswordFieldState extends State<UICustomPasswordField> {
bool _obscureText = true;
void _togglePasswordVisibility(){
  setState(() {
    _obscureText = !_obscureText;
  });
}

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:const EdgeInsets.only(left: 20,right: 20),
      child: TextFormField(
          controller: widget.controller,
          obscureText: _obscureText,
          decoration: InputDecoration(
              prefixIcon: const Icon(Icons.lock),
              labelText:widget.nameField,
              hintText: widget.comment,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10)
              ),
              suffixIcon:IconButton(
                  onPressed: _togglePasswordVisibility,
                  icon: Icon(_obscureText? Icons.visibility:Icons.visibility_off)
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
