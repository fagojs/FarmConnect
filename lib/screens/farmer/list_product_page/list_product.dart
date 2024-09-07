import 'package:farm_connect/screens/farmer/manage_order/manage_orders.dart';
import 'package:farm_connect/screens/farmer/profile/profile_page.dart';
import 'package:flutter/material.dart';

import './add_product.dart';
import '../home_page.dart';
import './edit_product.dart';

class ListProductPage extends StatefulWidget {
  @override
  _ListProductPageState createState() => _ListProductPageState();
}

class _ListProductPageState extends State<ListProductPage> {
  List<Map<String, dynamic>> _products = [
    {
      'name': 'Tomatoes',
      'quantity': '100',
      'price': '3\$',
      'description': 'Locally grown with local farm techniques.',
      'image': null,
    },
  ];

  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _filteredProducts = [];

  int _currentIndex = 1; // To keep track of the selected bottom nav index

  @override
  void initState() {
    super.initState();
    _filteredProducts = _products; // Initially show all products
  }

  void _filterProducts(String query) {
    final filtered = _products.where((product) {
      final productName = product['name']!.toLowerCase();
      return productName.contains(query.toLowerCase());
    }).toList();
    setState(() {
      _filteredProducts = filtered;
    });
  }

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
                // Stay on the current screen
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
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              onChanged: _filterProducts,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Search listed products',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _filteredProducts.length,
              itemBuilder: (context, index) {
                final product = _filteredProducts[index];
                return _buildProductCard(product);
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Navigate to Add Product Form and await the result
          final newProduct = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddProductPage()),
          );

          // If the user added a product, add it to the list and refresh the UI
          if (newProduct != null) {
            setState(() {
              _products.add(newProduct);
              _filteredProducts = _products;
            });
          }
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
            switch (index) {
              case 0:
                // Navigate to Home page
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
                  MaterialPageRoute(builder: (context) => ProfilePage()),
                );
                break;
            }
          });
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

 Widget _buildProductCard(Map<String, dynamic> product) {
  return Card(
    margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Product Image
          if (product['image'] != null)
            Image.file(
              product['image'],
              width: double.infinity,
              height: 150,
              fit: BoxFit.cover,
            )
          else
            Image.asset(
              'images/placeholder_img.png', // Placeholder image
              width: double.infinity,
              height: 150,
              fit: BoxFit.cover,
            ),
          SizedBox(height: 10),
          
          // Product Name and Description
          Text(
            product['name']!,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Text('Quantity (in kg): ${product['quantity']}'),
          Text('Price (per kg): \$${product['price']}'),
          SizedBox(height: 10),
          Text('Description: ${product['description']}'),
          SizedBox(height: 10),

          // Edit and Remove buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: () async {
                  // Navigate to the EditProductPage and wait for the result
                  final updatedProduct = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditProductPage(product: product),
                    ),
                  );

                  // If the product is updated, update the list
                  if (updatedProduct != null) {
                    setState(() {
                      final index = _products.indexOf(product);
                      _products[index] = updatedProduct;
                      _filteredProducts = _products;
                    });
                  }
                },
                child: Text('Edit'),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
              ),
              ElevatedButton(
                onPressed: () {
                  // Remove product logic
                  setState(() {
                    _products.remove(product);
                    _filteredProducts = _products;
                  });
                },
                child: Text('Remove'),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

}
