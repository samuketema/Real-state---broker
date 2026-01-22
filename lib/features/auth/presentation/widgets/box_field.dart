import 'package:flutter/material.dart';

class BoxField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool isPassword;

  const BoxField({
    super.key,
    required this.hintText,
    required this.controller,
    this.isPassword = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
          if(value!.isEmpty){
            return "$hintText is missing";
          } 
        return null;
      },
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        hintText: hintText,
      ),
    );
  }
}