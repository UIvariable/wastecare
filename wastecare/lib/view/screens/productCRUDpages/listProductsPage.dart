import 'package:flutter/material.dart';
import 'package:new_app/controllers/getData.dart';
import 'package:new_app/view/widgets/productpageWidgets/listProducts.dart';
import 'addProductPage.dart';

class ListProductsPage extends StatefulWidget {
  @override
  _ListProductsPageState createState() => _ListProductsPageState();
}

class _ListProductsPageState extends State<ListProductsPage> {
  List data;
  Color darkGreen = Color(0xFF005642);
  Color lightPink = Color(0xFFFFB0BB);

  Widget _appBarTitle = new Text('SEARCH');
  Icon _searchIcon = new Icon(Icons.search);

  GetData getData = new GetData();

  @override
  void initState() {
    super.initState();
    this.getData.getProductsData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(new MaterialPageRoute(
              builder: (BuildContext context) => new AddProductPage()));
        },
        backgroundColor: lightPink,
        foregroundColor: Colors.grey.shade800,
      ),
      body: new FutureBuilder(
        future: getData.getProductsData(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          return snapshot.hasData
              ? new ProductList(list: snapshot.data)
              : new Center(
                  child: new CircularProgressIndicator(),
                );
        },
      ),
    );
  }

  void _searchPressed() {
    setState(() {
      if (this._searchIcon.icon == Icons.search) {
        this._searchIcon = new Icon(Icons.close);
        this._appBarTitle = new TextField(
          decoration: new InputDecoration(
              prefixIcon: new Icon(Icons.search), hintText: 'SEARCH'),
        );
      } else {
        this._searchIcon = new Icon(Icons.search);
        this._appBarTitle = new Text('SEARCH EXAMPLE');
      }
    });
  }

  Widget buildAppBar(BuildContext context) {
    return new AppBar(
      backgroundColor: lightPink,
      centerTitle: true,
      title: _appBarTitle,
      leading: new IconButton(
        icon: _searchIcon,
        onPressed: _searchPressed,
      ),
    );
  }
}
