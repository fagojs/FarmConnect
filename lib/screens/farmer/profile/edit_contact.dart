import 'package:flutter/material.dart';
import 'dart:io'; // For using File
import 'package:image_picker/image_picker.dart'; // For picking images
import 'package:email_validator/email_validator.dart';

import '../../../data/currentuser.dart';

class EditContactInfoPage extends StatefulWidget {
  @override
  _EditContactInfoPageState createState() => _EditContactInfoPageState();
}

class _EditContactInfoPageState extends State<EditContactInfoPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
   // Initialize the controllers with current user data
    nameController.text = currentUser.fullName ?? '';
    addressController.text = currentUser.address ?? '';
    phoneController.text = currentUser.contactNumber ?? '';
    emailController.text = currentUser.email ?? '';
  }

  final ImagePicker _picker = ImagePicker();
  File? _selectedImage;

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  // Email validation regex
  bool isValidEmail(String email) {
    return EmailValidator.validate(email); // Using package to validate email
  }

  // Contact number validation: Ensures it's exactly 10 digits
  bool isValidContactNumber(String contactNumber) {
    final RegExp contactNumberRegEx = RegExp(r'^\d{10}$');
    return contactNumberRegEx.hasMatch(contactNumber);
  }

  void _updateContactInfo(){

    // Check if any field is empty
    if (emailController.text.isEmpty || nameController.text.isEmpty || phoneController.text.isEmpty || addressController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('All fields are required!')),
      );
      return;
    }

     // Validate contact number
    if (!isValidContactNumber(phoneController.text)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter a valid 10-digit contact number')),
      );
      return;
    }

    // Validate email format
    if (!isValidEmail(emailController.text)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter a valid email address')),
      );
      return;
    }

   
    setState(() {
      currentUser.fullName = nameController.text;
      currentUser.contactNumber = phoneController.text;
      currentUser.email = emailController.text;
      currentUser.address = addressController.text;
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE0F7FA),
      appBar: AppBar(
        title: const Text('Edit Your Farmer Profile',style: TextStyle(fontWeight: FontWeight.bold),),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () => _showImageSourceDialog(),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.green,
                            width: 3.0,
                          ),
                        ),
                        child: CircleAvatar(
                          radius: 70,
                          backgroundImage: _selectedImage != null
                              ? FileImage(_selectedImage!)
                              : const AssetImage('images/placeholder_img.png'),
                        ),
                      ),
                      const Icon(Icons.camera_alt, size: 50, color: Colors.white),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: 'Name',
                    hintText: 'Enter your name',
                    prefixIcon: const Icon(Icons.person),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: const BorderSide(color: Colors.orange), // Orange border
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  keyboardType: TextInputType.phone,
                  controller: phoneController,
                  decoration: InputDecoration(
                    labelText: 'Phone',
                    hintText: 'Enter your phone number',
                    prefixIcon: const Icon(Icons.phone),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: const BorderSide(color: Colors.orange),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    hintText: 'Enter your email address',
                    prefixIcon: const Icon(Icons.email),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: const BorderSide(color: Colors.orange),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: addressController,
                  decoration: InputDecoration(
                    labelText: 'Address',
                    hintText: 'Enter your address',
                    prefixIcon: const Icon(Icons.location_city_outlined),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: const BorderSide(color: Colors.orange),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                SizedBox(
                  width: 250,
                  child: ElevatedButton(
                    onPressed: () {
                      _updateContactInfo();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 50),
                      textStyle: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                    ),
                    child: const Text('Update', style: TextStyle(color: Colors.white),),
                  ),
                ),
              ],
            ),
          ),
        )

    );
  }

  // Show Dialog to Choose Image Source (Gallery or Camera)
  void _showImageSourceDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Select Image Source'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _pickImage(ImageSource.camera);
              },
              child: const Text('Camera'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _pickImage(ImageSource.gallery);
              },
              child: const Text('Gallery'),
            ),
          ],
        );
      },
    );
  }
}
