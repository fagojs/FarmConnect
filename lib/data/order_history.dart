
class OrderHistoryState {
  static final OrderHistoryState _instance = OrderHistoryState._internal();

  factory OrderHistoryState() {
    return _instance;
  }

  OrderHistoryState._internal();

  List<Map<String, dynamic>> orderHistory = [];

  void addOrder(Map<String, dynamic> order) {
    orderHistory.add(order);
  }

  void removeOrder(int index) {
    orderHistory.removeAt(index);
  }

  void clearOrderHistory() {
    orderHistory.clear();
  }
}

final orderHistoryState = OrderHistoryState();
