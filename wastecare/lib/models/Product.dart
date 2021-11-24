import 'package:new_app/models/Place.dart';
import 'package:new_app/models/ProductImage.dart';

class Product {

//TODO: add user
var id;
String name;
String details;
String category;
String condition;
String contactPhone;
String contactEmail;
String fileName = "";
ProductImage productImage;
Place address;

Product(this.id, this.name, this.details, this.category, this.condition, this.contactPhone, this.contactEmail,
this.productImage, this.address);

}