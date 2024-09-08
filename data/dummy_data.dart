// data/dummy_data.dart
import '../models/farmer_model.dart';
import '../models/order_model.dart';
import '../models/product_model.dart';

List<Farmer> dummyFarmers = [
  Farmer(
    name: 'John Wick',
    contactNumber: '042867456',
    email: 'johnwick@gmail.com',
    farmName: 'John’s Farm',
    farmAddress: 'Sydney, Australia',
    farmDescription: 'Locally grown with care',
  ),
];

List<Product> dummyProducts = [
  Product(
    name: 'Tomatoes',
    pricePerKg: 3.0,
    quantity: 100,
    category: "Vegetable",
    description: 'Locally grown with local farm techniques.',
    image: 'assets/tomatoes.png', // placeholder
  ),
  // Add more dummy products here
];

List<Order> dummyOrders = [
  Order(
    businessOwnerName: 'James Smith',
    products: [
      Product(
        name: 'Tomatoes',
        pricePerKg: 3.0,
        quantity: 100,
        category: "Vegetable",
        description: 'Locally grown with local farm techniques.',
        image: 'assets/tomatoes.png',
      ),
    ],
    status: 'New',
    address: 'Sydney, Australia',
    date: DateTime.now(),
  ),
];
