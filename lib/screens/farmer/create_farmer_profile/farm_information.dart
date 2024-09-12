import 'package:farm_connect/screens/landing_page.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'personal.dart';
import 'list_first_product.dart';
import '../../../data/dummy_data.dart';
import '../../../models/create_farmer_profile.dart';
import '../../../data/currentuser.dart';

class FarmInformationPage extends StatefulWidget {
  final String fullName;
  final String contactNumber;
  final String email;
  final String address;
  final File? profileImage;

  FarmInformationPage({
    required this.fullName,
    required this.contactNumber,
    required this.email,
    required this.address,
    this.profileImage,
  });

  @override
  _FarmInformationPageState createState() => _FarmInformationPageState();
}

class _FarmInformationPageState extends State<FarmInformationPage> {
    // Store farm info input data
  String farmName = '';
  String farmAddress = '';
  String farmDescription = '';
  File? farmImage;

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);

    setState(() {
      if (pickedFile != null) {
        farmImage = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

    // Function to save profile to in-memory list
  void _saveProfile() {
     // Check if any field is empty
    if (farmName.isEmpty || farmAddress.isEmpty || farmDescription.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('All fields are required!')),
      );
      return;
    }

     // Save farm data from form fields
    currentUser.farmName = farmName;
    currentUser.farmAddress = farmAddress;
    currentUser.farmDescription = farmDescription;

    farmerProfiles.add(FarmerProfile(
      fullName: widget.fullName,
      contactNumber: widget.contactNumber,
      email: widget.email,
      address: widget.address,
      farmName: farmName,
      farmAddress: farmAddress,
      farmDescription: farmDescription,
      profileImage: widget.profileImage,
      farmImage: farmImage,
    ));
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ListFirstProductPage(),
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
                Navigator.pushReplacement(
                  context, 
                  MaterialPageRoute(builder: (context) => LandingPage(userType: 'Farmer')));
              },
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Create Farmer Profile'),
              onTap: () {
                Navigator.of(context).pop(); // Close the drawer
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CreateFarmerPersonalProfile(),
                    )
                );
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
                'Enter your farm details below.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: () => _showImageSourceActionSheet(context),
                child: farmImage == null
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
                              Text('Select your farm photo (optional)', textAlign: TextAlign.center,),
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
                            image: FileImage(farmImage!),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
              ),
              SizedBox(height: 20),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Farm Name',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) => farmName = value,
              ),
              SizedBox(height: 10),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Farm Address',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) => farmAddress = value,
              ),
              SizedBox(height: 10),
              TextField(
                maxLines: 4,
                decoration: InputDecoration(
                  labelText: 'Tell us about a bit about your farm.',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) => farmDescription = value,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed:() {_saveProfile();},
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
