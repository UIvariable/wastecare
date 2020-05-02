import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../controllers/databaseHelper.dart';
import '../view/listProductsPage.dart';
import '../widgets/customTextRow.dart';
import 'editProductPage.dart';

class ViewProductDetailsPage extends StatefulWidget {
  final List list;
  final int index;

  ViewProductDetailsPage({this.index, this.list});

  @override
  _ViewProductDetailsPageState createState() => _ViewProductDetailsPageState();
}

class _ViewProductDetailsPageState extends State<ViewProductDetailsPage> {

  Color darkGreen = Color(0xFF005642);
  Color lightPink = Color(0xFFFFB0BB);
  DatabaseHelper databaseHelper = new DatabaseHelper();
  List<Marker> _markers = [];
  MapType type;

  @override
  void initState() {
    super.initState();
    type = MapType.hybrid;
    _markers.add(Marker(markerId: MarkerId("addressMarker"),
    draggable: false,
    position: LatLng(widget.list[widget.index]['pickupAddress']['coordinates'][0],
    widget.list[widget.index]['pickupAddress']['coordinates'][1])
    ));
  }
  @override
  Widget build(BuildContext context) {

  Color lightPink = Color(0xFFFFB0BB);

    return new Scaffold(
      body: Container(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 20.0),
            child: Column(
              children: <Widget>[
                fieldsSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool exists(var image) {
    if (image == null) return false;
    return true;
  }

  //delete function
  void confirm() {
    AlertDialog alertDialog = new AlertDialog(
      content:
          new Text("delete '${widget.list[widget.index]['productName']}' "),
      actions: <Widget>[
        new RaisedButton(
          onPressed: () {
            databaseHelper
                .removeProduct(widget.list[widget.index]['_id'].toString());
            Navigator.of(context).push(new MaterialPageRoute(
              builder: (BuildContext context) => new ListProductsPage(),
            ));
          },
          child: new Text(
            "OK remove!",
            style: new TextStyle(color: Colors.black),
          ),
          color: Colors.red,
        ),
        new RaisedButton(
          child: new Text("Cancel", style: new TextStyle(color: Colors.black)),
          color: Colors.green,
          onPressed: () => Navigator.pop(context),
        )
      ],
    );

    showDialog(context: context, child: alertDialog);
  }

  Container fieldsSection() {
    return Container(
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
                color: Color(0xFFFFB0BB),
                blurRadius: 20.0,
                offset: Offset(0, 5)),
          ]),
      child: Column(
        children: <Widget>[
          exists(widget.list[widget.index]['image'])
              ? Image.memory(
                  base64Decode(base64Encode(widget.list[widget.index]['image']
                          ['data']['data']
                      .cast<int>())),
                )
              : Image(
                  fit: BoxFit.cover,
                  alignment: Alignment.topRight,
                  height: MediaQuery.of(context).size.width - 256,
                  width: MediaQuery.of(context).size.width - 256,
                  image:
                      AssetImage("assets/images/noimage/noimageavailable.png")
                  //NetworkImage("https://images.unsplash.com/photo-1495147466023-ac5c588e2e94?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80"),
                  ),

          CustomTextRow(80, 'Title', widget.list[widget.index]['productName'], Icons.title),
          Divider(
            height: 1.0,
            color: Colors.black,
          ),
          CustomTextRow(80, 'Description',
              widget.list[widget.index]['productDescription'], Icons.title),
          Divider(
            height: 1.0,
            color: Colors.black,
          ),
          CustomTextRow(
              80, 'Condition', widget.list[widget.index]['productCondition'], Icons.star_half),
          Divider(
            height: 1.0,
            color: Colors.black,
          ),
          CustomTextRow(80, 'Pick-up address',
              widget.list[widget.index]['pickupAddress']['name'], Icons.room),
          Divider(
            height: 1.0,
            color: Colors.black,
          ),
          CustomTextRow(80, 'Contact phone',
              widget.list[widget.index]['contactPhoneNumber'], Icons.phone),
          Divider(
            height: 1.0,
            color: Colors.black,
          ),
          CustomTextRow(
              80, 'Contact email', widget.list[widget.index]['contactEmail'], Icons.email),
        
          Container(
            height: 200,
            child:GoogleMap(
              mapType: type,
              initialCameraPosition: CameraPosition(
              zoom: 16.0,
              target: 
            //LatLng(widget.list[widget.index]['pickupAddress']['pickupAddressCoords'][0]),
            LatLng(widget.list[widget.index]['pickupAddress']['coordinates'][0],
    widget.list[widget.index]['pickupAddress']['coordinates'][1])
            ),
            markers: Set.from(_markers),
            ),
          ),

        new Row(
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      new RaisedButton(
        child: new Text("Edit"),
        color: darkGreen,
        onPressed: () => Navigator.of(context).push(
            new MaterialPageRoute(
                builder: (BuildContext context) =>
                    new EditProductPage(
                        list: widget.list,
                        index: widget.index))),
      ),
      VerticalDivider(),
      new RaisedButton(
          child: new Text("Delete"),
          color: lightPink,
          onPressed: () => confirm()),
    ]),
        
        ],
      ),
    );
  }
}

