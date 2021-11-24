import 'package:flutter/material.dart';

class BigImage extends StatelessWidget {

  Image image;
  BigImage(this.image);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        child: Center(
          child: Hero(
            tag: 'imageHero',
            child: image
          ),
        ),
        onTap: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}