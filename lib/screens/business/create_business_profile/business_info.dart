
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import '../home_page.dart';
import '../../../data/currentuser.dart';
import '../../../models/create_business_profile.dart';
import '../../../data/dummy_data.dart';

class BusinessInfoPage extends StatefulWidget {
  final String fullName;
  final String contactNumber;
  final String email;
  final String address;
  final File? profileImage;


   BusinessInfoPage({
    required this.fullName,
    required this.contactNumber,
    required this.email,
    required this.address,
    this.profileImage,
  });
  @override
  _BusinessInfoPageState createState() => _BusinessInfoPageState();
}

class _BusinessInfoPageState extends State<BusinessInfoPage> {
  // Store business info input data
  String businessName= '';
  String  businessAddress = '';
  String businessDescription = '';
  File? businessLogo;

  final ImagePicker _picker = ImagePicker();
  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);

    setState(() {
      if (pickedFile != null) {
        businessLogo = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

   // Function to save profile to in-memory list
  void _saveProfile() {
     // Check if any field is empty
    if (businessName.isEmpty || businessAddress.isEmpty || businessDescription.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('All fields are required!')),
      );
      return;
    }

     // Save farm data from form fields
    currentUser.businessName = businessName;
    currentUser.businessAddress = businessAddress;
    currentUser.businessDescription = businessDescription;

    businessProfiles.add(BusinessProfile(
      fullName: widget.fullName,
      contactNumber: widget.contactNumber,
      email: widget.email,
      address: widget.address,
      businessName: businessName,
      businessAddress: businessAddress,
      businessDescription: businessDescription,
      profileImage: widget.profileImage,
      businessLogo: businessLogo,
    ));
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BusinessOwnerHomePage(),
        )
    ); // Go back to profile page or show success message
  }

  void _showImageSourceActionSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('Photo Library'),
                onTap: () {
                  _pickImage(ImageSource.gallery);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_camera),
                title: Text('Camera'),
                onTap: () {
                  _pickImage(ImageSource.camera);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FarmConnect'),
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              Scaffold.of(context).openDrawer(); // Opens the drawer
            },
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
              // User profile logic
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.lightGreenAccent,
              ),
              child: Text(
                'FarmConnect',
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.business),
              title: const Text('Create Business Profile'),
              onTap: () {
                Navigator.of(context).pop(); // Close the drawer
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                Navigator.of(context).pop(); // Navigate to Settings Screen
              },
            ),
            Divider(),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Log Out'),
              onTap: () {
                Navigator.of(context).pop(); // Close the drawer
                Navigator.pushReplacementNamed(context, '/signin');
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Create a Business Profile',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                'Enter your business details below.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: () => _showImageSourceActionSheet(context),
                child: businessLogo == null
                    ? Container(
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.add_a_photo, size: 40),
                              Text('Add logo of your business here (optional)'),
                            ],
                          ),
                        ),
                      )
                    : Container(
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: FileImage(businessLogo!),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
              ),
              SizedBox(height: 20),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Business Name',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) => businessName = value,
              ),
              SizedBox(height: 10),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Business Address',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) => businessAddress = value,
              ),
              SizedBox(height: 10),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Tell us about your business',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) => businessDescription = value,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Handle form submission and move to the next page
                  _saveProfile();
                },
                child: Text('CONTINUE'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange, // background color
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
