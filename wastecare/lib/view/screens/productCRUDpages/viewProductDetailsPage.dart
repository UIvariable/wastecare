import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:new_app/controllers/databaseHelper.dart';
import 'package:new_app/models/Product.dart';
import 'package:new_app/view/screens/productCRUDpages/editProductPage.dart';
import 'package:new_app/view/screens/productCRUDpages/listProductsPage.dart';
import 'package:new_app/view/widgets/productpageWidgets/bigImage.dart';
import 'package:new_app/view/widgets/productpageWidgets/customTextRow.dart';

class ViewProductDetailsPage extends StatefulWidget {
  final Product product;

  ViewProductDetailsPage(this.product);

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
    _markers.add(Marker(
        markerId: MarkerId("addressMarker"),
        draggable: false,
        position: LatLng(
            // widget.list[widget.index]['pickupAddress']['coordinates'][0],
            // widget.list[widget.index]['pickupAddress']['coordinates'][1]
            widget.product.address.latlng[0],
            widget.product.address.latlng[1],
            )));
  }

  @override
  Widget build(BuildContext context) {
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

  //delete function
  void confirm() {
    AlertDialog alertDialog = new AlertDialog(
      content:
          new Text("delete '${widget.product.name}' "),
      actions: <Widget>[
        new RaisedButton(
          onPressed: () {
            databaseHelper
                // .removeProduct(widget.list[widget.index]['_id'].toString());
                .removeProduct(widget.product.id);
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
    double customTextRowHeight = 70; 
    Image image = Image.memory(
      base64Decode(base64Encode(widget.product.productImage.base64Image)), fit: BoxFit.cover, 
    );

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
          widget.product.productImage != null
              ? 
              GestureDetector(
                 onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) {
                  return BigImage(Image.memory(
                      widget.product.productImage.base64Image, fit: BoxFit.cover, 
                    ),);
                }));},
                child: Container(
                  decoration: new BoxDecoration(border: Border.all(color: Colors.grey)),
                  height: 150,
                  width: 150,
                  child: Image.memory(
                      widget.product.productImage.base64Image, fit: BoxFit.cover, 
                    ),
                ),
              )
              : Text(""),
          CustomTextRow(customTextRowHeight, 'Title', widget.product.name,
              Icons.title),
          Divider(
            height: 1.0,
            color: Colors.black,
          ),
          CustomTextRow(customTextRowHeight, 'Description',
              widget.product.details, Icons.title),
          Divider(
            height: 1.0,
            color: Colors.black,
          ),
          CustomTextRow(customTextRowHeight, 'Category',
              widget.product.category, Icons.category),
          Divider(
            height: 1.0,
            color: Colors.black,
          ),
          CustomTextRow(customTextRowHeight, 'Condition',
              widget.product.condition, Icons.star_half),
          Divider(
            height: 1.0,
            color: Colors.black,
          ),
          CustomTextRow(customTextRowHeight, 'Contact phone',
              widget.product.contactPhone, Icons.phone),
          Divider(
            height: 1.0,
            color: Colors.black,
          ),
          CustomTextRow(customTextRowHeight, 'Contact email',
              widget.product.contactEmail, Icons.email),
              Divider(
            height: 1.0,
            color: Colors.black,
          ),
          CustomTextRow(customTextRowHeight, 'Pick-up address',
              widget.product.address.name, Icons.room),
          GestureDetector(
          onVerticalDragUpdate: (_){},
          child: Container(
              height: 300,
              child: GoogleMap(
                mapType: type,
                initialCameraPosition: CameraPosition(
                    zoom: 16.0,
                    target:
                        //LatLng(widget.list[widget.index]['pickupAddress']['pickupAddressCoords'][0]),
                        LatLng(
                            widget.product.address.latlng[0],
                            widget.product.address.latlng[1])
                            ),
                gestureRecognizers: Set()
                  ..add(
                      Factory<PanGestureRecognizer>(() => PanGestureRecognizer()))
                  ..add(
                    Factory<VerticalDragGestureRecognizer>(
                        () => VerticalDragGestureRecognizer()),
                  )
                  ..add(
                    Factory<HorizontalDragGestureRecognizer>(
                        () => HorizontalDragGestureRecognizer()),
                  )
                  ..add(
                    Factory<ScaleGestureRecognizer>(
                        () => ScaleGestureRecognizer()),
                  ),
                markers: Set.from(_markers),
              ),
            ),
          ),
          new Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
            new RaisedButton(
              child: new Text("Edit"),
              color: darkGreen,
              onPressed: () => Navigator.of(context).push(new MaterialPageRoute(
                  builder: (BuildContext context) => new EditProductPage(
                      product: widget.product))),
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
