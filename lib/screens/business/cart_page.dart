import 'package:flutter/material.dart';

import './category_page.dart';
import 'home_page.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<Map<String, dynamic>> cartItems = [
    {"name": "Tomatoes", "price": 3.0, "quantity": 5},
    {"name": "Tomatoes", "price": 3.0, "quantity": 5},
    {"name": "Tomatoes", "price": 3.0, "quantity": 5},
    {"name": "Tomatoes", "price": 3.0, "quantity": 5},
  ];

  List<Map<String, dynamic>> orderHistory = [
    {
      "code": "#2323",
      "date": "Feb 16, 2024",
      "status": "Delivered",
      "products": [
        {"name": "Tomatoes", "quantity": 5, "price": 15.0},
        {"name": "Tomatoes", "quantity": 5, "price": 15.0},
        {"name": "Tomatoes", "quantity": 5, "price": 15.0}
      ],
      "address": "Sydney, Australia",
      "total": 45.0
    },
    {
      "code": "#2323",
      "date": "Feb 16, 2024",
      "status": "Shipped",
      "products": [
        {"name": "Tomatoes", "quantity": 5, "price": 15.0},
        {"name": "Tomatoes", "quantity": 5, "price": 15.0},
        {"name": "Tomatoes", "quantity": 5, "price": 15.0}
      ],
      "address": "Sydney, Australia",
      "total": 45.0
    }
  ];

  void incrementQuantity(int index) {
    setState(() {
      cartItems[index]["quantity"]++;
    });
  }

  void decrementQuantity(int index) {
    setState(() {
      if (cartItems[index]["quantity"] > 1) {
        cartItems[index]["quantity"]--;
      }
    });
  }

  double getTotal() {
    double total = 0.0;
    for (var item in cartItems) {
      total += item["price"] * item["quantity"];
    }
    return total;
  }

  void deleteCart() {
    setState(() {
      cartItems.clear();
    });
  }

  void deleteOrderHistory() {
    setState(() {
      orderHistory.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CART'),
        actions: [
          IconButton(
            icon: Icon(Icons.language),
            onPressed: (){},
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
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
              },
            ),
            ListTile(
              leading: Icon(Icons.shopping_cart),
              title: Text('Cart'),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Log Out'),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/signin');
              },
            ),
          ],
        ),
      ),
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            TabBar(
              tabs: [
                Tab(text: 'Current Orders'),
                Tab(text: 'Order History'),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  buildCurrentOrders(),
                  buildOrderHistory(),
                ],
              ),
            ),
          ],
        ),
      ),

      // Adding Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.category), label: 'Categories'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Cart'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.black,
        currentIndex: 2, // This keeps the Cart page active
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
              // Navigator.pushReplacement(
              //     context,
              //     MaterialPageRoute(builder: (context) => ProfilePage()),
              //   );
              break;
          }
        },
      ),

    );
  }

 // Building the Current Orders section with delete icon for each product
Widget buildCurrentOrders() {
  return cartItems.isEmpty
      ? buildEmptyCart()
      : Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: cartItems.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: Row(
                      children: [
                        // Product Information
                        Expanded(
                          child: ListTile(
                            leading: Container(
                              width: 50,
                              height: 50,
                              color: Colors.grey[300],
                            ),
                            title: Text(cartItems[index]["name"]),
                            subtitle: Text("\$${cartItems[index]["price"]}/kg"),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: Icon(Icons.remove),
                                  onPressed: () => decrementQuantity(index),
                                ),
                                Text(cartItems[index]["quantity"].toString()),
                                IconButton(
                                  icon: Icon(Icons.add),
                                  onPressed: () => incrementQuantity(index),
                                ),
                              ],
                            ),
                          ),
                        ),
                        // Delete Icon
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            // Remove specific product and show snackbar
                            setState(() {
                              cartItems.removeAt(index);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Product removed from cart'),
                                  duration: Duration(seconds: 2),
                                  behavior: SnackBarBehavior.floating,
                                ),
                              );
                            });
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            // Total and Checkout Button
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Builder(
                builder: (BuildContext context) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total: \$${getTotal().toStringAsFixed(2)}',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // Navigate to Checkout Page
                          Navigator.pushNamed(context, '/checkout');
                        },
                        child: Row(
                          children: [
                            Text('Checkout'),
                            Icon(Icons.arrow_forward),
                          ],
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        );
}


  Widget buildEmptyCart() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.remove_shopping_cart, size: 100, color: Colors.grey),
          Text(
            'Your Cart is Deleted!!',
            style: TextStyle(fontSize: 24),
          ),
          Text('Browse for local farm products and fill your cart'),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Navigate back to home to add items to cart
             Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => BusinessOwnerHomePage()),
                );
            },
            child: Text('Add to Cart'),
          ),
        ],
      ),
    );
  }

  // Building the Order History section with delete icon
Widget buildOrderHistory() {
  return orderHistory.isEmpty
      ? buildEmptyOrderHistory()
      : Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: orderHistory.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ListTile(
                                title: Text("Code ${orderHistory[index]["code"]}"),
                                subtitle: Text(orderHistory[index]["status"]),
                              ),
                              ...orderHistory[index]["products"].map<Widget>((product) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 16),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("${product["name"]}"),
                                      Text("${product["quantity"]} kg"),
                                      Text("\$${product["price"]}"),
                                    ],
                                  ),
                                );
                              }).toList(),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(Icons.location_on),
                                        SizedBox(width: 8),
                                        Text(orderHistory[index]["address"]),
                                      ],
                                    ),
                                    // Delete Icon next to address
                                    IconButton(
                                      icon: Icon(Icons.delete, color: Colors.red),
                                      onPressed: () {
                                        // Remove specific order and show snackbar
                                        setState(() {
                                          orderHistory.removeAt(index);
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(
                                              content: Text('Order removed from history'),
                                              duration: Duration(seconds: 2),
                                            ),
                                          );
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Delete Icon for Order History
                        
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        );
}

Widget buildEmptyOrderHistory() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.remove_red_eye_outlined, size: 100, color: Colors.grey),
          Text(
            'Order History Deleted!!',
            style: TextStyle(fontSize: 24),
          ),
          Text('Browse for local farm products and fill your cart'),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Navigate back to home to add items to cart
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => BusinessOwnerHomePage()),
              );
            },
            child: Text('Add to Cart'),
          ),
        ],
      ),
    );
  }

}
