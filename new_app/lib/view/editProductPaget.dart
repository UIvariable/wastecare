import 'package:flutter/material.dart';
import '../controllers/databaseHelper.dart';

class EditProductPage extends StatefulWidget {
  final List list;
  final int index;

  EditProductPage({this.list, this.index});

  @override
  _EditProductPageState createState() => _EditProductPageState();
}

class _EditProductPageState extends State<EditProductPage> {
  DatabaseHelper databaseHelper = new DatabaseHelper();
  TextEditingController nameController;
  TextEditingController addressController;
  TextEditingController idController;
  TextEditingController conditionController;
  TextEditingController contactPhoneController;
  TextEditingController contactEmailController;

  @override
  void initState() {
    idController = new TextEditingController(
        text: widget.list[widget.index]['_id'].toString());
    addressController = new TextEditingController(
        text: widget.list[widget.index]['pickupAddress'].toString());
    nameController = new TextEditingController(
        text: widget.list[widget.index]['productName'].toString());
    conditionController = new TextEditingController(
        text: widget.list[widget.index]['productCondition'].toString());
    contactPhoneController = new TextEditingController(
        text: widget.list[widget.index]['contactPhoneCondition'].toString());
    contactEmailController = new TextEditingController(
        text: widget.list[widget.index]['contactEmailCondition'].toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("Edit product"),
        ),
        body: 
        Form(
            child: ListView(
          padding: const EdgeInsets.all(10.0),
          children: <Widget>[
            new Column(
              children: <Widget>[
                new ListTile(
                  leading: const Icon(Icons.person, color: Colors.black),
                  title: new TextFormField(
                    controller: idController,
                    validator: (value) {
                      if (value.isEmpty)
                        return "ID";
                      else
                        return "";
                    },
                    decoration:
                        new InputDecoration(hintText: "Id", labelText: "Id"),
                  ),
                ),
               
                const Divider(
                  height: 1.0,
                ),
                new Padding(padding: const EdgeInsets.all(10.0)),
                new RaisedButton(
                    child: new Text("Edit"),
                    color: Colors.blueAccent,
                    onPressed: () { }
                    //   databaseHelper.editDataProducts(
                    //       idController.text.trim(),
                    //       nameController.text.trim(),
                    //       addressController.text.trim(),
                    //       conditionController.text.trim());
                    //   Navigator.of(context).push(new MaterialPageRoute(
                    //       builder: (BuildContext context) =>
                    //           new ListProductsPage()));
                    // }
                    )
              ],
            )
          ],
        )));
  }
}
