import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/bottomNavigationBar.dart';
import '../widgets/homePageIconCard.dart';
import 'listProductsPage.dart';
import 'listUserProductsPage.dart';

class UserProfilePage extends StatefulWidget {
  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(
        child: Container(
         decoration: BoxDecoration(
           image: DecorationImage(
             image: AssetImage("assets/images/userprofile/userprofilebackground.png"),
            fit: BoxFit.cover,
          ),
         ),
          child: Column(
            children: <Widget>[
              
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                  Padding(
                      padding: const EdgeInsets.only(top: 55.0),
                  child: Container(
                  width: 100.0,
                  height: 100.0,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2.0),
                  ),
                  padding: EdgeInsets.all(8.0),
                  child: CircleAvatar(
                      backgroundImage: AssetImage("assets/images/noimage/noimageavailable.png"),
                      //backgroundColor: Colors.red,
                  ),
              ),),]),
              
            Container(
              margin: EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 0.0),
              height: MediaQuery.of(context).size.height/1.4,
             decoration: BoxDecoration(
               color: Colors.white,
               borderRadius: BorderRadius.only(
                 topLeft: Radius.circular(40.0),
                 topRight: Radius.circular(40.0),
               )
             ),
             child:
             Column(
               children: <Widget>[
                 Padding(
                  padding: const EdgeInsets.fromLTRB(8.0, 20.0, 8.0, 8.0),
                  child: Text("User Name",  
                    style: GoogleFonts.roboto(
                              textStyle: Theme.of(context).textTheme.headline1,
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              fontStyle: FontStyle.normal,
                              color: Colors.grey,
            ),),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Address",  
                    style: GoogleFonts.roboto(
                              textStyle: Theme.of(context).textTheme.headline1,
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                              fontStyle: FontStyle.normal,
                              color: Colors.grey,
            ),),),
            SizedBox(height: 40,),
              Container(
                color: Colors.white,
                child:
                Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      IconCard(IconData(0xe90d, fontFamily: 'materials'),
                          "My Donations", ListUserProductsPage()),
                      IconCard(IconData(0xe90a, fontFamily: 'materials'),
                          "Compost\nHosts", ListProductsPage()),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      IconCard(IconData(0xe90c, fontFamily: 'materials'),
                          "Recycling\nOptions", ListProductsPage()),
                      IconCard(IconData(0xe90b, fontFamily: 'materials'),
                          "Saved Events", ListProductsPage()),
                    ],
                  )
                ],
              ),
              ),
               BottomNavBar("person"),
               ],
             
              ),
            ),
            ],
          ),
        ),
      ),
      );
  }
  }