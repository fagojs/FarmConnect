import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'personal.dart';
import 'list_first_product.dart';

class FarmInformationPage extends StatefulWidget {
  @override
  _FarmInformationPageState createState() => _FarmInformationPageState();
}

class _FarmInformationPageState extends State<FarmInformationPage> {
  File? _image;
  final ImagePicker _picker = ImagePicker();

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
                child: _image == null
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
                              Text('Select your photo'),
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
                            image: FileImage(_image!),
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
              ),
              SizedBox(height: 10),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Farm Address',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                maxLines: 4,
                decoration: InputDecoration(
                  labelText: 'Tell us about a bit about your farm. One or maybe two unique things about it.',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Navigate to the next form (to be implemented)
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ListFirstProductPage(), // Replace with your next form screen
                    ),
                  );
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
