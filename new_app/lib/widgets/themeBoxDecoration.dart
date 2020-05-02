import 'package:flutter/material.dart';

class ThemeBoxDecoration extends StatelessWidget {
  
  Widget childWidget;

  ThemeBoxDecoration(this.childWidget);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.shade600,
                blurRadius: 20.0,
                offset: Offset(0, 10)),
          ],
          ),
          child: childWidget);
  }
}