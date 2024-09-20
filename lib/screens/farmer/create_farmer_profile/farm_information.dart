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
        const SnackBar(content: Text('All fields are required!')),
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
                leading: const Icon(Icons.photo_library),
                title: const Text('Photo Library'),
                onTap: () {
                  _pickImage(ImageSource.gallery);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text('Camera'),
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
        title: const Text('FarmConnect',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),
        backgroundColor: Colors.green,
        centerTitle: true,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu,color: Colors.white,),
            onPressed: () {
              Scaffold.of(context).openDrawer(); // Opens the drawer
            },
          ),
        ),
      ),
      drawer: Drawer(
        child: Container(
          color: Colors.white,
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.green,
                ),
                child: Center(
                  child: Text(
                    'FarmConnect',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              ListTile(
                leading: const Icon(Icons.home, color: Colors.green),
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
                leading: const Icon(Icons.person, color: Colors.green),
                title: const Text('Create Farmer Profile'),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CreateFarmerPersonalProfile(),
                      )
                  );


                },
              ),
              ListTile(
                leading: const Icon(Icons.settings, color: Colors.green),
                title: const Text('Settings'),
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
              Divider(color: Colors.grey[300]), // Use a lighter gray for the divider
              ListTile(
                leading: const Icon(Icons.logout, color: Colors.red),
                title: const Text('Log Out'),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.pushReplacementNamed(context, '/signin');
                },
              ),
            ],
          ),
        ),
      ),
      body:ListView(
        padding: const EdgeInsets.all(24.0),
        children: <Widget>[
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  const Text('Create a Farmer Profile',
                    style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold,color: Color(0xFF4CAF50)
                    ),
                  ),
                  const SizedBox(height: 10,),

                  const SizedBox(height: 10,),
                  GestureDetector(
                    onTap: () => _showImageSourceActionSheet(context),
                    child: farmImage == null
                        ? Container(
                      width: 200,
                      height: 150,
                      decoration: BoxDecoration(
                        color: Colors.green[300],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.add_a_photo, size: 40, color: Colors.white,),
                            Center( // Center the text
                              child: Text(
                                'Select your farm photo (optional)',
                                textAlign: TextAlign.center,style: TextStyle(color: Colors.white),
                              ),
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
                          image: FileImage(farmImage!),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),


              ],
              ),
            ),
          ),
          const SizedBox(height: 8,),
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            color: Colors.white,
            child: Padding(padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    const Text(
                      'Enter your Farms details below.', style: TextStyle(
                        fontSize: 16,fontWeight: FontWeight.w500
                    ),
                    ),
                    const SizedBox(height: 20),
                            TextField(
                              decoration: InputDecoration(
                                labelText: 'Farm Name',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                              ),
                              onChanged: (value) => farmName = value,
                            ),
                            const SizedBox(height: 10),
                            TextField(
                              decoration: InputDecoration(
                                labelText: 'Farm Address',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),

                                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                              ),
                              onChanged: (value) => farmAddress = value,
                            ),
                            const SizedBox(height: 10),
                            TextField(
                              maxLines: 4,
                              decoration: InputDecoration(
                                labelText: 'Tell us about a bit about your farm.',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),

                                alignLabelWithHint: true,
                                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                              ),
                              onChanged: (value) => farmDescription = value,
                            ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: (){
                        _saveProfile();
                      },

                      child: const Text('CONTINUE', style: TextStyle(color: Colors.white),),
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(MediaQuery.of(context).size.width * 0.7, 50),
                        backgroundColor: const Color(0xFF4CAF50),
                        padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                        // textStyle: const TextStyle(fontSize: 18),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                      ),
                    ),
                  ],
                )
            ),
          )
        ],
      ),
    );
  }
}
