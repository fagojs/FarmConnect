import 'dart:io';

class BusinessProfile {
  String fullName;
  String contactNumber;
  String email;
  String address;
  String businessName;
  String businessAddress;
  String businessDescription;
  File? profileImage;
  File? businessLogo;

  BusinessProfile({
    required this.fullName,
    required this.contactNumber,
    required this.email,
    required this.address,
    required this.businessName,
    required this.businessAddress,
    required this.businessDescription,
    this.profileImage,
    this.businessLogo,
  });
}
