import '../models/product_model.dart';

class CurrentUser {
  static final CurrentUser _instance = CurrentUser._internal();
  factory CurrentUser() {
    return _instance;
  }

  String? fullName;
  String? contactNumber;
  String? email;
  String? address;
  String? farmName;
  String? farmAddress;
  String? farmDescription;

  CurrentUser._internal();

  // List of products associated with the current user
  List<Product> products = [];
}

final currentUser = CurrentUser();
