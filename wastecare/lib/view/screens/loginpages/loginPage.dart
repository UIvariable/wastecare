import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:new_app/animations/fadeAnimation.dart';
import 'package:new_app/credentials/credentials.dart';
import 'package:new_app/main.dart';
import 'package:new_app/view/widgets/loginpageWidgets/loginPageImagePart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isLoading = false;

  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double width = size.width;
    double imageTop = 400;
    double imageWidth = 150;
    double arrowImageWidth = 35;
    double rootImageWidth = 80;
    double flowerImageWidth = 35;

    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle.light.copyWith(statusBarColor: Colors.white));
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              FadeAnimation(
                1,
                Container(
                  height: 300,
                  color: Colors.white,
                  child: Stack(
                    children: <Widget>[
                      ImagePart(imageWidth, imageTop, (width - imageWidth) / 2,
                          1, 'assets/images/gogreen/gogreen.png'),
                      ImagePart(
                          arrowImageWidth,
                          imageTop,
                          width - arrowImageWidth * 2.8,
                          1.3,
                          'assets/images/gogreen/gogreen-side-1.png'),
                      ImagePart(arrowImageWidth, imageTop, arrowImageWidth * 1.8,
                          1.3, 'assets/images/gogreen/gogreen-side-2.png'),
                      ImagePart(
                          rootImageWidth,
                          imageTop + 120,
                          (width - rootImageWidth) / 2,
                          1.6,
                          'assets/images/gogreen/root.png'),
                      ImagePart(
                          flowerImageWidth,
                          imageTop / 2 + 45,
                          (width - flowerImageWidth) / 2,
                          1.6,
                          'assets/images/gogreen/flower.png'),
                    ],
                  ),
                ),
              ),
              Column(
                children: <Widget>[
                  _isLoading
                      ? Center(child: CircularProgressIndicator())
                      : Column(
                          // : ListView(
                          children: <Widget>[
                            FadeAnimation(1.9, fieldsSection()),
                            FadeAnimation(1.9, buttonSection()),
                          ],
                        ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  signIn(String email, pass) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Map data = {'email': email, 'password': pass};
    var jsonResponse;

    var response = await http.post(URL + "/signin", body: data);
    //jsonResponse = json.decode(json.encode(response.body));
    print(response.body);
    jsonResponse = json.decode(response.body);

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (jsonResponse != null) {
      setState(() {
        _isLoading = false;
      });
      sharedPreferences.setString("token", jsonResponse['token']);
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) => MainPage()),
          (Route<dynamic> route) => false);
    } else {
      setState(() {
        _isLoading = false;
      });
      print(response.body);
    }
  }

  Container fieldsSection() {
    return Container(
        padding:
            EdgeInsets.only(left: 30.0, right: 30.0, bottom: 30.0, top: 15.0),
        //EdgeInsets.symmetric(horizontal: 20.0, vertical: 60.0),
        child: Column(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              //color: Colors.red,
              padding: EdgeInsets.all(10),
              child: Text(
                "WELCOME",
                textAlign: TextAlign.center,
                style: GoogleFonts.roboto(
                  textStyle: Theme.of(context).textTheme.display1,
                  fontSize: 25,
                  fontWeight: FontWeight.w900,
                  fontStyle: FontStyle.normal,
                  color: Colors.grey.shade500,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
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
                  TextField(
                    controller: emailController,
                    cursorColor: Colors.black,
                    style: TextStyle(
                      color: Colors.grey.shade600,
                    ),
                    decoration: InputDecoration(
                        icon: Icon(Icons.email),
                        hintText: "Email",
                        border: InputBorder.none,
                        // UnderlineInputBorder(
                        //     borderSide: BorderSide(color: Colors.pink.shade200)),
                        hintStyle: TextStyle(
                          color: Colors.grey.shade600,
                        )),
                  ),
                  TextField(
                    controller: passwordController,
                    cursorColor: Colors.black,
                    style: TextStyle(color: Colors.grey.shade600),
                    decoration: InputDecoration(
                      icon: Icon(Icons.lock),
                      hintText: "Password",
                      border: InputBorder.none,
                      // UnderlineInputBorder(
                      //     borderSide: BorderSide(color: Colors.pink.shade200)),
                      hintStyle: TextStyle(color: Colors.grey.shade600),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }

  Container buttonSection() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 250.0,
      padding: EdgeInsets.symmetric(horizontal: 30.0),
      child: Column(children: <Widget>[
        RaisedButton(
          onPressed: emailController.text == "" || passwordController.text == ""
              ? null
              : () {
                  setState(() {
                    _isLoading = true;
                  });
                  signIn(emailController.text, passwordController.text);
                },
          //elevation: 0.0,
          color: Color(0xFF005642),
          child: Container(
            child: Text(
              "LOGIN",
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
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(2.0)),
        ),
        SizedBox(
          height: 30.0,
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          //color: Colors.red,
          //padding: EdgeInsets.all(10),
          child: Text(
            "NO ACCOUNT? REGISTER NOW!",
            textAlign: TextAlign.center,
            style: GoogleFonts.roboto(
              textStyle: Theme.of(context).textTheme.display1,
              fontSize: 15,
              fontWeight: FontWeight.w900,
              fontStyle: FontStyle.normal,
              color: Colors.grey.shade500,
            ),
          ),
        ),
      ]),
    );
  }
}
