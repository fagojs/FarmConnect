import '../models/order_model.dart';
import '../models/product_model.dart';

List<Order> dummyOrders = [
  Order(
    status: 'New',
    orderedProduct: Product(
      productName: 'Tomatoes',
      pricePerKg: 3.0,
      quantity: 100,
      category: 'Vegetable',
      description: 'Freshly picked tomatoes.',
    ),
    orderedQuantity: 30,
  ),
  Order(
    status: 'Processing',
    orderedProduct: Product(
      productName: 'Garlic',
      pricePerKg: 2.5,
      quantity: 50,
      category: 'Vegetable',
      description: 'Organic garlic, perfect for seasoning.',
    ),
    orderedQuantity: 50,
  ),
  Order(
    status: 'Completed',
    orderedProduct: Product(
      productName: 'Milk',
      pricePerKg: 1.5,
      quantity: 200,
      category: 'Dairy',
      description: 'Fresh cow milk delivered daily.',
    ),
    orderedQuantity: 20,
  ),
  Order(
    status: 'Processing',
    orderedProduct: Product(
      productName: 'Potatoes',
      pricePerKg: 1.0,
      quantity: 300,
      category: 'Vegetable',
      description: 'Organic potatoes perfect for baking and frying.',
    ),
    orderedQuantity: 150,
  ),
  Order(
    status: 'Completed',
    orderedProduct: Product(
      productName: 'Apples',
      pricePerKg: 2.0,
      quantity: 150,
      category: 'Fruit',
      description: 'Crisp and fresh apples from local farms.',
    ),
    orderedQuantity: 80,
  ),
  Order(
    status: 'Completed',
    orderedProduct: Product(
      productName: 'Pork Chips',
      pricePerKg: 9.0,
      quantity: 50,
      category: 'Meat',
      description: 'Crisp and fresh pork chips from local farms.',
    ),
    orderedQuantity: 20,
  ),
];
