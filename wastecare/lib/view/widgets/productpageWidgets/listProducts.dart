import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:new_app/view/screens/productCRUDpages/viewProductDetailsPage.dart';
import 'package:new_app/view/widgets/productpageWidgets/productDetailsContainer.dart';

class ProductList extends StatelessWidget {
  final List list;

  ProductList({this.list});

  String cutRomaniaFromAddress(String address) {
    int untilIndex = address.indexOf(', Romania');
    return address.substring(0, untilIndex);
  }

  @override
  Widget build(BuildContext context) {

    return new ListView.builder(
        itemCount: list == null ? 0 : list.length,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, i) {
          return Padding(
            padding: const EdgeInsets.all(12.0),
            child: FittedBox(
              // child: Container(
              // width: MediaQuery.of(context).size.width,
              // padding: EdgeInsets.only(top: 20, bottom: 20, left: 30, right: 30),
              // color: Colors.red,

              // child: Material(
              //   color: Colors.orange,
              //   elevation: 12.0,
              //   borderRadius: BorderRadius.circular(5),
              //   shadowColor: Colors.grey.shade600,
              child: new GestureDetector(
                onTap: () => Navigator.of(context).push(
                  new MaterialPageRoute(
                    builder: (BuildContext context) =>
                        new ViewProductDetailsPage(list[i]),
                  ),
                ),
                child: new Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.shade600,
                            blurRadius: 20.0,
                            offset: Offset(0, 10)),
                      ]),
                  child: new Row(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 1.0),
                        width: 250,
                        height: 140,
                        child: ProductDetailsContainer(
                            //list[i]['productName'].toString(),
                            list[i].name,
                            cutRomaniaFromAddress(
                                //list[i]['pickupAddress']['name'].toString()),
                                list[i].address.name,
                                ),
                            //list[i]['productCategory'].toString()),
                            list[i].category),
                      ),
                      Container(
                        width: 130,
                        height: 130,
                        child: ClipRRect(
                            borderRadius: new BorderRadius.circular(5.0),
                            child: 
                              //exists(list[i]['image'])
                             list[i].productImage != null
                                ? 
                                Image.memory(
                                    list[i].productImage.base64Image,
                                  )
                                : 
                                Image(
                                    fit: BoxFit.cover,
                                    alignment: Alignment.topRight,
                                    image: AssetImage(
                                        "assets/images/noimage/noimageavailable.png")
                                    )),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            //),
          );
        });
  }
}
