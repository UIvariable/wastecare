import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';

class ImageCarousel extends StatelessWidget {
  final String imageURL1;
  final String imageURL2;
  final String imageURL3;

  ImageCarousel(this.imageURL1, this.imageURL2, this.imageURL3);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.0,
      child: new Carousel(
        boxFit: BoxFit.cover,
        images: [
          AssetImage(imageURL1),
          AssetImage(imageURL2),
          AssetImage(imageURL3),
        ],
        autoplay: true,
        animationDuration: Duration(milliseconds: 1500),
        dotSize: 4.0,
        dotBgColor: Colors.transparent,
        indicatorBgPadding: 4.0,
      ),
    );
  }
}
