import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductDetailsContainer extends StatelessWidget {
  final String listItemName;
  final String listItemAddress;

  ProductDetailsContainer(this.listItemName, this.listItemAddress);

  @override
  Widget build(BuildContext context) {
    Color lightPink = Color(0xFFFFB0BB);

    return Container(
      padding: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
      child: Column(
        //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Text(
              listItemName,
              style: GoogleFonts.roboto(
                textStyle: Theme.of(context).textTheme.headline1,
                fontSize: 22,
                fontWeight: FontWeight.w900,
                fontStyle: FontStyle.normal,
                color: lightPink,
              ),
            ),
          ),


           Expanded(
                child: Row(
                //crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Icon(IconData(0xe90d, fontFamily: 'materials'), color: Color(0xFFFFB0BB), size: 30,),
                  Expanded(
                    child:Text(
                    "category here",
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 18.0,
                    ),
                  ),
                  ),
                ],
                ),
           ),

          SizedBox(
            height: 10.0,
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
                    child:Text(
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
