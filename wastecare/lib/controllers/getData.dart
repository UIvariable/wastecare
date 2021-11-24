import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:new_app/credentials/credentials.dart';
import 'package:new_app/models/Product.dart';
import 'package:http/http.dart' as http;
import 'package:new_app/models/Place.dart';
import 'dart:convert';

import 'package:new_app/models/ProductImage.dart';

class GetData {

  Future<List<Product>> getProductsData() async {
    final response = await http.get(URL + "/products");
    var jsonProductsData = json.decode(response.body);

    List<Product> productsList = [];

    /* 
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
    */

    for (var prod in jsonProductsData) {
      var id;
      var image;
      String fileName;
      Uint8List productUint8List;
      ProductImage productImage;
      Place productPlace;
      List<double> latlng = new List<double>();
      List<int> base64Image = [];

      id = prod["_id"];
      image = prod['image'];

      latlng.addAll([
        prod['pickupAddress']['coordinates'][0],
        prod['pickupAddress']['coordinates'][1]
        ]);

      productPlace = Place(prod["pickupAddress"]["name"], prod["pickupAddress"]["id"], latlng);

      if(image != null) {
          fileName = prod["image"]["fileName"];
          base64Image = prod["image"]["data"]["data"].cast<int>();
          productUint8List = base64Decode(base64Encode(base64Image));
          productImage = new ProductImage(fileName, productUint8List);
      }

      Product product = Product(id,
      prod["productName"], prod["productDescription"],
      prod["productCategory"], prod["productCondition"],
      prod["contactPhoneNumber"], prod["contactEmail"],
      productImage,
      productPlace
      );

      productsList.add(product);
    }

    return productsList; 
  }
}