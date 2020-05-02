import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/bottomNavigationBar.dart';
import '../widgets/homePageCarousel.dart';
import '../widgets/homePageIconCard.dart';
import 'loginPage.dart';
import 'listProductsPage.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  SharedPreferences sharedPreferences;
  Color darkGreen = Color(0xFF005642);
  Color lightPink = Color(0xFFFFB0BB);

  @override
  void initState() {
    super.initState();
    getSharedPref();
  }

  getSharedPref() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: Column(
            children: <Widget>[
              SizedBox(height: 50.0),
              ImageCarousel(
                  'assets/images/carousel1/rethink.png',
                  'assets/images/carousel1/reuse.png',
                  'assets/images/carousel1/recycle.png'),
              SizedBox(height: 50.0),
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Hello",
                          style: GoogleFonts.roboto(
                            textStyle: Theme.of(context).textTheme.headline1,
                            fontSize: 30,
                            fontWeight: FontWeight.w900,
                            fontStyle: FontStyle.normal,
                            color: Color(0xFFFFB0BB),
                          ),
                        ),
                        TextSpan(
                          text: ", what are you\nlooking for?",
                          style: GoogleFonts.roboto(
                            textStyle: Theme.of(context).textTheme.headline1,
                            fontSize: 30,
                            fontWeight: FontWeight.w900,
                            fontStyle: FontStyle.normal,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              //SizedBox(height: 30.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      IconCard(IconData(0xe90d, fontFamily: 'materials'),
                          "Donations", ListProductsPage()),
                      IconCard(IconData(0xe90a, fontFamily: 'materials'),
                          "Compost\nHosts", ListProductsPage()),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      IconCard(IconData(0xe90c, fontFamily: 'materials'),
                          "Recycling\nOptions", ListProductsPage()),
                      IconCard(IconData(0xe90b, fontFamily: 'materials'),
                          "Events", ListProductsPage()),
                    ],
                  )
                ],
              ),
              FlatButton(
                  onPressed: () {
                    print(sharedPreferences.getString("token"));
                    sharedPreferences.clear();
                    sharedPreferences.commit();
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (BuildContext context) => LoginPage()),
                        (Route<dynamic> route) => false);
                  },
                  child: Text(
                    "Logout",
                    style: TextStyle(color: Colors.red),
                  )),
              BottomNavBar("home"),
            ],
          ),
        ),
      ),
      // drawer: Drawer(
      //   child: new ListView(
      //     children: <Widget>[
      //       new UserAccountsDrawerHeader(
      //           accountName: new Text("Nodejs"),
      //           accountEmail: new Text("uivarimelinda23@gmail.com")),
      //       new ListTile(
      //         title: new Text("List Products"),
      //         trailing: new Icon(Icons.list),
      //         onTap: () => Navigator.of(context).push(new MaterialPageRoute(
      //             builder: (BuildContext context) => ListProducts())),
      //       ),
      //       new ListTile(
      //         title: new Text("Add Product"),
      //         trailing: new Icon(Icons.add),
      //         onTap: () => Navigator.of(context).push(new MaterialPageRoute(
      //             builder: (BuildContext context) => AddDataProduct())),
      //       ),
      //       new ListTile(
      //         title: new Text("Register Now"),
      //         trailing: new Icon(Icons.add),
      //         onTap: () => Navigator.of(context).push(new MaterialPageRoute(
      //             builder: (BuildContext context) => ListProducts())),
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}
