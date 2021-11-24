import 'package:flutter/material.dart';
import 'package:new_app/controllers/databaseHelper.dart';
import 'package:new_app/models/Product.dart';
import 'package:new_app/view/screens/listUserProductsPage.dart';
import 'package:new_app/view/screens/productCRUDpages/editProductPage.dart';
import 'package:new_app/view/widgets/productpageWidgets/productDetailsContainer.dart';


class UserProductListItem extends StatefulWidget {
  final Product product;

  UserProductListItem(this.product);

  @override
  _UserProductListItemState createState() => _UserProductListItemState();
}

class _UserProductListItemState extends State<UserProductListItem> {
  Color darkGreen = Color(0xFF005642);
  Color lightPink = Color(0xFFFFB0BB);

  DatabaseHelper databaseHelper = new DatabaseHelper();

  String cutRomaniaFromAddress(String address) {
    int untilIndex = address.indexOf(', Romania');
    return address.substring(0, untilIndex);
  }

  //delete function
  void confirm() {
    AlertDialog alertDialog = new AlertDialog(
      content: new Text(
          "Are you sure you want to delete '${widget.product.name}'?"),
      actions: <Widget>[
        new RaisedButton(
          onPressed: () {
            databaseHelper.removeProduct(widget.product.id);
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

    return new Row(
      children: <Widget>[
        Container(
          padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 1.0),
          width: 250,
          height: 120,
          //color: Colors.blue,
          child: ProductDetailsContainer(
            widget.product.name,
            cutRomaniaFromAddress(
                widget.product.address.name),
            widget.product.category,
          ),
        ),
        Container(
          width: 130,
          height: 130,
          child: ClipRRect(
              borderRadius: new BorderRadius.circular(5.0),
              child: widget.product.fileName != ""
                  ? 
                  // Image.memory(
                  //     base64Decode(base64Encode(
                  //         widget.product['image']['data']['data'].cast<int>())),
                  //   )
                 Image.memory(
                                    widget.product.productImage.base64Image,
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
              child: IconButton(
                icon: Icon(
                  Icons.edit,
                ),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => EditProductPage(
                            product: widget.product,
                          )));
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 10.0, 8.0, 10.0),
              child: IconButton(
                  icon: Icon(
                    Icons.delete,
                  ),
                  highlightColor: Colors.red,
                  onPressed: () => confirm()),
            ),
          ],
        )),
      ],
    );
  }
}
