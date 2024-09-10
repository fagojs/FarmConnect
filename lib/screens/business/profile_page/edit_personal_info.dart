import 'package:flutter/material.dart';

import "../../../data/currentuser.dart";

class EditBusinessPersonalProfile extends StatefulWidget {
  @override
  _EditBusinessPersonalProfileState createState() => _EditBusinessPersonalProfileState();
}

class _EditBusinessPersonalProfileState extends State<EditBusinessPersonalProfile> {
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

  
  void _updatePersonalInfo(){
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
        title: Text('Profile'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Navigate back
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Edit Your Business Profile',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text('Update your details below.', style: TextStyle(fontSize: 16)),
            SizedBox(height: 20),
            GestureDetector(
              child: Container(
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
                      Text('Add image of your product'),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email', border: OutlineInputBorder()),
            ),
            SizedBox(height: 20),
            TextField(
              controller: phoneController,
              decoration: InputDecoration(labelText: 'Contact Number', border: OutlineInputBorder()),
            ),
            SizedBox(height: 10),
            TextField(
              controller: addressController,
              decoration: InputDecoration(labelText: 'Location', border: OutlineInputBorder()),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                _updatePersonalInfo();
              },
              child: Text('UPDATE'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
