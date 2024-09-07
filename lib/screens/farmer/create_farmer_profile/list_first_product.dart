import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'personal.dart';
import '../home_page.dart';

class ListFirstProductPage extends StatefulWidget {
  @override
  _ListFirstProductPageState createState() => _ListFirstProductPageState();
}

class _ListFirstProductPageState extends State<ListFirstProductPage> {
  File? _image;
  final ImagePicker _picker = ImagePicker();
  String? _selectedCategory;
  final List<String> _categories = ['Vegetable', 'Fruit', 'Dairy', 'Grain', 'Meat'];

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
                'Add details of your first product.',
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
                              Text('Add image of your product'),
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
                  labelText: 'Product Name',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: 'Quantity (in kg)',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: 'Price (per kg)',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'Select a category',
                  border: OutlineInputBorder(),
                ),
                value: _selectedCategory,
                onChanged: (newValue) {
                  setState(() {
                    _selectedCategory = newValue;
                  });
                },
                items: _categories.map((category) {
                  return DropdownMenuItem(
                    child: Text(category),
                    value: category,
                  );
                }).toList(),
              ),
              SizedBox(height: 10),
              TextField(
                maxLines: 4,
                decoration: InputDecoration(
                  labelText: 'Product Description',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Handle save logic and navigate to the next form
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FarmerHomePage(), // Replace with your next form screen
                        ),
                      );
                    },
                    child: Text('SAVE'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange, // background
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Navigate to the next form without saving
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FarmerHomePage(), // Replace with your next form screen
                        ),
                      );
                    },
                    child: Text('SKIP'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange, // background
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
