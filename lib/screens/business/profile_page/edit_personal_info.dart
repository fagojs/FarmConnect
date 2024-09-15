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
      backgroundColor: Color(0xFFE0F7FA),
      appBar: AppBar(
        title: Text('Edit Contact Information', style: TextStyle(fontWeight: FontWeight.bold),),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  child: Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      color: Colors.green[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.add_a_photo, size: 40),
                          Text('Add image of you', style: TextStyle(color: Colors.white70),),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    hintText: 'Enter your email address',
                    prefixIcon: const Icon(Icons.email),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: const BorderSide(color: Colors.orange),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  keyboardType: TextInputType.phone,
                  controller: phoneController,
                  decoration: InputDecoration(
                    labelText: 'Phone',
                    hintText: 'Enter your phone number',
                    prefixIcon: const Icon(Icons.phone),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: const BorderSide(color: Colors.orange),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: addressController,
                  decoration: InputDecoration(
                    labelText: 'Address',
                    hintText: 'Enter your address',
                    prefixIcon: const Icon(Icons.location_city_outlined),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: const BorderSide(color: Colors.orange),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                SizedBox(
                  width: 250,
                  child: ElevatedButton(
                    onPressed: () {
                      _updatePersonalInfo();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 50),
                      textStyle: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                    ),
                    child: const Text('Update', style: TextStyle(color: Colors.white),),
                  ),
                ),
              ],
            ),
          ),
        )
    );
  }
}
