
class CartState {
  static final CartState _instance = CartState._internal();
  
  factory CartState() {
    return _instance;
  }

  CartState._internal();

  List<Map<String, dynamic>> cartItems = [];

  void addToCart(Map<String, dynamic> product) {
    // Check if the product already exists in the cart and update quantity
    for (var item in cartItems) {
      if (item['name'] == product['name']) {
        item['quantity'] += product['quantity'];
        return;
      }
    }
    // If not in cart, add new product
    cartItems.add(product);
  }

  void clearCart() {
    cartItems.clear();
  }
}

final cartState = CartState();
