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
      appBar: AppBar(
        title: const Text('Edit Your Farmer Profile'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Display Selected Image or Placeholder
              GestureDetector(
                onTap: () => _showImageSourceDialog(),
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: _selectedImage != null
                      ? FileImage(_selectedImage!)
                      : const AssetImage('images/placeholder_img.png') as ImageProvider,
                      child: const Icon(Icons.camera_alt, size: 30, color: Colors.white),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Name'),
              ),
              const SizedBox(height: 10),
              TextField(
                keyboardType: TextInputType.phone,
                controller: phoneController,
                decoration: const InputDecoration(labelText: 'Phone'),
              ),
              const SizedBox(height: 10),
              TextField(
                keyboardType: TextInputType.emailAddress,
                controller: emailController,
                decoration: const InputDecoration(labelText: 'Email'),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: addressController,
                decoration: const InputDecoration(labelText: 'Address'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  _updateContactInfo();
                },
                child: const Text('Update'),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
              ),
            ],
          ),
        ),
      ),
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
