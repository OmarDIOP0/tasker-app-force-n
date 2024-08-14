import 'package:flutter/material.dart';

class UICustumProfileForm extends StatelessWidget {
  final String value;
  final Icon icon;
  final String comment;
  final Function(String?) onSaved;

  const UICustumProfileForm({
    Key? key,
    required this.value,
    required this.comment,
    required this.icon,
    required this.onSaved,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              initialValue: value,
              decoration: InputDecoration(
                prefixIcon: icon,
                hintText: comment,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onSaved: onSaved,
            ),
          ),
        ],
      ),
    );
  }
}
