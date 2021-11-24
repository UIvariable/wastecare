import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_app/animations/fadeAnimation.dart';
import 'package:new_app/view/screens/loginpages/loginPage.dart';

class LoginButton extends StatelessWidget {
  final Color buttonColor;
  final String buttonText;
  final double animationDelay;

  LoginButton(this.buttonColor, this.buttonText, this.animationDelay);

  @override
  Widget build(BuildContext context) {
  return Container(
      width: MediaQuery.of(context).size.width,
      height: 50.0,
      padding: EdgeInsets.symmetric(horizontal: 30.0),
      child: FadeAnimation(
        animationDelay,
        RaisedButton(
          onPressed: (){
             Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => LoginPage()));
          },
          color: buttonColor,
          child: Container(
            child: Text(
              buttonText,
              textAlign: TextAlign.left,
              style: GoogleFonts.roboto(
                textStyle: Theme.of(context).textTheme.display1,
                fontSize: 20,
                fontWeight: FontWeight.w900,
                fontStyle: FontStyle.normal,
                color: Colors.white,
              ),
            ),
          ),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(2.0)),
        ),
      ),
    );
  }
}