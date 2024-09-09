import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import '../../../screens/farmer/create_farmer_profile/farm_information.dart';
import '../../../data/currentuser.dart';

class CreateFarmerPersonalProfile extends StatefulWidget {
  @override
  _CreateFarmerPersonalProfileState createState() => _CreateFarmerPersonalProfileState();
}

class _CreateFarmerPersonalProfileState extends State<CreateFarmerPersonalProfile> {
  final ImagePicker _picker = ImagePicker();

  // Store form input data
  String fullName = '';
  String contactNumber = '';
  String email = '';
  String address = '';
  File? profileImage;

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);

    setState(() {
      if (pickedFile != null) {
        profileImage = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

    // Function to navigate to farm info form
  void _goToFarmInfo() {

     // Check if any field is empty
    if (email.isEmpty || fullName.isEmpty || contactNumber.isEmpty || address.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('All fields are required!')),
      );
      return;
    }

     // Save user data from form fields
    currentUser.fullName = fullName;
    currentUser.contactNumber = contactNumber;
    currentUser.email = email;
    currentUser.address = address;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FarmInformationPage(
          fullName: fullName,
          contactNumber: contactNumber,
          email: email,
          address: address,
          profileImage: profileImage,
        ),
      ),
    );
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
              leading: const Icon(Icons.home),
              title: const Text('Welcome'),
              onTap: () {
                Navigator.of(context).pop(); // Close the drawer
                // Navigate to Welcome Screen
              },
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Create Farmer Profile'),
              onTap: () {
                Navigator.of(context).pop(); // Close the drawer
                // Stay on the current screen
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                Navigator.of(context).pop(); // Close the drawer
                // Navigate to Settings Screen
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
                'Create a Farmer Profile',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                'Enter your details below.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: () => _showImageSourceActionSheet(context),
                child: profileImage == null
                    ? Container(
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(10),
                          //image: DecorationImage(image: AssetImage('images/placeholder_img.png'), 
                          //fit:BoxFit.cover),
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.add_a_photo, size: 40),
                              Text(
                                'Select your photo (optional)'
                              ),
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
                            image: FileImage(profileImage!),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
              ),
              SizedBox(height: 20),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Full Name',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) => fullName = value,
              ),
              SizedBox(height: 10),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Contact Number',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) => contactNumber = value,
              ),
              SizedBox(height: 10),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) => email = value,
              ),
              SizedBox(height: 20),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Address',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) => address = value,
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: (){
                  _goToFarmInfo();
                  },
                child: Text('CONTINUE'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange, // background
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
