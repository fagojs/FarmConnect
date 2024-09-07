import 'package:flutter/material.dart';
import 'screens/signup_page.dart';
import 'screens/signin_page.dart';
import 'screens/landing_page.dart';
import 'screens/farmer/list_product_page/list_product.dart';
import 'screens/farmer/manage_order/manage_orders.dart';
import './screens/farmer/profile/profile_page.dart';
import './screens/business/home_page.dart';
import './screens/business/cart_page.dart';

void main() {
  runApp(FarmConnectApp());
}

class FarmConnectApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FarmConnect',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => CartPage(),
        '/signin': (context) => SignInPage(userType: 'Farmer'), // Adjust as needed
        '/landing': (context) => LandingPage(userType: 'Farmer'), // Adjust as needed
        // Add routes for other screens if needed
      },
    );
  }
}
