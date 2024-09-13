import 'package:flutter/material.dart';
import '../list_product_page/list_product.dart';
import '../home_page.dart';
import '../profile/profile_page.dart';
import '../../../data/dummy_orders.dart';
import '../../../models/order_model.dart';

class OrdersPage extends StatefulWidget {
  @override
  _OrdersPageState createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> with SingleTickerProviderStateMixin {
  // This list keeps track of which card's business information is visible
  List<bool> _showBusinessOwnerInfoList = [];

  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    // Initialize the visibility state for each order as false (collapsed)
    _tabController = TabController(length: 2, vsync: this);
    _showBusinessOwnerInfoList = List<bool>.filled(dummyOrders.length, false);
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }
  void _toggleBusinessInfo(int index) {
    setState(() {
      _showBusinessOwnerInfoList[index] = !_showBusinessOwnerInfoList[index];
    });
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
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => FarmerHomePage()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.add_circle),
              title: Text('List product'),
              onTap: () {
                Navigator.pop(context);
                // Navigate to List Product page
                 Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => ListProductPage()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Profile'),
              onTap: () {
                Navigator.pop(context);
                // Navigate to Profile page
                 Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => FarmerProfilePage()),
                );
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
          BottomNavigationBarItem(icon: Icon(Icons.checklist_rtl_sharp), label: 'Orders'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.black,
      ),
    );
  }

 // Build New Orders Tab
Widget _buildNewOrdersTab() {
  List<Order> newOrders = dummyOrders.where((order) => order.status == 'New').toList();
  if(newOrders.isEmpty){
    return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'No new orders at the moment !!',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),
                ],
              ),
            );
  }else{
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
                const SizedBox(height: 8),
                const Text(
                  'Order Summary:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text('Product Ordered: ${order.orderedProduct.productName}'),
                const SizedBox(height: 8),
                Text('Quantity Ordered (in ${order.orderedProduct.category == 'Dairy' ? 'litre' : 'kg'}): ${order.orderedQuantity}'),
                const SizedBox(height: 8),
                Text('Price (per ${order.orderedProduct.category == 'Dairy' ? 'litre' : 'kg'}): \$${order.orderedProduct.pricePerKg}'),
                const SizedBox(height: 10),
                const Divider(thickness: 2, color: Colors.grey,),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap:(){
                    _toggleBusinessInfo(index);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text(
                        'Ordered Received From',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Icon(_showBusinessOwnerInfoList[index] ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down, size: 35,),
                    ],
                  ),
                ),
                if (_showBusinessOwnerInfoList[index]) ...[
                  const SizedBox(height: 8),
                  const Text('Business Owner Name: John Wick', style: TextStyle(fontSize: 16)),
                  const SizedBox(height: 8),
                  const Text('Business Owner Address: Sydney, Australia', style: TextStyle(fontSize: 16)),
                  const SizedBox(height: 8),
                  const Text('Business Owner Contact Number: 042867456', style: TextStyle(fontSize: 16)),
                  const SizedBox(height: 8),
                  const Text('Email: johnwick@gmail.com', style: TextStyle(fontSize: 16)),
                ],
                const SizedBox(height: 10),
                const Divider(thickness: 2, color: Colors.grey,),
                const SizedBox(height: 10),
                const Text(
                    'Mark As:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          newOrders[index].status = 'Processing'; // Set the status to 'Processing'
                          dummyOrders.add(newOrders[index]); // Move to order history
                          newOrders.removeAt(index); // Remove from new orders
                        });
                        _tabController?.animateTo(1); // Navigate to Order History tab
                      },
                      child: Text('Processing'),
                    ),
                    
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          newOrders[index].status = 'Completed'; // Set the status to 'Completed'
                          dummyOrders.add(newOrders[index]); // Move to order history
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
}



  // Build Order History Tab
Widget _buildOrderHistoryTab() {
  List<Order> orderHistory = dummyOrders.where((order) => order.status != 'New').toList();
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
              const SizedBox(height: 8),
              const Text(
                'Order Summary:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text('Product Ordered: ${order.orderedProduct.productName}'),
              const SizedBox(height: 8),
              Text('Quantity Ordered (in ${order.orderedProduct.category == 'Dairy' ? 'litre' : 'kg'}): ${order.orderedQuantity}'),
              const SizedBox(height: 8),
              Text('Price (per ${order.orderedProduct.category == 'Dairy' ? 'litre' : 'kg'}): \$${order.orderedProduct.pricePerKg}'),
              const SizedBox(height: 10),
              const Divider(thickness: 2, color: Colors.grey,),
              const SizedBox(height: 10),
              GestureDetector(
                onTap:(){
                  _toggleBusinessInfo(index);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text(
                      'Ordered Received From',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Icon(_showBusinessOwnerInfoList[index] ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down, size: 35,),
                  ],
                ),
              ),
              if (_showBusinessOwnerInfoList[index]) ...[
                const SizedBox(height: 8),
                const Text('Business Owner Name: John Wick', style: TextStyle(fontSize: 16)),
                const SizedBox(height: 8),
                const Text('Business Owner Address: Sydney, Australia', style: TextStyle(fontSize: 16)),
                const SizedBox(height: 8),
                const Text('Business Owner Contact Number: 042867456', style: TextStyle(fontSize: 16)),
                const SizedBox(height: 8),
                const Text('Email: johnwick@gmail.com', style: TextStyle(fontSize: 16)),
              ],
              const SizedBox(height: 10),
              const Divider(thickness: 2, color: Colors.grey,),
              const SizedBox(height: 10),
              const Text(
                  'Mark As:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),

              // If the order is 'Processing', show the "Mark as Completed" button
              if (order.status == 'Processing')
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      orderHistory[index].status = 'Completed'; // Mark as completed
                    });
                  },
                  child: Text('Mark as Completed'),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                ),

              // If the order is 'Completed', show the completed status message and no buttons
              if (order.status == 'Completed')
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
