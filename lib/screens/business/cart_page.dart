import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import './category/category_page.dart';
import './home_page.dart';
import './profile_page/profile_page.dart';
import '../../data/cart_state.dart';
import '../../data/order_history.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {

  // Use cartState for cartItems
  void incrementQuantity(int index) {
    setState(() {
      cartState.cartItems[index]["quantity"]++;
    });
  }

  void decrementQuantity(int index) {
    setState(() {
      if (cartState.cartItems[index]["quantity"] > 1) {
        cartState.cartItems[index]["quantity"]--;
      }
    });
  }

  double getTotal() {
    double total = 0.0;
    for (var item in cartState.cartItems) {
      total += item["price"] * item["quantity"];
    }
    return total;
  }

  void deleteCart() {
    setState(() {
      cartState.clearCart();
    });
  }

  void deleteOrderHistory() {
    setState(() {
      orderHistoryState.clearOrderHistory();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        title: const Text('CART', style: TextStyle(fontWeight: FontWeight.bold),),
        centerTitle: true,
      ),drawer: Drawer(
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
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            const TabBar(
              labelColor: Colors.green,
              unselectedLabelColor: Colors.black,
              indicatorColor: Colors.green,
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
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.category), label: 'Categories'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Cart'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        selectedItemColor: Colors.green,
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


  Widget buildCurrentOrders() {
    return cartState.cartItems.isEmpty
        ? buildEmptyCart()
        : Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: cartState.cartItems.length,
            itemBuilder: (context, index) {
              return Card(
                elevation: 4,
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
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
                        title: Text(cartState.cartItems[index]["name"]),
                        subtitle: Text("\$${cartState.cartItems[index]["price"]}/${cartState.cartItems[index]['unit']}"),

                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.remove),
                              onPressed: () => decrementQuantity(index),
                            ),
                            Text('${cartState.cartItems[index]["quantity"].toString()} ${cartState.cartItems[index]['unit']}'),
                            IconButton(
                              icon: const Icon(Icons.add),
                              onPressed: () => incrementQuantity(index),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Delete Icon
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        // Remove specific product and show snackbar
                        setState(() {
                          cartState.cartItems.removeAt(index);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('${cartState.cartItems[index]['name']} removed from cart'),
                              duration: const Duration(seconds: 1),
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
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Simulate checkout
                      DateTime now = DateTime.now();
                      String formattedDate = DateFormat('MMMM dd, yyyy').format(now);
                      Map<String, dynamic> newOrder = {
                        "code": "#${orderHistoryState.orderHistory.length + 1}",
                        "date": formattedDate,
                        "status": "Shipped",
                        "products": List.from(cartState.cartItems),
                        "address": "Sydney, Australia",
                        "total": getTotal(),
                      };
                      orderHistoryState.addOrder(newOrder);
                      cartState.clearCart();
                      setState(() {});
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Order placed successfully!')),
                      );
                    },
                    child: const Row(
                      children: [
                        Text('Checkout', style: TextStyle(color: Colors.white),),
                        SizedBox(width: 8,),
                        // Icon(Icons.arrow_forward, color: Colors.white,),
                      ],
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 32),
                      textStyle: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
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
          const Icon(Icons.remove_shopping_cart, size: 48, color: Colors.green),
          const Text(
            'Your Cart is Empty!!',
            style: TextStyle(fontSize: 24),
          ),
          const Text('Browse for local farm products and fill your cart'),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Navigate back to home to add items to cart
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => BusinessOwnerHomePage()),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 32),
              textStyle: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0),
              ),
            ),
            child: const Text('Add to Cart', style: TextStyle(color: Colors.white),),
          ),
        ],
      ),
    );
  }

  // Building the Order History section with delete icon
  Widget buildOrderHistory() {
    return orderHistoryState.orderHistory.isEmpty
        ? buildEmptyOrderHistory()
        : Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount:orderHistoryState.orderHistory.length,
            itemBuilder: (context, index) {
              final order = orderHistoryState.orderHistory[index];
              return Card(
                elevation: 4,
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                              title: Text("Order Code: ${order['code']}\nDate: ${order['date']}"),
                              subtitle: Text("Status: ${order['status']}", style: const TextStyle(color: Colors.green),)
                          ),
                          const Divider(),
                          // Loop through products and display each in a table row
                          Column(
                            children: order['products'].map<Widget>((product) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Text(product['name']), // Product name
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Text(
                                        "${product['quantity']} ${product['unit']}",
                                        textAlign: TextAlign.center, // Align quantity in the center
                                      ), // Product quantity
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Text(
                                        "\$${product['price']}/${product['unit']}",
                                        textAlign: TextAlign.center, // Align quantity in the center
                                      ), // Product quantity
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Text(
                                        "\$${(product['price'] * product['quantity']).toStringAsFixed(2)}",
                                        textAlign: TextAlign.right, // Align price to the right
                                      ), // Product price
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                          ),
                          const Divider(thickness: 2.0),
                          // Display the total row under the price column
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Expanded(flex: 2, child: SizedBox()), // Empty space for alignment under Quantity
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                    "[Total: \$${order['total'].toStringAsFixed(2)}]",
                                    style: const TextStyle(fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.right, // Align total under Price column
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    const Icon(Icons.location_on, color: Colors.green,),
                                    const SizedBox(width: 8),
                                    Text("Delivery Address: ${order['address']} "),
                                  ],
                                ),
                                // Delete Icon next to address
                                IconButton(
                                  icon: const Icon(Icons.delete, color: Colors.red),
                                  onPressed: () {
                                    setState(() {
                                      orderHistoryState.removeOrder(index);
                                    });
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('Order removed from history'),
                                        duration: Duration(seconds: 1),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
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
          const Icon(Icons.history, size: 48, color: Colors.green),
          const Text(
            'No Order History',
            style: TextStyle(fontSize: 24),
          ),
          const Text('You haven\'t placed any orders yet.'),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Navigate back to home to add items to cart
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => BusinessOwnerHomePage()),
              );
            },style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 32),
            textStyle: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25.0),
            ),
          ),
            child: const Text('Add to Cart', style: TextStyle(color: Colors.white),),
          ),
        ],
      ),
    );
  }

}
