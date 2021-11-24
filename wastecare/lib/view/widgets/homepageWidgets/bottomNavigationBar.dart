import 'package:flutter/material.dart';
import 'package:new_app/view/screens/homePage.dart';
import 'package:new_app/view/screens/userProfilePage.dart';

class BottomNavBar extends StatelessWidget {
  final String activePage;

  BottomNavBar(this.activePage);

  @override
  Widget build(BuildContext context) {
    double iconSize = 35;

    return Expanded(
      child: Align(
        //alignment: Alignment.bottomCenter,
        alignment: FractionalOffset.bottomCenter,
        //child: Padding(
        //padding: EdgeInsets.only(bottom: 20),
        child: Container(
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.home,
                    size: iconSize,
                    color: activePage == "home"
                        ? Color(0xFF005642)
                        : Colors.black),
                onPressed: () {
                  if (activePage != "home") {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => HomePage()));
                  }
                },
              ),
              IconButton(
                icon: Icon(Icons.search,
                    size: iconSize,
                    color: activePage == "search"
                        ? Color(0xFF005642)
                        : Colors.black),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.save_alt,
                    size: iconSize,
                    color: activePage == "saved"
                        ? Color(0xFF005642)
                        : Colors.black),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.person_outline,
                    size: iconSize,
                    color: activePage == "person"
                        ? Color(0xFF005642)
                        : Colors.black),
                onPressed: () {
                  // sharedPreferences.clear();
                  // sharedPreferences.commit();
                  if (activePage != "person") {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => UserProfilePage()));
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
