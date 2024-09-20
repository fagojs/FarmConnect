import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import './business_info.dart';
import '../../../data/currentuser.dart';
class BusinessPersonalInfoPage extends StatefulWidget {
  @override
  _BusinessPersonalInfoPageState createState() => _BusinessPersonalInfoPageState();
}

class _BusinessPersonalInfoPageState extends State<BusinessPersonalInfoPage> {
  File? _image;
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
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
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

    // Function to navigate to business info form
  void _goToBusinessInfo() {
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

    // Navigate to the next form
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BusinessInfoPage(
          fullName: fullName,
          contactNumber: contactNumber,
          email: email,
          address: address,
          profileImage: profileImage,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text('FarmConnect', style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),
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
                  Text('Create a Farmer Profile',
                    style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold,color: Colors.blue[900]
                    ),
                  ),
                  SizedBox(height: 10,),

                  SizedBox(height: 10,),
                  GestureDetector(
                    onTap: () => _showImageSourceActionSheet(context),
                    child: profileImage == null
                        ? Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        color: Colors.blue[400],
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
                              'Select your photo (optional)', textAlign: TextAlign.center,style: TextStyle(color:Colors.white70),
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
                      'Enter your details below.', style: TextStyle(
                        fontSize: 16,fontWeight: FontWeight.w500
                    ),
                    ),
                    SizedBox(height: 16,),
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Full Name',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0)
                        ),
                        contentPadding: EdgeInsets.symmetric(horizontal: 16,vertical: 12),
                      ),
                      onChanged: (value) => fullName = value,
                    ),
                    SizedBox(height: 10),
                    TextField(
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        labelText: 'Contact Number',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0)

                        ),
                        contentPadding: EdgeInsets.symmetric(horizontal: 16,vertical: 12),
                      ),
                      onChanged: (value) => contactNumber = value,
                    ),
                    SizedBox(height: 10),
                    TextField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          labelText: 'Email',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          contentPadding: EdgeInsets.symmetric(horizontal: 16,vertical: 12)
                      ),
                      onChanged: (value) => email = value,
                    ),
                    SizedBox(height: 10),
                    TextField(
                      decoration: InputDecoration(
                          labelText: 'Address',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0)
                          ),
                          contentPadding: EdgeInsets.symmetric(horizontal: 16,vertical: 12)
                      ),
                      onChanged: (value) => address = value,
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: (){
                        _goToBusinessInfo();
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
      ),
    );
  }
}
