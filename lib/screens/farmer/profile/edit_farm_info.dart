import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import '../../../data/currentuser.dart';

class EditFarmInfoPage extends StatefulWidget {
  @override
  _EditFarmInfoPageState createState() => _EditFarmInfoPageState();
}

class _EditFarmInfoPageState extends State<EditFarmInfoPage> {

  final TextEditingController farmNameController = TextEditingController();
  final TextEditingController farmAddressController = TextEditingController();
  final TextEditingController farmDescriptionController = TextEditingController();


  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    farmNameController.text = currentUser.fullName ?? '';
    farmAddressController.text = currentUser.address ?? '';
    farmDescriptionController.text = currentUser.contactNumber ?? '';
  }

  void _updateFarmInfo(){
    setState(() {
        currentUser.farmName = farmNameController.text;
        currentUser.farmAddress = farmAddressController.text;
        currentUser.farmDescription = farmDescriptionController.text;
      });
      Navigator.pop(context);
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
        title: Text('Edit Your Farm Profile'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  _showImagePickerOptions();
                },
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: _selectedImage != null
                      ? FileImage(_selectedImage!)
                      : AssetImage('images/placeholder_img.png') as ImageProvider,
                  child: Icon(Icons.camera_alt, size: 30, color: Colors.white),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: farmNameController,
                decoration: InputDecoration(labelText: 'Farm Name'),
              ),
              SizedBox(height: 10),
              TextField(
                controller: farmAddressController,
                decoration: InputDecoration(labelText: 'Location'),
              ),
              SizedBox(height: 10),
              TextField(
                controller: farmDescriptionController,
                decoration: InputDecoration(labelText: 'Description'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  _updateFarmInfo();                   
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

  // Function to show options for picking an image
  void _showImagePickerOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('Choose from Gallery'),
                onTap: () {
                  _pickImage(ImageSource.gallery);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: Icon(Icons.camera_alt),
                title: Text('Take a Photo'),
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
}
