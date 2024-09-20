import 'package:flutter/material.dart';

import './add_product.dart';
import '../home_page.dart';
import './edit_product.dart';
import '../profile/profile_page.dart';
import '../manage_order/manage_orders.dart';
import '../../../models/product_model.dart';
import '../../../data/currentuser.dart';

class ListProductPage extends StatefulWidget {
  @override
  _ListProductPageState createState() => _ListProductPageState();
}

class _ListProductPageState extends State<ListProductPage> {

  final TextEditingController _searchController = TextEditingController();
  List<Product> _filteredProducts = [];

  int _currentIndex = 1; // To keep track of the selected bottom nav index

  @override
  void initState() {
    super.initState();
    _filteredProducts = currentUser.products; // Initially show all products
  }

  void _filterProducts(String query) {
    final filtered = currentUser.products.where((product) {
      final productName = product.productName.toLowerCase();
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
        title: const Text('FarmConnect', style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),
        centerTitle: true,
        backgroundColor: Colors.green,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu,color: Colors.white,),
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
      body:Container(
    decoration: const BoxDecoration(
    gradient: LinearGradient(
    colors: [
    Color(0xFFd4fc79),
    Color(0xFF96e6a1),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    ),
    ),

      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 8,
                    offset: Offset(0, 4), // changes position of shadow
                  ),
                ],
              ),
              child: TextField(
                controller: _searchController,
                onChanged: _filterProducts,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search, color: Colors.green),
                  hintText: 'Search listed products',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
                ),
              ),
            ),
          ),
          if (_filteredProducts.isEmpty)
            const Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'No products listed yet!\n'
                          'List your first product using "+" icon below.',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            )
          else
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
      ),),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Navigate to Add Product Form and await the result
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddProductPage()),
          );

          // If the user added a product, add it to the list and refresh the UI
          setState(() {
            _filteredProducts = currentUser.products;
          });
        },
        child: const Icon(Icons.add, color: Colors.white),
        backgroundColor: Color(0xFF4CAF50),
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
                  MaterialPageRoute(builder: (context) => FarmerProfilePage()),
                );
                break;
            }
          });
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

  Widget _buildProductCard(Product product) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0)
      ),
      color: Colors.white,
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Product Image
            if (product.productImage != null)
              Image.file(
                product.productImage!,
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
            const SizedBox(height: 10),

            // Product Name and Description
            Text(
              product.productName,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text('Quantity Available (in ${product.category == 'Dairy' ? 'litre' : 'kg'}): ${product.quantity}'),
            const SizedBox(height: 10),
            Text('Price (per ${product.category == 'Dairy' ? 'litre' : 'kg'}): \$${product.pricePerKg}'),
            const SizedBox(height: 10),
            Text('Category: ${product.category}'),
            const SizedBox(height: 10),
            Text('Description: ${product.description}'),
            const SizedBox(height: 10),

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
                        final index = currentUser.products.indexOf(product);
                        currentUser.products[index] = updatedProduct;
                        _filteredProducts = currentUser.products;
                      });
                    }
                  },
                  child: const Text('Edit', style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurpleAccent,
                      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 4),
                      textStyle: TextStyle(fontSize: 18),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0)
                      )
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Remove product logic
                    setState(() {
                      currentUser.products.remove(product);
                      _filteredProducts = currentUser.products;
                    });
                  },
                  child: const Icon(Icons.delete, color: Colors.white,),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 4),
                    textStyle: TextStyle(fontSize: 18),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0)
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
