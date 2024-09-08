import './product_model.dart';

class Order {
  String businessOwnerName;
  List<Product> products;
  String status; // "New", "In-progress", "Completed"
  String address;
  DateTime date;

  Order({
    required this.businessOwnerName,
    required this.products,
    required this.status,
    required this.address,
    required this.date,
  });
}