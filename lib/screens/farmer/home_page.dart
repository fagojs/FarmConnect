import 'package:flutter/material.dart';
import './list_product_page/list_product.dart';
import './manage_order/manage_orders.dart';
import './profile/profile_page.dart';

class FarmerHomePage extends StatefulWidget {
  @override
  _FarmerHomePageState createState() => _FarmerHomePageState();
}

class _FarmerHomePageState extends State<FarmerHomePage> {
  String _selectedFilter = 'All';
  int _currentIndex = 0;
  final List<Map<String, String>> _orders = [
    {
      'status': 'New',
      'owner': 'James Smith',
      'product': 'Tomatoes',
      'quantity': '100',
      'price': '3'
    },
    {
      'status': 'Processing',
      'owner': 'David Malla',
      'product': 'Garlic',
      'quantity': '100',
      'price': '3'
    },
    {
      'status': 'Completed',
      'owner': 'James Smith',
      'product': 'Tomatoes',
      'quantity': '100',
      'price': '3'
    },
    {
      'status': 'Processing',
      'owner': 'David Malla',
      'product': 'Garlic',
      'quantity': '100',
      'price': '3'
    },
    {
      'status': 'Completed',
      'owner': 'James Smith',
      'product': 'Tomatoes',
      'quantity': '100',
      'price': '3'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FarmConnect'),
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              Scaffold.of(context).openDrawer(); // Opens the drawer
            },
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
              // User profile logic
            },
          ),
        ],
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
              },
            ),
            ListTile(
              leading: const Icon(Icons.add_circle),
              title: const Text('List Product'),
              onTap: () {
                Navigator.of(context).pop(); // Close the drawer
                // Navigate to List Product Screen
              },
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Profile'),
              onTap: () {
                Navigator.of(context).pop(); // Close the drawer
                // Navigate to Profile Screen
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                Navigator.of(context).pop(); // Close the drawer
                // Navigate to Settings Screen
              },
            ),
            Divider(),
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
              itemCount: _orders.length,
              itemBuilder: (context, index) {
                final order = _orders[index];
                if (_selectedFilter == 'All' ||
                    _selectedFilter == order['status']) {
                  return _buildOrderCard(order);
                } else {
                  return SizedBox.shrink(); // Hide if not in selected filter
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
          MaterialPageRoute(builder: (context) => ProfilePage()), // Replace with your Profile page
        );
        break;
    }
  },
  items: [
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
          _selectedFilter = filter;
        });
      },
      child: Text(filter),
    );
  }

  Widget _buildOrderCard(Map<String, String> order) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              decoration: BoxDecoration(
                color: _getStatusColor(order['status']!),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                order['status']!,
                style: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(height: 10),
            _buildOrderDetailRow('Business Owner Name', order['owner']!),
            _buildOrderDetailRow('Products Ordered', order['product']!),
            _buildOrderDetailRow('Quantity (in kg)', order['quantity']!),
            _buildOrderDetailRow('Price (per kg)', order['price']!),
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
            style: TextStyle(fontWeight: FontWeight.bold),
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
