import 'dart:io';

class FarmerProfile {
  String fullName;
  String contactNumber;
  String email;
  String address;
  String farmName;
  String farmAddress;
  String farmDescription;
  File? profileImage;
  File? farmImage;

  FarmerProfile({
    required this.fullName,
    required this.contactNumber,
    required this.email,
    required this.address,
    required this.farmName,
    required this.farmAddress,
    required this.farmDescription,
    this.profileImage,
    this.farmImage,
  });
}
