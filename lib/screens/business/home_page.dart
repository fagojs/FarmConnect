import 'package:flutter/material.dart';
import 'package:farm_connect/data/cart_state.dart';
import './product_details.dart';
import './cart_page.dart';
import './category/category_page.dart';
import './profile_page/profile_page.dart';
import '../../data/all_products.dart';

class BusinessOwnerHomePage extends StatefulWidget {
  @override
  _BusinessOwnerHomePageState createState() => _BusinessOwnerHomePageState();
}

class _BusinessOwnerHomePageState extends State<BusinessOwnerHomePage> {
  String selectedCategory = "All";
  List<Map<String, dynamic>> filteredProducts = [];

  @override
  void initState() {
    super.initState();
    filteredProducts = allListedProducts; // Initially show all products from the imported list
  }

  // Filter products by category
  void filterProductsByCategory(String category) {
    setState(() {
      if (category == "All") {
        filteredProducts = allListedProducts;
      } else {
        filteredProducts = allListedProducts
            .where((product) => product['category'] == category)
            .toList();
      }
      selectedCategory = category;
    });
  }

  // Filter products by search query
  void filterProductsBySearch(String query) {
    setState(() {
      filteredProducts = allListedProducts.where((product) {
        return product['name'].toLowerCase().contains(query.toLowerCase());
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue[50],
        appBar: AppBar(
          title: Text(
            'FarmConnect',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,

          leading: Builder(
            builder: (context) => IconButton(
              icon: Icon(Icons.menu),
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
                  },
                ),
                ListTile(
                  leading: Icon(Icons.shopping_cart, color: Colors.green),
                  title: Text('Cart'),
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                ),
                ListTile(
                  leading: Icon(Icons.category, color: Colors.green),
                  title: Text('Categories'),
                  onTap: () {
                    Navigator.of(context).pop();
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
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              // Search Bar
              TextField(
                onChanged: filterProductsBySearch,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search, color: Colors.green),
                  hintText: 'Search local farm products',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: EdgeInsets.all(16),
                ),
              ),
              SizedBox(height: 20),

              // Categories Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Categories',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Navigate to full Categories page
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => CategoryPage()),
                      );
                    },
                    child: Text(
                      'See All',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Container(
                height: 120,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        // Filter products by selected category
                        filterProductsByCategory(categories[index]['name']!);
                      },
                      child: Container(
                        margin: EdgeInsets.only(right: 10),
                        child: Column(
                          children: [
                            Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              elevation: 3,
                              color: selectedCategory == categories[index]['name']
                                  ? Colors.green
                                  : Colors.white,
                              child: Container(
                                width: 80,
                                height: 80,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12.0),
                                  image: DecorationImage(
                                    image: AssetImage(categories[index]['image']!),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              categories[index]['name']!,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: selectedCategory == categories[index]['name']
                                    ? Colors.green // Change text color if selected
                                    : Colors.black, // Default text color
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 20),

              // All Products Heading
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'All Products',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 10),

              // All Products Section
              Expanded(
                child: ListView.builder(
                  itemCount: filteredProducts.length,
                  itemBuilder: (context, index) {
                    final product = filteredProducts[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductDetailsPage(
                              productName: product['name']!,
                              quantity: product['quantity']!,
                              price: product['price']!,
                              description: product['description']!,
                            ),
                          ),
                        );
                      },
                      child: Card(
                        margin: EdgeInsets.symmetric(vertical: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        elevation: 3,
                        child: Stack(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Product Image
                                Container(
                                  height: 150,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(12)),
                                    image: DecorationImage(
                                      image: AssetImage('images/placeholder_img.png'), // Use product image
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            product['name'],
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            'Price: \$${product['price']} per ${product['quantity'].split(" ")[1]}',
                                            style: TextStyle(fontSize: 14),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      Text(product['description']!),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            // "+" Icon Button Positioned
                            Positioned(
                              top: 10,
                              right: 10,
                              child: IconButton(
                                icon: Icon(Icons.add, size: 30),
                                color: Colors.green,
                                onPressed: () {
                                  // Add to cart logic
                                  String unit = product['quantity'].split(" ")[1];
                                  cartState.addToCart({
                                    "name": product['name'],
                                    "price": double.parse(product['price']),
                                    "quantity": 1,
                                    "unit": unit,
                                  });
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('${product['name']} added to cart!'),
                                      duration: Duration(seconds: 1),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),

    bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.category), label: 'Categories'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Cart'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.black,
        currentIndex: 0, // This keeps the Cart page active
        onTap: (int index) {
          switch (index) {
            case 0:
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => BusinessOwnerHomePage()),
                );
              break;
            case 1:
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => CategoryPage()),
                );
              break;
            case 2:
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => CartPage()),
                );
              break;
            case 3:
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => BusinessProfilePage()),
                );
              break;
          }
        },
      ),
    );
  }
}
