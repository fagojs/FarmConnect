import 'package:flutter/material.dart';
import './product_details.dart';

class BusinessOwnerHomePage extends StatefulWidget {
  @override
  _BusinessOwnerHomePageState createState() => _BusinessOwnerHomePageState();
}

class _BusinessOwnerHomePageState extends State<BusinessOwnerHomePage> {
  final List<Map<String, String>> categories = [
    {"name": "All", "image": "images/placeholder_img.png"},
    {"name": "Vegetables", "image": "images/placeholder_img.png"},
    {"name": "Dairy", "image": "images/placeholder_img.png"},
    {"name": "Fruits", "image": "images/placeholder_img.png"},
    {"name": "Grains", "image": "images/placeholder_img.png"},
    {"name": "Meat", "image": "images/placeholder_img.png"},
  ];
  String selectedCategory = "All";

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
              },
            ),
            ListTile(
              leading: const Icon(Icons.shopping_cart),
              title: const Text('Cart'),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              leading: const Icon(Icons.category),
              title: const Text('Categories'),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
            Divider(),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Log Out'),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.pushReplacementNamed(context, '/signin');
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            // Search Bar
            TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Search local farm products',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),

            // Categories Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Categories', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                GestureDetector(
                  onTap: () {
                    // Navigate to full Categories page
                  },
                  child: Text('See All', style: TextStyle(color: Colors.blue)),
                ),
              ],
            ),
            SizedBox(height: 10),
            Container(
              height: 150, // Adjusted to fit image and label
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedCategory = categories[index]['name']!;
                      });
                      // Filter products by selected category
                    },
                    child: Container(
                      margin: EdgeInsets.only(right: 10),
                      child: Column(
                        children: [
                          Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            elevation: 3,
                            color: selectedCategory == categories[index]['name']
                                ? Colors.orange // Change color if selected
                                : Colors.white, // Default color if not selected
                            child: Container(
                              width: 100, // Set width to keep a consistent size
                              height: 100, // Set height to keep a consistent size
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(categories[index]['image']!),
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: BorderRadius.circular(8.0),
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
                                  ? Colors.orange // Change text color if selected
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

            // All Products Section with image on top and "+" button larger
            Expanded(
              child: ListView.builder(
                itemCount: 5, // Simulate 5 products
                itemBuilder: (context, index) {
                  return  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductDetailsPage(
                            productName: 'Tomatoes',  // Replace with product data dynamically
                            quantity: 100,            // Replace with product data dynamically
                            price: 3,                 // Replace with product data dynamically
                            description: 'Locally grown with local farm techniques.',  // Replace with product data dynamically
                          ),
                        ),
                      );
                    },
                  child: Card(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    child: Stack(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Product Image on Top
                            Container(
                              height: 150,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.grey[300], // Placeholder for image
                                image: DecorationImage(
                                  image: AssetImage('images/placeholder_img.png'), // Replace with product image
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Tomatoes', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                                  SizedBox(height: 5),
                                  Text('Quantity: 100 kg'),
                                  Text('Price: \$3 per kg'),
                                  Text('Locally grown with local farm techniques'),
                                ],
                              ),
                            ),
                          ],
                        ),
                        // Larger "+" Icon Button Positioned
                        Positioned(
                          top: 10,
                          right: 10,
                          child: IconButton(
                            icon: Icon(Icons.add, size: 30), // Increased size of "+"
                            onPressed: () {
                              // Add to cart logic
                            },
                          ),
                        ),
                      ],
                    ),
                  )
                );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: 0, // Set to 0 to highlight Home
        onTap: (index) {
          // Navigate to respective pages based on selected index
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.category), label: 'Categories'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Cart'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
