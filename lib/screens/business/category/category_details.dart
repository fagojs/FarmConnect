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

  const CategorySpecificPage({Key? key, required this.category}) : super(key: key);

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
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        title: Text(
          '${widget.category} Products',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,

        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Go back to the category page
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Search Bar
            TextField(
              controller: _searchController,
              onChanged: _filterProducts,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search, color: Colors.green),
                hintText: 'Search ${widget.category} products',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                contentPadding: EdgeInsets.all(16),
              ),
            ),
            SizedBox(height: 20),

            // Product List
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
                      margin: EdgeInsets.symmetric(vertical: 8.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      elevation: 4,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // Product Image
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(
                                'images/placeholder_img.png',
                                height: 100,
                                width: 100,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(width: 16),

                            // Product Info
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [

                                      Text(
                                        product['name'],
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.blue[900],
                                        ),
                                      ),

                                      Text(
                                        product['quantity'].contains('kg')
                                            ? '\$${product['price']} per kg'
                                            : '\$${product['price']} per litre',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.blue[700],
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 8),

                                  // Product Description
                                  Text(
                                    product['description'],
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey[700],
                                    ),
                                  ),
                                  SizedBox(height: 10),

                                  // Add to Cart Button
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        // Add to cart logic
                                        String unit = product['quantity'].contains('kg') ? 'kg' : 'litre';
                                        cartState.addToCart({
                                          "name": product['name'],
                                          "price": double.parse(product['price']),
                                          "quantity": 1,
                                          "unit": unit,
                                        });
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                            content: Text('${product['name']} added to cart!'),
                                            duration: Duration(seconds: 2),
                                          ),
                                        );
                                      },
                                      style: ElevatedButton.styleFrom(
                                        foregroundColor: Colors.white,
                                        backgroundColor: Colors.green, // White text
                                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(4),
                                        ),
                                        textStyle: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      child: Text('Add to Cart'),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
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
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.category), label: 'Categories'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Cart'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        selectedItemColor: Colors.green,
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
