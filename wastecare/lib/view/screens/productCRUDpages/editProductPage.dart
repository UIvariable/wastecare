import 'dart:convert';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_app/animations/fadeAnimation.dart';
import 'package:new_app/controllers/databaseHelper.dart';
import 'package:new_app/models/Place.dart';
import 'package:new_app/models/Product.dart';
import 'package:new_app/view/screens/listUserProductsPage.dart';
import 'package:new_app/view/screens/productCRUDpages/locationSearchPage.dart';
import 'package:new_app/view/widgets/productpageWidgets/customTextFormField.dart';


class EditProductPage extends StatefulWidget {
  final Product product;

  EditProductPage({this.product});

  @override
  _EditProductPageState createState() => _EditProductPageState();
}

class _EditProductPageState extends State<EditProductPage> {
  DatabaseHelper databaseHelper = new DatabaseHelper();

  final _formKey = GlobalKey<FormState>();

  TextEditingController _nameController;
  TextEditingController _addressController;
  TextEditingController _detailsController;
  TextEditingController _idController;
  TextEditingController _contactPhoneController;
  TextEditingController _contactEmailController;

  double imageTop = 100;
  double imageWidth = 140;
  double arrowImageWidth = 30;
  Color darkGreen = Color(0xFF005642);
  Color lightPink = Color(0xFFFFB0BB);

  File _image;
  Place address;

  String conditionValue;
  String categoryValue;
  List<String> conditionValues = new List<String>();
  List<String> categoryValues = new List<String>();

  @override
  void initState() {
    super.initState();
    address = widget.product.address;

    _idController = new TextEditingController(
        text: widget.product.id);
    _addressController = new TextEditingController(
        text: widget.product.address.name);
    _nameController = new TextEditingController(
        text: widget.product.name);
    _detailsController = new TextEditingController(
        text: widget.product.details);
    _contactPhoneController = new TextEditingController(
        text: widget.product.contactPhone);
    _contactEmailController = new TextEditingController(
        text: widget.product.contactEmail);

    conditionValues.addAll([
      "Choose condition",
      "new and functional",
      "new but has a defect",
      "used but functional",
      "needs to be fixed",
      "components functional",
      "other"
    ]);
    conditionValue = widget.product.condition;

    categoryValues.addAll([
      "Choose category",
      "electronics",
      "clothes",
      "glasses",
      "furniture",
      "hobby",
      "food",
      "other"
    ]); 
    categoryValue = widget.product.category;
  }

  void _onChangedConditionValue(String value) {
    setState(() {
      FocusScope.of(context).requestFocus(new FocusNode());
      conditionValue = value;
    });
  }

