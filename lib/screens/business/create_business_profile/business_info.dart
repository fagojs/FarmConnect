
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
        title: Text('FarmConnect',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),
        centerTitle: true,
        backgroundColor: Colors.green,
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.menu,color: Colors.white,),
            onPressed: () {
              Scaffold.of(context).openDrawer();
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
              DrawerHeader(
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
                leading: Icon(Icons.business, color: Colors.green),
                title: Text('Create Business Profile'),
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: Icon(Icons.settings, color: Colors.green),
                title: Text('Settings'),
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
              Divider(color: Colors.grey[300]),
              ListTile(
                leading: Icon(Icons.logout, color: Colors.red),
                title: Text('Log Out'),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.pushReplacementNamed(context, '/signin');
                },
              ),
            ],
          ),
        ),
      ),
      body: Container(
    decoration: const BoxDecoration(
    gradient: LinearGradient(
    colors: [
    Color(0xFFd4fc79),
    Color(0xFF96e6a1),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    ),
    ),

      child:ListView(
        padding: EdgeInsets.all(24.0),
        children: <Widget>[
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            color: Colors.white,
            child: Padding(
              padding: EdgeInsets.all(24.0),
              child: Column(
                children: [
                  Text('Create a Business Profile',
                    style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold,color: Colors.blue[900]
                    ),
                  ),
                  SizedBox(height: 10,),

                  SizedBox(height: 10,),
                  GestureDetector(
                    onTap: () => _showImageSourceActionSheet(context),
                    child: businessLogo == null
                        ? Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        color: Colors.blue[400],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(Icons.add_a_photo, size: 40),
                            SizedBox(height: 10),
                            Text(
                              'Add logo of your business here (optional)',
                              style: TextStyle(color: Colors.white70),
                              textAlign: TextAlign.center,
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
                          image: FileImage(businessLogo!),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),

                ],
              ),
            ),
          ),
          SizedBox(height: 8,),
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            color: Colors.white,
            child: Padding(padding: EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    Text(
                      'Enter your business details below.', style: TextStyle(
                        fontSize: 16,fontWeight: FontWeight.w500
                    ),
                    ),
                    SizedBox(height: 20),
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Business Name',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      ),
                      onChanged: (value) => businessName = value,
                    ),
                    SizedBox(height: 10),
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Business Address',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),

                        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      ),
                      onChanged: (value) => businessAddress = value,
                    ),
                    SizedBox(height: 10),
                    TextField(
                      maxLines: 4,
                      decoration: InputDecoration(
                        labelText: 'Tell us about a bit about your business.',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),

                        alignLabelWithHint: true,
                        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      ),
                      onChanged: (value) => businessDescription = value,
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: (){
                        _saveProfile();
                      },

                      child: Text('CONTINUE', style: TextStyle(color: Colors.white),),
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(MediaQuery.of(context).size.width * 0.7, 50),
                        backgroundColor: Colors.blue[900],
                        padding:
                        EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                        textStyle: TextStyle(),
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
    ),);
  }
}
