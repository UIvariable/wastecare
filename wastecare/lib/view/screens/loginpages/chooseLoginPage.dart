import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:new_app/animations/fadeAnimation.dart';
import 'package:new_app/view/widgets/loginpageWidgets/loginButton.dart';
import 'package:new_app/view/widgets/loginpageWidgets/loginPageImagePart.dart';

class ChooseLoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    double width = size.width;
    double imageTop = 440;
    double imageWidth = 120;
    double reTextImageWidth = 55;
    double useTextImageWidth = 85;
    double reuseTextImageTop = 220;
    Color lightPink = Color(0xFFFFB0BB);

    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle.light.copyWith(statusBarColor: Colors.white));
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child:  Column(
            children: <Widget>[
              FadeAnimation(
                1,
                Container(
                  height: 400,
                  color: Colors.white,
                  child: Stack(
                    children: <Widget>[
                      ImagePart(imageWidth, imageTop, (width - imageWidth) / 2,
                          1, 'assets/images/reuse/reuse.png'),
                      ImagePart(
                          useTextImageWidth, reuseTextImageTop,
                          useTextImageWidth * 2.0,
                          1.3,
                          'assets/images/reuse/use.png'),
                      ImagePart(reTextImageWidth, reuseTextImageTop, reTextImageWidth * 2,
                          1.3, 'assets/images/reuse/re.png'),
                    ],
                  ),
                ),
              ),
            SizedBox(height: 60.0,),
            LoginButton(lightPink, "LOGIN AS USER", 1.8),
            SizedBox(height: 30.0,),
            LoginButton(lightPink, "LOGIN AS ORGANIZATION", 1.8),
                        
            ],
          ),
        ),
    );
  }
}