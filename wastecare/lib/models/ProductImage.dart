import 'dart:typed_data';

class ProductImage {
  String fileName;
  Uint8List base64Image;

  ProductImage(this.fileName, this.base64Image);
}