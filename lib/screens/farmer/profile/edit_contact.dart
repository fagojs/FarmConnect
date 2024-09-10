import 'package:flutter/material.dart';
import 'dart:io'; // For using File
import 'package:image_picker/image_picker.dart'; // For picking images

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

  void _updateContactInfo(){
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
        title: Text('Edit Your Farmer Profile'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
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
                      : AssetImage('images/placeholder_img.png') as ImageProvider,
                      child: Icon(Icons.camera_alt, size: 30, color: Colors.white),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Name'),
              ),
              SizedBox(height: 10),
              TextField(
                controller: phoneController,
                decoration: InputDecoration(labelText: 'Phone'),
              ),
              SizedBox(height: 10),
              TextField(
                controller: emailController,
                decoration: InputDecoration(labelText: 'Email'),
              ),
              SizedBox(height: 20),
              TextField(
                controller: addressController,
                decoration: InputDecoration(labelText: 'Address'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  _updateContactInfo();
                },
                child: Text('Update'),
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
          title: Text('Select Image Source'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _pickImage(ImageSource.camera);
              },
              child: Text('Camera'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _pickImage(ImageSource.gallery);
              },
              child: Text('Gallery'),
            ),
          ],
        );
      },
    );
  }
}
