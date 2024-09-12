import './product_model.dart';

class Order {
  final String status;
  final Product orderedProduct;
  final int orderedQuantity;
  final double totalPrice;

  Order({
    required this.status,
    required this.orderedProduct,
    required this.orderedQuantity,
  }) : totalPrice = orderedProduct.pricePerKg * orderedQuantity;
}
