import 'package:flutter/material.dart';

import '../home_page.dart';
import '../cart_page.dart';
import '../profile_page/profile_page.dart';
import './category_details.dart';

class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  final TextEditingController _searchController = TextEditingController();
  List<String> categories = ['Vegetable', 'Fruit', 'Dairy', 'Grain', 'Meat'];
  List<String> filteredCategories = [];
  
  @override
  void initState() {
    super.initState();
    filteredCategories = categories; // Initially show all categories
  }

  void _filterCategories(String query) {
    setState(() {
      filteredCategories = categories.where((category) {
        return category.toLowerCase().contains(query.toLowerCase());
      }).toList();
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
              Scaffold.of(context).openDrawer();
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
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.pushNamed(context, '/home');
              },
            ),
            ListTile(
              leading: Icon(Icons.shopping_cart),
              title: Text('Cart'),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.pushNamed(context, '/cart');
              },
            ),
            ListTile(
              leading: Icon(Icons.category),
              title: Text('Categories'),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.pushNamed(context, '/settings');
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Log Out'),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.pushReplacementNamed(context, '/signin');
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              onChanged: _filterCategories,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Search category type',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
         Expanded(
            child: ListView.builder(
              itemCount: filteredCategories.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            CategorySpecificPage(category: filteredCategories[index]),
                      ),
                    );
                  },
                  child: Card(
                    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Padding(
                      padding: EdgeInsets.all(16.0), // Add padding for more space
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Text content on the left
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  filteredCategories[index],
                                  style: TextStyle(
                                      fontSize: 18, fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 8), // Space between title and subtitle
                                Text(
                                  'Discover fresh and locally produced ${filteredCategories[index].toLowerCase()}.',
                                  style: TextStyle(fontSize: 14),
                                ),
                              ],
                            ),
                          ),
                          // Image on the right
                          SizedBox(width: 16), // Add spacing between text and image
                          Container(
                            width: 120, // Adjust size of the image
                            height: 120, // Make the image a square
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                image: AssetImage(
                                    'images/placeholder_img.png'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.category), label: 'Categories'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Cart'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.black,
        currentIndex: 1, // This keeps the Cart page active
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
