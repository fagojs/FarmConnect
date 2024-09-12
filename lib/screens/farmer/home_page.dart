import 'package:flutter/material.dart';

import './list_product_page/list_product.dart';
import './manage_order/manage_orders.dart';
import './profile/profile_page.dart';
import '../../data/dummy_orders.dart';
import '../../models/order_model.dart';

class FarmerHomePage extends StatefulWidget {
  @override
  _FarmerHomePageState createState() => _FarmerHomePageState();
}

class _FarmerHomePageState extends State<FarmerHomePage> {
  String _selectedFilter = 'All';
  int _currentIndex = 0;

  // This list keeps track of which card's business information is visible
  List<bool> _showBusinessOwnerInfoList = [];

  @override
  void initState() {
    super.initState();
    // Initialize the visibility state for each order as false (collapsed)
    _showBusinessOwnerInfoList = List<bool>.filled(dummyOrders.length, false);
  }

  void _toggleBusinessInfo(int index) {
    setState(() {
      _showBusinessOwnerInfoList[index] = !_showBusinessOwnerInfoList[index];
    });
  }

  // Helper function to reset business owner info state
  void _resetBusinessInfoState() {
    setState(() {
      _showBusinessOwnerInfoList = List.filled(dummyOrders.length, false);
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FarmConnect'),
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              Scaffold.of(context).openDrawer(); // Opens the drawer
            },
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.lightGreenAccent,
              ),
              child: Text(
                'FarmConnect',
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {
                Navigator.of(context).pop(); // Close the drawer
                // Navigate to Home Screen
                Navigator.pushReplacement(
                  context, 
                  MaterialPageRoute(builder: (context) => FarmerHomePage()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.add_circle),
              title: const Text('List Product'),
              onTap: () {
                Navigator.of(context).pop(); // Close the drawer
                // Navigate to List Product Screen
                Navigator.pushReplacement(
                  context, 
                  MaterialPageRoute(builder: (context) => ListProductPage())
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Profile'),
              onTap: () {
                Navigator.of(context).pop(); // Close the drawer
                // Navigate to Profile Screen
                Navigator.pushReplacement(
                  context, 
                  MaterialPageRoute(builder: (context) => FarmerProfilePage()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                Navigator.of(context).pop(); // Close the drawer
                // Navigate to Settings Screen
              }
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Log Out'),
              onTap: () {
                Navigator.of(context).pop(); // Close the drawer
                Navigator.pushReplacementNamed(context, '/signin');
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                _buildFilterButton('All'),
                _buildFilterButton('New'),
                _buildFilterButton('Processing'),
                _buildFilterButton('Completed'),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: dummyOrders.length,
              itemBuilder: (context, index) {
                final order = dummyOrders[index];
                if (_selectedFilter == 'All' ||
                    _selectedFilter == order.status) {
                  return _buildOrderCard(order, index);
                } else {
                  return const SizedBox.shrink(); // Hide if not in selected filter
                }
              },
            ),
          ),
        ],
      ),
  bottomNavigationBar: BottomNavigationBar(
  currentIndex: _currentIndex, // Set the current index
  onTap: (index) {
    setState(() {
      _currentIndex = index; // Update the current index
      _resetBusinessInfoState();
    });

    // Navigate to the respective page based on index
    switch (index) {
      case 0:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => FarmerHomePage()),
        );
        break;
      case 1:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => ListProductPage()),
        );
        break;
      case 2:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => OrdersPage()), // Replace with your Orders page
        );
        break;
      case 3:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => FarmerProfilePage()), // Replace with your Profile page
        );
        break;
    }
  },
  items: const [
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: 'Home',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.add_circle),
      label: 'List Product',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.checklist_rtl_sharp),
      label: 'Orders',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.person),
      label: 'Profile',
    ),
  ],
  selectedItemColor: Colors.orange,
  unselectedItemColor: Colors.black,
),

    );
  }

  Widget _buildFilterButton(String filter) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: _selectedFilter == filter ? Colors.black : Colors.grey[300],
        foregroundColor: _selectedFilter == filter ? Colors.white : Colors.black,
      ),
      onPressed: () {
        setState(() {
          _resetBusinessInfoState();
          _selectedFilter = filter;
        });
      },
      child: Text(filter),
    );
  }

  Widget _buildOrderCard(Order order, int index) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              decoration: BoxDecoration(
                color: _getStatusColor(order.status),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                order.status,
                style: const TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(height: 10),      
            _buildOrderDetailRow('Products Ordered', order.orderedProduct.productName),
            _buildOrderDetailRow('Quantity Ordered (in ${order.orderedProduct.category == 'Dairy' ? 'litre' : 'kg'})', order.orderedQuantity.toString()),
            _buildOrderDetailRow('Price (per ${order.orderedProduct.category == 'Dairy' ? 'litre' : 'kg'})', '\$${order.orderedProduct.pricePerKg.toString()}'),
            const SizedBox(height: 10),
            GestureDetector(
              onTap:(){
                _toggleBusinessInfo(index);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Business Owner Information',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Icon(_showBusinessOwnerInfoList[index] ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down, size: 35,),
                ],
              ),
            ),
            if (_showBusinessOwnerInfoList[index]) ...[
              const SizedBox(height: 10),
              const Text('Business Owner Name: John Wick', style: TextStyle(fontSize: 16)),
              const Text('Business Owner Address: Sydney, Australia', style: TextStyle(fontSize: 16)),
              const Text('Business Owner Contact Number: 042867456', style: TextStyle(fontSize: 16)),
              const Text('Email: johnwick@gmail.com', style: TextStyle(fontSize: 16)),
            ],
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(value),
        ],
      ),
      
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'New':
        return Colors.teal;
      case 'Processing':
        return Colors.orange;
      case 'Completed':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }
}
