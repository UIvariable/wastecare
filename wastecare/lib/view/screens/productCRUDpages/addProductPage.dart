import 'dart:io';
import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_app/controllers/databaseHelper.dart';
import 'package:new_app/animations/fadeAnimation.dart';
import 'package:new_app/models/Place.dart';
import 'package:new_app/view/screens/homePage.dart';
import 'package:new_app/view/widgets/productpageWidgets/customTextFormField.dart';
import 'package:new_app/view/widgets/loginpageWidgets/loginPageImagePart.dart';
import 'package:new_app/view/screens//productCRUDpages/locationSearchPage.dart';

//GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: PLACES_API_KEY);

class AddProductPage extends StatefulWidget {
  final String title;

  AddProductPage({Key key, this.title}) : super(key: key);

  @override
  _AddProductPageState createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  DatabaseHelper databaseHelper = new DatabaseHelper();

  final _formKey = GlobalKey<FormState>();

  TextEditingController _nameController;
  TextEditingController _addressController;
  TextEditingController _detailsController;
  TextEditingController _contactPhoneController;
  TextEditingController _contactEmailController;

  Color darkGreen = Color(0xFF005642);
  Color lightPink = Color(0xFFFFB0BB);

  double imageTop = 100;
  double imageWidth = 140;
  double arrowImageWidth = 30;

  File _image;
  Place address;

  String conditionValue;
  String categoryValue;
  List<String> conditionValues = new List<String>();
  List<String> categoryValues = new List<String>();

  @override
  void initState() {
    super.initState();

    _nameController = new TextEditingController();
    _addressController = new TextEditingController();
    _detailsController = new TextEditingController();
    _contactPhoneController = new TextEditingController();
    _contactEmailController = new TextEditingController();

    conditionValues.addAll([
      "Choose condition",
      "new and functional",
      "new but has a defect",
      "used but functional",
      "needs to be fixed",
      "components functional",
      "other"
    ]);
    conditionValue = conditionValues.elementAt(0);

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
    categoryValue = categoryValues.elementAt(0);
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
                  //FadeAnimation(1, imageSection()),
                  FadeAnimation(1, titleSection()),
                  FadeAnimation(1.3, fieldsSection()),
                  FadeAnimation(1.3, buttonSection()),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Container imageSection() {
    Size size = MediaQuery.of(context).size;
    double width = size.width;
    return Container(
        height: 100,
        color: Colors.white,
        child: Stack(children: <Widget>[
          ImagePart(imageWidth, imageTop, (width - imageWidth - 60) / 2, 1,
              'assets/images/gogreen/gogreen.png'),
          ImagePart(arrowImageWidth, imageTop, width - 60 - arrowImageWidth * 2,
              1.3, 'assets/images/gogreen/gogreen-side-1.png'),
          ImagePart(arrowImageWidth, imageTop, arrowImageWidth * 1, 1.3,
              'assets/images/gogreen/gogreen-side-2.png'),
        ]));
  }

  Container titleSection() {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 30.0, 0, 30.0),
      child: Text(
        "ADD ITEM",
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
        children: <Widget>[
          CustomTextFormField(TextInputType.text, 30, _nameController, "Title",
              true, Icons.title),
          CustomTextFormField(TextInputType.text, 90, _detailsController,
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
          CustomTextFormField(TextInputType.phone, 10, _contactPhoneController,
              "Contact Phone", true, Icons.phone),
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
          Row(
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
              // RaisedButton(
              //   onPressed: _upload,
              //   child: Text('Upload Image'),
              // )
            ],
          ),
          _image == null
              ? Padding(
                  padding: EdgeInsets.only(left: 48.0),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text('No Image Selected',
                          style: TextStyle(
                            color: Colors.grey.shade600,
                          ))))
              : Image.file(_image)
        ],
      ),
    );
  }

  Container buttonSection() {
    return Container(
      width: MediaQuery.of(context).size.width / 2,
      padding: EdgeInsets.fromLTRB(0, 30.0, 0, 30.0),
      child: RaisedButton(
        onPressed: () {
          databaseHelper.addDataProducts(
              _nameController.text.trim(),
              _detailsController.text.trim(),
              categoryValue,
              conditionValue,
              _contactPhoneController.text.trim(),
              _contactEmailController.text.trim(),
              _image == null ? "" : _image.path.split("/").last,
              _image == null ? "" : base64Encode(_image.readAsBytesSync()),
              address);
          Navigator.of(context).push(new MaterialPageRoute(
            builder: (BuildContext context) => new HomePage(),
          ));
        },
        //elevation: 0.0,
        color: darkGreen,
        child: Container(
          child: Text(
            "ADD",
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
