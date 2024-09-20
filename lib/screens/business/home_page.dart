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

        appBar: AppBar(
          title: const Text(
            'FarmConnect',
            style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),
          ),
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
                const DrawerHeader(
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
                  leading: const Icon(Icons.home, color: Colors.green),
                  title: const Text('Home'),
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => BusinessOwnerHomePage()),
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.shopping_cart, color: Colors.green),
                  title: const Text('Cart'),
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => CartPage()),
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.category, color: Colors.green),
                  title: const Text('Categories'),
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => CategoryPage()),
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.settings, color: Colors.green),
                  title: const Text('Settings'),
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                ),
                Divider(color: Colors.grey[300]),
                ListTile(
                  leading: const Icon(Icons.logout, color: Colors.red),
                  title: const Text('Log Out'),
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.pushReplacementNamed(context, '/signin');
                  },
                ),
              ],
            ),
          ),
        ),
        body: Container(
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

        child:Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              // Search Bar
              TextField(
                onChanged: filterProductsBySearch,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search, color: Colors.green),
                  hintText: 'Search local farm products',
                  hintStyle: TextStyle(color: Colors.grey[400]),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(color: Colors.lightGreenAccent)
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(color: Colors.green),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.all(12),
                ),
              ),
              const SizedBox(height: 20),

              // Categories Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Categories',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Navigate to full Categories page
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => CategoryPage()),
                      );
                    },
                    child: const Text(
                      'See All',
                      style: TextStyle(color: Colors.green, fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
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
                        margin: const EdgeInsets.only(right: 10),
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
                                width: 100,
                                height: 80,
                                decoration: BoxDecoration(
                                  color: selectedCategory== categories[index]['name']? Colors.green: Colors.white,
                                  borderRadius: BorderRadius.circular(12.0),
                                  image: DecorationImage(
                                    image: AssetImage(categories[index]['image']!),
                                    fit: BoxFit.cover,
                                ),
                              ),
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              categories[index]['name']!,
                              style: TextStyle(
                                fontSize: 16,
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
              const SizedBox(height: 16),

              // All Products Heading
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'All Products',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ),



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
                        margin: const EdgeInsets.symmetric(vertical: 8),
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
                                  decoration: const BoxDecoration(
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
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            'Price: \$${product['price']} per ${product['quantity'].split(" ")[1]}',
                                            style: const TextStyle(fontSize: 14),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 10),
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
                                icon: const Icon(Icons.add, size: 30),
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
                                      duration: const Duration(seconds: 1),
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
        ),),

    bottomNavigationBar: BottomNavigationBar(
        items: const [
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
