import 'package:farm_connect/screens/landing_page.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:email_validator/email_validator.dart';

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
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No photo selected!')),
        );
      }
    });
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

    // Function to navigate to farm info form
  void _goToFarmInfo() {

    // Check if any field is empty
    if (email.isEmpty || fullName.isEmpty || contactNumber.isEmpty || address.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('All fields are required!')),
      );
      return;
    }

    // Validate contact number
    if (!isValidContactNumber(contactNumber)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid 10-digit contact number')),
      );
      return;
    }
    
    // Validate email format
    if (!isValidEmail(email)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid email address')),
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
      backgroundColor: const Color(0xFFE0F7FA),
      appBar: AppBar(

        title: const Text('FarmConnect',style: TextStyle(fontWeight: FontWeight.bold),),
        centerTitle: true,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
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


             },
            ),
                ListTile(
                leading: const Icon(Icons.settings, color: Colors.green),
                title: const Text('Settings'),
                onTap: () {
                Navigator.of(context).pop();
                },
                ),
                Divider(color: Colors.grey[300]),
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
                    child: profileImage == null
                        ? Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        color: Colors.green[300],
                        borderRadius: BorderRadius.circular(10),
                        //image: DecorationImage(image: AssetImage('images/placeholder_img.png'),
                        //fit:BoxFit.cover),
                      ),
                      child: const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.add_a_photo, size: 40, color: Colors.white,),
                            Text(
                              'Select your photo (optional)', textAlign: TextAlign.center,style: TextStyle(color:Colors.white),
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
                    'Enter your details below.', style: TextStyle(
                    fontSize: 16,fontWeight: FontWeight.w500
                  ),
                  ),
                const SizedBox(height: 16,),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Full Name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0)
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16,vertical: 12),
                  ),
                  onChanged: (value) => fullName = value,
                ),
                  const SizedBox(height: 10),
                  TextField(
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      labelText: 'Contact Number',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0)

                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16,vertical: 12),
                    ),
                    onChanged: (value) => contactNumber = value,
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16,vertical: 12)
                    ),
                    onChanged: (value) => email = value,
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Address',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0)
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16,vertical: 12)
                    ),
                    onChanged: (value) => address = value,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: (){
                      _goToFarmInfo();
                    },

                    child: const Text('CONTINUE', style: TextStyle(color: Colors.white),),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4CAF50),
                      padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                      textStyle: const TextStyle(fontSize: 18),
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
      )









      //         SizedBox(height: 20),
      //         TextField(
      //           decoration: InputDecoration(
      //             labelText: 'Full Name',
      //             border: OutlineInputBorder(),
      //           ),
      //           onChanged: (value) => fullName = value,
      //         ),
      //         SizedBox(height: 10),
      //         TextField(
      //           keyboardType: TextInputType.phone,
      //           decoration: InputDecoration(
      //             labelText: 'Contact Number',
      //             border: OutlineInputBorder(),
      //           ),
      //           onChanged: (value) => contactNumber = value,
      //         ),
      //         SizedBox(height: 10),
      //         TextField(
      //           keyboardType: TextInputType.emailAddress,
      //           decoration: InputDecoration(
      //             labelText: 'Email',
      //             border: OutlineInputBorder(),
      //           ),
      //           onChanged: (value) => email = value,
      //         ),
      //         SizedBox(height: 10),
      //         TextField(
      //           decoration: InputDecoration(
      //             labelText: 'Address',
      //             border: OutlineInputBorder(),
      //           ),
      //           onChanged: (value) => address = value,
      //         ),
      //         SizedBox(height: 20),
      //         ElevatedButton(
      //           onPressed: (){
      //             _goToFarmInfo();
      //             },
      //           child: Text('CONTINUE'),
      //           style: ElevatedButton.styleFrom(
      //             backgroundColor: Colors.green, // background
      //           ),
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
    );
  }
}
