import 'dart:convert';
import 'package:flutter/material.dart';
import '../controllers/databaseHelper.dart';
import '../view/editProductPage.dart';
import '../view/listUserProductsPage.dart';
import '../widgets/productDetailsContainer.dart';

class UserProductListItem extends StatefulWidget {

  final int index;
  final List list;
  UserProductListItem(this.list, this.index);

  @override
  _UserProductListItemState createState() => _UserProductListItemState();
}

class _UserProductListItemState extends State<UserProductListItem> {

      Color darkGreen = Color(0xFF005642);
  Color lightPink = Color(0xFFFFB0BB);

      DatabaseHelper databaseHelper = new DatabaseHelper();

    String cutRomaniaFromAddress(String address) {
    int untilIndex = address.indexOf(', Romania');
    return address.substring(0,untilIndex);
  }



    bool exists(var image) {
      if (image == null) return false;
      return true;
    }

     //delete function
  void confirm(int index) {
    AlertDialog alertDialog = new AlertDialog(
      content:
          new Text("Are you sure you want to delete '${widget.list[index]['productName']}'?"),
      
      actions: <Widget>[
        new RaisedButton(
          onPressed: () {
            databaseHelper
                .removeProduct(widget.list[index]['_id'].toString());
            Navigator.of(context).push(new MaterialPageRoute(
              builder: (BuildContext context) => new ListUserProductsPage(),
            ));
          },
          child: new Text(
            "Confirm",
            style: new TextStyle(color: Colors.black),
          ),
          color: darkGreen,
        ),
        new RaisedButton(
          child: new Text("Cancel", style: new TextStyle(color: Colors.black)),
          color: lightPink,
          onPressed: () => Navigator.pop(context),
        )
      ],
    );

    showDialog(context: context, child: alertDialog);
  }

  @override
  Widget build(BuildContext context) {

    int i = widget.index;
      return new Row(
        children: <Widget>[
          
         
          Container(
            padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 1.0),
            width: 250,
            height: 120,
            //color: Colors.blue,
            child: ProductDetailsContainer(
                widget.list[i]['productName'].toString(),
                cutRomaniaFromAddress(widget.list[i]['pickupAddress']['name'].toString())),
          ),
          Container(
            width: 130,
            height: 130,
            child: ClipRRect(
                borderRadius: new BorderRadius.circular(5.0),
                child: exists(widget.list[i]['image'])
                    ? Image.memory(
                        base64Decode(base64Encode(widget.list[i]['image']
                                ['data']['data']
                            .cast<int>())),
                      )
                    : Image(
                        fit: BoxFit.cover,
                        alignment: Alignment.topRight,
                        image: AssetImage(
                            "assets/images/noimage/noimageavailable.png")
                        //NetworkImage("https://images.unsplash.com/photo-1495147466023-ac5c588e2e94?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80"),
                        )),
          ),
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 10.0, 8.0, 10.0),
                child: IconButton(icon: Icon(Icons.edit,),
                onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (BuildContext context) => EditProductPage(list: widget.list, index: i,)));
                },),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 10.0, 8.0, 10.0),
                child: IconButton(
                  icon: Icon(Icons.delete,),
                  highlightColor: Colors.red,
                onPressed: () => confirm(i)
                ),
              ),
            ],)
          ),
        ],
      );
  }
   

}