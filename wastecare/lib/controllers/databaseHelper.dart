import 'package:http/http.dart' as http;
import 'package:new_app/credentials/credentials.dart';
import 'package:new_app/models/Place.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class DatabaseHelper {
  var status;
  var token;

  //String serverUrlProducts = 'http://192.168.1.55:4000/products';
  String serverUrlProducts = URL + '/products';

  //function getData
  Future<List> getData() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key) ?? 0;

    String url = "$serverUrlProducts";
    http.Response response = await http.get(url, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $value'
    });
    return json.decode(response.body);
  }

  //function for registering products
  void addDataProducts(
      String _nameController,
      String _detailsController,
      String _categoryController,
      String _conditionController,
      String _contactPhoneController,
      String _contactEmailController,
      String fileName,
      String base64Image,
      Place address) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key) ?? 0;

    print(fileName);
    print(base64Image);

    //String url = "http://192.168.1.5:4000/products";
    String url = URL + "/products";

    final response = await http.post(
      url,
      headers: {'Accept': 'application/json'},
      body: {
        "productName": "$_nameController",
        "productDescription": "$_detailsController",
        "productCategory": "$_categoryController",
        "productCondition": "$_conditionController",
        "contactPhoneNumber": "$_contactPhoneController",
        "contactEmail": "$_contactEmailController",
        "fileName": "$fileName",
        "base64Image": "$base64Image",
        "pickupAddressId": "${address.placeId}",
        "pickupAddressName": "${address.name}",
        "pickupAddressCoord1": "${address.latlng[0]}",
        "pickupAddressCoord2": "${address.latlng[1]}",
      },
    );

    status = response.body.contains('error');

    var data = json.decode(response.body);

    if (status) {
      print('data : ${data['error']}');
    } else {
      print('data : ${data['token']}');
      _save(data['token']);
    }
  }

  //edit or delete product
  void editDataProducts(
      String _id,
      String _nameController,
      String _detailsController,
      String _categoryController,
      String _conditionController,
      String _contactPhoneController,
      String _contactEmailController,
      String fileName,
      String base64Image,
      Place address) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key) ?? 0;

    String url = URL + "/products/$_id";

    http.put(url, body: {
      "productName": "$_nameController",
      "productDescription": "$_detailsController",
      "productCategory": "$_categoryController",
      "productCondition": "$_conditionController",
      "contactPhoneNumber": "$_contactPhoneController",
      "contactEmail": "$_contactEmailController",
      "fileName": "$fileName",
      "base64Image": "$base64Image",
      "pickupAddressId": "${address.placeId}",
      "pickupAddressName": "${address.name}",
      "pickupAddressCoord1": "${address.latlng[0]}",
      "pickupAddressCoord2": "${address.latlng[1]}",
    }).then((response) {
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
    });
  }

  //function for delete
  Future<void> removeProduct(String _id) async {
    //String url = 'http://192.168.1.5:4000/products/$_id';
    String url = URL + '/products/$_id';
    http.Response res = await http.delete("$url");

    if (res.statusCode == 200) {
      print("Product deleted");
    } else {
      throw "Can't delete product";
    }
  }

  //function save
  _save(String token) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = token;
    prefs.setString(key, value);
  }

  //function read
  read() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key) ?? 0;
    print('read : $value');
  }
}
