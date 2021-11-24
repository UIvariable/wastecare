import 'package:flutter/material.dart';
import 'package:new_app/animations/fadeAnimation.dart';

class ImagePart extends StatelessWidget {
  final double imageWidth;
  final double imageTop;
  final double imageLeft;
  final double animationDelay;
  final String imageURL;
 
  ImagePart(this.imageWidth, this.imageTop, this.imageLeft, this.animationDelay,
      this.imageURL);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      width: imageWidth,
      height: imageTop,
      left: imageLeft,
      child: FadeAnimation(
        animationDelay,
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage(imageURL)),
          ),
        ),
      ),
    );
  }
}
