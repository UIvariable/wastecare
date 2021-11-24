import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_app/view/screens/loginpages/loginPage.dart';

class IconCard extends StatelessWidget {
  final IconData iconData;
  final String text;
  final Widget widget;

  IconCard(this.iconData, this.text, this.widget);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 138,
      //color: Colors.red,
      // child: Padding(
      //   padding: EdgeInsets.only(top:10.0),
      child: Column(
        children: <Widget>[
          Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
                color: Color(0xFFFFB0BB),
                borderRadius: BorderRadius.circular(10)),
            child: IconButton(
                icon: Icon(
                  iconData,
                  size: 60,
                  color: Colors.black,
                ),
                onPressed: () {
                  Navigator.of(context).push(new MaterialPageRoute(
                      builder: text == "Donations" || text == "My Donations"
                          ? (BuildContext context) => widget
                          : (BuildContext context) => LoginPage()));
                }),
          ),
          Text(
            text,
            style: GoogleFonts.roboto(
              textStyle: Theme.of(context).textTheme.display1,
              fontSize: 15,
              fontWeight: FontWeight.w900,
              fontStyle: FontStyle.normal,
              color: Colors.grey.shade900,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
      //),
    );
  }
}
