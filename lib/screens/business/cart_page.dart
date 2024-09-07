import 'package:flutter/material.dart';

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
            icon: Icon(Icons.delete),
            onPressed: deleteCart,
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

      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.category), label: 'Categories'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Cart'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }

  Widget buildCurrentOrders() {
    return cartItems.isEmpty
        ? buildEmptyCart()
        : ListView.builder(
            itemCount: cartItems.length,
            itemBuilder: (context, index) {
              return Card(
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
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
              );
            },
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
              Navigator.pushReplacementNamed(context, '/home');
            },
            child: Text('Add to Cart'),
          ),
        ],
      ),
    );
  }

  // Build the Order History Section
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          title: Text(
                              "Code ${orderHistory[index]["code"]} - ${orderHistory[index]["status"]}"),
                          subtitle: Text(orderHistory[index]["date"]),
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
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text("Address: ${orderHistory[index]["address"]}"),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text("Total: \$${orderHistory[index]["total"]}"),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                deleteOrderHistory(); // Correct function to delete order history
              },
            ),
          ],
        );
}
Widget buildEmptyOrderHistory() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.remove_red_eye, size: 100, color: Colors.grey),
          Text(
            'Order History Deleted!!',
            style: TextStyle(fontSize: 24),
          ),
          Text('Browse for local farm products and fill your cart'),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Navigate back to home to add items to cart
              Navigator.pushReplacementNamed(context, '/home');
            },
            child: Text('Add to Cart'),
          ),
        ],
      ),
    );
  }

}
