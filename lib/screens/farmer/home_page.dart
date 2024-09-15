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
      backgroundColor: Color(0xFFE0F7FA),
      appBar: AppBar(
        title: Text('FarmConnect',style: TextStyle(fontWeight: FontWeight.bold),),
        centerTitle: true,
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
        child: Container(
          color: Colors.white,
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.green,
                ),
                child: Center(
                  child: Text(
                    'FarmConnect',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.home, color: Colors.green),
                title: Text('Home'),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => FarmerHomePage()));
                },
              ),
              ListTile(
                leading: Icon(Icons.add_circle, color: Colors.green),
                title: Text('List Product'),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => ListProductPage()));
                },
              ),
              ListTile(
                leading: Icon(Icons.person, color: Colors.green),
                title: Text('Profile'),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => FarmerProfilePage()));
                },
              ),
              ListTile(
                leading: Icon(Icons.settings, color: Colors.green),
                title: Text('Settings'),
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
              Divider(color: Colors.grey[300]),
              ListTile(
                leading: Icon(Icons.logout, color: Colors.red),
                title: Text('Log Out'),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.pushReplacementNamed(context, '/signin');
                },
              ),
            ],
          ),
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
          MaterialPageRoute(builder: (context) => OrdersPage()),
        );
        break;
      case 3:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => FarmerProfilePage()),
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
  selectedItemColor: Colors.green,
  unselectedItemColor: Colors.black,
),

    );
  }

  Widget _buildFilterButton(String filter) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: _selectedFilter == filter ? Colors.green[700] : Colors.grey[200],
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
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0)
      ),
      color: Colors.white,
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              decoration: BoxDecoration(
                color: _getStatusColor(order.status),
                borderRadius: BorderRadius.circular(2.0),
              ),
              child: Text(
                order.status,
                style: const TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(height: 10),
            _buildOrderDetailRow('Products Ordered', order.orderedProduct.productName),
            const SizedBox(height: 10),
            _buildOrderDetailRow('Quantity Ordered (in ${order.orderedProduct.category == 'Dairy' ? 'litre' : 'kg'})', order.orderedQuantity.toString()),
            const SizedBox(height: 10),
            _buildOrderDetailRow('Price (per ${order.orderedProduct.category == 'Dairy' ? 'litre' : 'kg'})', '\$${order.orderedProduct.pricePerKg.toString()}'),
            const SizedBox(height: 10),
            GestureDetector(
              onTap:(){
                _toggleBusinessInfo(index);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Ordered Received From',
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
