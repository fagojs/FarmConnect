import '../models/product_model.dart';

class CurrentUser {
  static final CurrentUser _instance = CurrentUser._internal();
  factory CurrentUser() {
    return _instance;
  }
  //common fields
  String? fullName;
  String? contactNumber;
  String? email;
  String? address;

  // Farmer-Specific Fields
  String? farmName;
  String? farmAddress;
  String? farmDescription;

  // Business Owner-Specific Fields
  String? businessName;
  String? businessAddress;
  String? businessDescription;

  CurrentUser._internal();

  // List of products associated with the current user
  List<Product> products = [];
}

final currentUser = CurrentUser();
