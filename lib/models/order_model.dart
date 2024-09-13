import './product_model.dart';

class Order {
  String status;
  Product orderedProduct;
  int orderedQuantity;
  double totalPrice;

  Order({
    required this.status,
    required this.orderedProduct,
    required this.orderedQuantity,
  }) : totalPrice = orderedProduct.pricePerKg * orderedQuantity;
}
