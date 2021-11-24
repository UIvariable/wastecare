import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductDetailsContainer extends StatelessWidget {
  final String listItemName;
  final String listItemAddress;
  final String listItemCategory;

  ProductDetailsContainer(
      this.listItemName, this.listItemAddress, this.listItemCategory);

  @override
  Widget build(BuildContext context) {
    Color lightPink = Color(0xFFFFB0BB);

    IconData iconData(String categoryName) {
      switch (categoryName) {
        case 'clothes':
          return IconData(0xe907, fontFamily: 'materials');
        case 'electronics':
          return IconData(0xe905, fontFamily: 'materials');
        case 'glasses':
          return IconData(0xe902, fontFamily: 'materials');
        case 'furniture':
          return IconData(0x1f5fa, fontFamily: 'materials');
        case 'hobby':
          return IconData(0xe903, fontFamily: 'materials');
        case 'food':
          return IconData(0xe90a, fontFamily: 'materials');
        case 'other':
          return IconData(0xe906, fontFamily: 'materials');
      }
      return null;
    }

    return Container(
      padding: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Text(
              listItemName,
              style: GoogleFonts.roboto(
                textStyle: Theme.of(context).textTheme.display1,
                fontSize: 22,
                fontWeight: FontWeight.w900,
                fontStyle: FontStyle.normal,
                color: lightPink,
              ),
            ),
          ),

          Expanded(
            child: Row(
              children: [
                Icon(
                  iconData(listItemCategory),
                  color: Color(0xFFFFB0BB),
                  size: 30,
                ),
                Expanded(
                  child: Text(
                    listItemCategory,
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 18.0,
                    ),
                  ),
                ),
              ],
            ),
          ),

          //Container(
          //color: Colors.yellow,
          //child: Align(
          //alignment: FractionalOffset.bottomRight,
          //child:
          Expanded(
            child: Row(
              //crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Icon(Icons.room, color: Color(0xFFFFB0BB)),
                Expanded(
                  child: Text(
                    listItemAddress,
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 15.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // ),
          // ),
        ],
      ),
    );
  }
}
