import 'package:flutter/material.dart';

class UICustomProfilePassword extends StatefulWidget {
  final String password;
  const UICustomProfilePassword({Key? key, required this.password, required Function(dynamic value) onSaved}) : super(key: key);

  @override
  State<UICustomProfilePassword> createState() => _UICustomProfilePasswordState();
}

class _UICustomProfilePasswordState extends State<UICustomProfilePassword> {
  bool _obscureText=true;
  void _togglePasswordVisibility(){
    setState(() {
      _obscureText=!_obscureText;
    });
}

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:const EdgeInsets.only(left: 20,right: 20),
      child: TextFormField(
          initialValue: widget.password,
          obscureText: _obscureText,
          decoration: InputDecoration(
              prefixIcon: const Icon(Icons.lock),
              hintText: "password",
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10)
              ),
              suffixIcon:IconButton(
                  onPressed: _togglePasswordVisibility,
                  icon: Icon(_obscureText? Icons.visibility:Icons.visibility_off)
              )
          ),
      ),
    );
  }
}