  void _onChangedCategoryValue(String value) {
    setState(() {
      FocusScope.of(context).requestFocus(new FocusNode());
      categoryValue = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle.light.copyWith(statusBarColor: Colors.white));
    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          child: Form(
            child: Padding(
              padding: EdgeInsets.all(30.0),
              key: _formKey,
              child: Column(
                children: <Widget>[
                  FadeAnimation(1, titleSection()),
                  FadeAnimation(1.1, fieldsSection()),
                  FadeAnimation(1.2, buttonSection()),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Container titleSection() {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 30.0, 0, 30.0),
      child: Text(
        "EDIT ITEM",
        textAlign: TextAlign.center,
        style: GoogleFonts.roboto(
          textStyle: Theme.of(context).textTheme.display1,
          fontSize: 25,
          fontWeight: FontWeight.w900,
          fontStyle: FontStyle.normal,
          color: Colors.grey.shade500,
        ),
      ),
    );
  }

  Container fieldsSection() {
    return Container(
        padding: EdgeInsets.all(10),
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
          //padding: const EdgeInsets.all(10.0),
          children: <Widget>[
            CustomTextFormField(TextInputType.text, 30, _nameController,
                "Title", true, Icons.title),
            CustomTextFormField(TextInputType.multiline, 90, _detailsController,
                "Details", false, Icons.text_fields),
            Row(
              children: <Widget>[
                Icon(
                  Icons.category,
                  color: Colors.grey.shade600,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                  child: DropdownButton(
                    focusColor: darkGreen,
                    value: categoryValue,
                    items: categoryValues.map((String value) {
                      return new DropdownMenuItem(
                          value: value,
                          child: Text(
                            '$value',
                            style: new TextStyle(
                              color: Colors.grey.shade600,
                            ),
                          ));
                    }).toList(),
                    onChanged: (String value) {
                      _onChangedCategoryValue(value);
                    },
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Icon(
                  Icons.star_half,
                  color: Colors.grey.shade600,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                  child: DropdownButton(
                    focusColor: darkGreen,
                    value: conditionValue,
                    items: conditionValues.map((String value) {
                      return new DropdownMenuItem(
                          value: value,
                          child: Text(
                            '$value',
                            style: new TextStyle(
                              color: Colors.grey.shade600,
                            ),
                          ));
                    }).toList(),
                    onChanged: (String value) {
                      _onChangedConditionValue(value);
                    },
                  ),
                ),
              ],
            ),
            CustomTextFormField(TextInputType.phone, 10,
                _contactPhoneController, "Contact Phone", true, Icons.phone),
            CustomTextFormField(TextInputType.emailAddress, 40,
                _contactEmailController, "Contact Email", false, Icons.email),
            TextFormField(
              onTap: () {
                _awaitReturnValueFromLocationScreen(context);
              },
              controller: _addressController,
              decoration: InputDecoration(
                hintText: "Pick-up Location",
                hintStyle: TextStyle(
                  color: Colors.grey.shade600,
                ),
                border: InputBorder.none,
                icon: Icon(Icons.room),
                counterText: "",
              ),
              style: TextStyle(
                color: Colors.grey.shade600,
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return "field cannot be empty";
                }
                return "ok";
              },
            ),
            widget.product.fileName != ""
                ? 
                // Image.memory(
                //     base64Decode(base64Encode(
                //       widget.product['image']
                //             ['data']['data']
                //         .cast<int>())),
                //   )
                Image(
                      fit: BoxFit.cover,
                      alignment: Alignment.topRight,
                      image: AssetImage(
                          "assets/images/reuse/re.png")
                     )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Icon(
                        Icons.image,
                        color: Colors.grey.shade600,
                      ),
                      SizedBox(width: 20.0),
                      RaisedButton(
                        onPressed: _choose,
                        child: Text('Choose Image'),
                      ),
                      SizedBox(width: 10.0),
                    ],
                  ),
            _image == null && widget.product.fileName != ""
                ? Padding(
                    padding: EdgeInsets.only(left: 48.0),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text('No Image Selected',
                            style: TextStyle(
                              color: Colors.grey.shade600,
                            ))))
                : Text(" "),
            _image != null && widget.product.fileName != ""
                ? Image.file(_image)
                : Text(" "),
          ],
        ));
  }

  Container buttonSection() {
    return Container(
      width: MediaQuery.of(context).size.width / 2,
      padding: EdgeInsets.fromLTRB(0, 30.0, 0, 30.0),
      child: RaisedButton(
        onPressed: () {
          databaseHelper.editDataProducts(
              _idController.text,
              _nameController.text.trim(),
              _detailsController.text.trim(),
              categoryValue,
              conditionValue,
              _contactPhoneController.text.trim(),
              _contactEmailController.text.trim(),
              _image == null ? "" : _image.path.split("/").last,
              _image == null ? "" : base64Encode(_image.readAsBytesSync()),
              address);
          Navigator.of(context).
          pushReplacement(new MaterialPageRoute(
            builder: (BuildContext context) => new ListUserProductsPage(),
          ));
        },
        //elevation: 0.0,
        color: darkGreen,
        child: Container(
          child: Text(
            "SAVE",
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
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2.0)),
      ),
    );
  }

  void _choose() async {
    File image;
    //if (isCamera) {
    //image = await ImagePicker.pickImage(source: ImageSource.camera);
    // }
    // else {
    image = await ImagePicker.pickImage(source: ImageSource.gallery);
    //}

    setState(() {
      _image = image;
    });
  }

  void _awaitReturnValueFromLocationScreen(BuildContext context) async {
    // start the SecondScreen and wait for it to finish with a result
    final resultPlace = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LocationSearch(),
        ));

    // after the SecondScreen result comes back update the Text widget with it
    setState(() {
      if (resultPlace != null) {
        address = resultPlace;
        _addressController.text = address.name;
      }
    });
  }
}
