import 'dart:io';

class Product {
  String productName;
  double pricePerKg;
  int quantity;
  String category;
  String description;
  File? productImage;

  Product({
    required this.productName,
    required this.pricePerKg,
    required this.quantity,
    required this.category,
    required this.description,
    this.productImage,
  });
}