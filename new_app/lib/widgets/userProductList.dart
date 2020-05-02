import 'package:flutter/material.dart';
import 'package:new_app/widgets/themeBoxDecoration.dart';
import 'package:new_app/widgets/userProductListItem.dart';
import '../view/viewProductDetailsPage.dart';

class UserProductList extends StatefulWidget {

  final List list;
  UserProductList({this.list});

  @override
  _UserProductListState createState() => _UserProductListState();
}

class _UserProductListState extends State<UserProductList> {
  
  @override
  void initState() {
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    
    return new ListView.builder(
            itemCount: widget.list == null ? 0 : widget.list.length,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, i) {
          return Padding(
            padding: const EdgeInsets.all(12.0),
            child: FittedBox(
              child: new GestureDetector(
                onTap: () => Navigator.of(context).push(
                  new MaterialPageRoute(
                    builder: (BuildContext context) =>
                        new ViewProductDetailsPage(list: widget.list, index: i),
                  ),
                ),
                child: ThemeBoxDecoration(
                  UserProductListItem(widget.list, i)
                ),
              ),
            ),
          );
        });
  }

}