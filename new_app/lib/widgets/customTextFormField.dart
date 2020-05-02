import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final TextInputType keyboard;
  final int length;
  final TextEditingController controller;
  final String hintText;
  final bool isRequired;
  final IconData iconData;

  CustomTextFormField(this.keyboard, this.length, this.controller,
      this.hintText, this.isRequired, this.iconData);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboard,
      maxLines: length > 30 ? null : 1,
      maxLength: length,
      controller: controller,
      cursorColor: Colors.black,
      decoration: InputDecoration(
        hintText: hintText,
        labelText: hintText,
        hintStyle: TextStyle(
          color: Colors.grey.shade600,
        ),
        //border: InputBorder.none,
        icon: Icon(iconData),
        counterText: "",
      ),
      style: TextStyle(
        color: Colors.grey.shade600,
      ),
      validator: (value) {
        if (value.isEmpty && isRequired) {
          return "$hintText cannot be empty";
        }
        return "ok";
      },
    );
  }
}
