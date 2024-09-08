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
    image: 'images/placeholder_img.png', // placeholder
  ),
  Product(
    name: 'Strawberry',
    pricePerKg: 3.5,
    quantity: 100,
    category: "Fruit",
    description: 'Fresh and sweet.',
    image: 'images/placeholder_img.png', // placeholder
  ),
  Product(
    name: 'Cheese',
    pricePerKg: 18.5,
    quantity: 100,
    category: "Dairy",
    description: 'Delicious.',
    image: 'images/placeholder_img.png', // placeholder
  ),
  Product(
    name: 'Beans',
    pricePerKg: 3.5,
    quantity: 100,
    category: "Grain",
    description: 'Locally grown with local farm techniques.',
    image: 'images/placeholder_img.png', // placeholder
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
