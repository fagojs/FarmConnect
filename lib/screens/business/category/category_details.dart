import 'package:farm_connect/screens/business/category/category_page.dart';
import 'package:flutter/material.dart';

import '../home_page.dart';
import '../profile_page/profile_page.dart';
import '../cart_page.dart';
import '../product_details.dart';
import '../../../data/all_products.dart'; // Import dummy products
import "../../../data/cart_state.dart";

class CategorySpecificPage extends StatefulWidget {
  final String category;

  const CategorySpecificPage({Key? key, required this.category})
      : super(key: key);

  @override
  _CategorySpecificPageState createState() => _CategorySpecificPageState();
}

class _CategorySpecificPageState extends State<CategorySpecificPage> {
  List<Map<String, dynamic>> filteredProducts = [];
  List<Map<String, dynamic>> displayedProducts = [];

  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Filter products based on the selected category
    if (widget.category == 'All') {
      filteredProducts = allListedProducts; // Show all products if category is 'All'
    } else {
      filteredProducts = allListedProducts
          .where((product) => product['category'] == widget.category)
          .toList();
    }
    displayedProducts = filteredProducts; // Initially show all filtered products
  }

  void _filterProducts(String query) {
    setState(() {
      displayedProducts = filteredProducts.where((product) {
        return product['name'].toLowerCase().contains(query.toLowerCase());
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.category} Products'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Go back to the category page
          },
        ),
      ),
      body: Column(
        children: [
          // Search Bar for filtering products
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              onChanged: _filterProducts,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Search ${widget.category} products',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: displayedProducts.length,
              itemBuilder: (context, index) {
                final product = displayedProducts[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductDetailsPage(
                          productName: product['name'],
                          quantity: product['quantity'],
                          price: product['price'],
                          description: product['description'],
                        ),
                      ),
                    );
                  },
                  child: Card(
                    margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          // Product Image on Top
                          Container(
                            height: 150,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                image: AssetImage('images/placeholder_img.png'), // Use product image
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(height: 10),

                          

                          // Price and Product Name
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                              product['name'],
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              if(product['quantity'].split(" ")[1] == "kg")
                                Text(
                                  '\$${product['price']} per kg', // Price
                                  style: TextStyle(fontSize: 14),
                                )
                              else
                                Text(
                                  '\$${product['price']} per litre', // Price
                                  style: TextStyle(fontSize: 14),
                                )
                            ],
                          ),
                          SizedBox(height: 10),

                          // Add to Cart Button
                          ElevatedButton(
                            onPressed: () {
                              // Add to cart logic
                              String unit = "";
                              if(product['quantity'].split(" ")[1] == "kg"){
                                unit = "kg";
                              }else{
                                unit ="litre";
                              }
                              cartState.addToCart({
                                "name": product['name'],
                                "price": double.parse(product['price']),
                                "quantity": 1,
                                "unit": unit,
                              });
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('${product['name']} added to cart!')),
                              );
                            },
                            child: Text('Add to cart'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.orange, // Change as per your color theme
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
        currentIndex: 1,
        onTap: (int index) {
          switch (index) {
            case 0:
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => BusinessOwnerHomePage()));
              break;
            case 1:
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => CategoryPage()));
              break;
            case 2:
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => CartPage()));
              break;
            case 3:
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => BusinessProfilePage()));
              break;
          }
        },
      ),
    );
  }
}
