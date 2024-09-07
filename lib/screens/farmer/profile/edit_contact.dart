import 'package:flutter/material.dart';
import 'dart:io'; // For using File
import 'package:image_picker/image_picker.dart'; // For picking images

class EditContactInfoPage extends StatefulWidget {
  final Map<String, dynamic> contactInfo;

  EditContactInfoPage({required this.contactInfo});

  @override
  _EditContactInfoPageState createState() => _EditContactInfoPageState();
}

class _EditContactInfoPageState extends State<EditContactInfoPage> {
  late TextEditingController _nameController;
  late TextEditingController _phoneController;
  late TextEditingController _emailController;

  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.contactInfo['name']);
    _phoneController = TextEditingController(text: widget.contactInfo['phone']);
    _emailController = TextEditingController(text: widget.contactInfo['email']);
  }

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Your Farmer Profile'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Display Selected Image or Placeholder
              GestureDetector(
                onTap: () => _showImageSourceDialog(),
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: _selectedImage != null
                      ? FileImage(_selectedImage!)
                      : AssetImage('images/placeholder_img.png') as ImageProvider,
                      child: Icon(Icons.camera_alt, size: 30, color: Colors.white),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Name'),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _phoneController,
                decoration: InputDecoration(labelText: 'Phone'),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    widget.contactInfo['name'] = _nameController.text;
                    widget.contactInfo['phone'] = _phoneController.text;
                    widget.contactInfo['email'] = _emailController.text;
                  });
                  Navigator.pop(context, widget.contactInfo);
                },
                child: Text('Update'),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Show Dialog to Choose Image Source (Gallery or Camera)
  void _showImageSourceDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Select Image Source'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _pickImage(ImageSource.camera);
              },
              child: Text('Camera'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _pickImage(ImageSource.gallery);
              },
              child: Text('Gallery'),
            ),
          ],
        );
      },
    );
  }
}
