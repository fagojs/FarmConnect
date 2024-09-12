import 'package:flutter/material.dart';
import '../list_product_page/list_product.dart';
import '../home_page.dart';
import '../profile/profile_page.dart';

class OrdersPage extends StatefulWidget {
  @override
  _OrdersPageState createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> with SingleTickerProviderStateMixin {
  List<Map<String, dynamic>> newOrders = [
    {
      'businessOwner': 'Jaes Smith',
      'product': 'Tomatoes',
      'quantity': '100',
      'price': '3\$',
      'status': 'New',
    },
  ];

  List<Map<String, dynamic>> orderHistory = [
    {
      'businessOwner': 'James Smith',
      'product': 'Tomatoes',
      'quantity': '100',
      'price': '3\$',
      'status': 'Completed',
    },
    {
      'businessOwner': 'James Smith',
      'product': 'Tomatoes',
      'quantity': '100',
      'price': '3\$',
      'status': 'Processing',
    },
  ];

  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FarmConnect'),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'New Orders'),
            Tab(text: 'Order History'),
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.lightGreenAccent),
              child: Text(
                'FarmConnect',
                style: TextStyle(color: Colors.green, fontSize: 24),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () {
                Navigator.pop(context);
                // Navigate to Home page
              },
            ),
            ListTile(
              leading: Icon(Icons.add_circle),
              title: Text('List product'),
              onTap: () {
                Navigator.pop(context);
                // Navigate to List Product page
              },
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Profile'),
              onTap: () {
                Navigator.pop(context);
                // Navigate to Profile page
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () {
                Navigator.pop(context);
                // Navigate to Settings page
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Log Out'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushReplacementNamed(context, '/signin');
              },
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildNewOrdersTab(),
          _buildOrderHistoryTab(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 2, // Assuming Orders page is the third tab
        onTap: (index) {
          // Navigate between different pages
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
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.add_circle), label: 'List Product'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Orders'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.black,
      ),
    );
  }

 // Build New Orders Tab
Widget _buildNewOrdersTab() {
  return ListView.builder(
    itemCount: newOrders.length,
    itemBuilder: (context, index) {
      final order = newOrders[index];
      return Card(
        margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Business Owner: ${order['businessOwner']}',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text('Product Ordered: ${order['product']}'),
              Text('Quantity (in kg): ${order['quantity']}'),
              Text('Price (per kg): ${order['price']}'),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        newOrders[index]['status'] = 'Processing'; // Set the status to 'Processing'
                        orderHistory.add(newOrders[index]); // Move to order history
                        newOrders.removeAt(index); // Remove from new orders
                      });
                      _tabController?.animateTo(1); // Navigate to Order History tab
                    },
                    child: Text('Processing'),
                  ),
                  
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        newOrders[index]['status'] = 'Completed'; // Set the status to 'Completed'
                        orderHistory.add(newOrders[index]); // Move to order history
                        newOrders.removeAt(index); // Remove from new orders
                      });
                      _tabController?.animateTo(1); // Navigate to Order History tab
                    },
                    child: Text('Completed'),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}



  // Build Order History Tab
Widget _buildOrderHistoryTab() {
  return ListView.builder(
    itemCount: orderHistory.length,
    itemBuilder: (context, index) {
      final order = orderHistory[index];
      return Card(
        margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Business Owner: ${order['businessOwner']}',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text('Product Ordered: ${order['product']}'),
              Text('Quantity (in kg): ${order['quantity']}'),
              Text('Price (per kg): ${order['price']}'),
              SizedBox(height: 10),

              // If the order is 'Processing', show the "Mark as Completed" button
              if (order['status'] == 'Processing')
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      orderHistory[index]['status'] = 'Completed'; // Mark as completed
                    });
                  },
                  child: Text('Mark as Completed'),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                ),

              // If the order is 'Completed', show the completed status message and no buttons
              if (order['status'] == 'Completed')
                Text(
                  'Status: Completed',
                  style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
                ),
            ],
          ),
        ),
      );
    },
  );
}

}
