import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class EditFarmInfoPage extends StatefulWidget {
  final Map<String, dynamic> farmInfo;

  EditFarmInfoPage({required this.farmInfo});

  @override
  _EditFarmInfoPageState createState() => _EditFarmInfoPageState();
}

class _EditFarmInfoPageState extends State<EditFarmInfoPage> {
  late TextEditingController _farmNameController;
  late TextEditingController _locationController;
  late TextEditingController _descriptionController;
  File? _image;

  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _farmNameController = TextEditingController(text: widget.farmInfo['farmName']);
    _locationController = TextEditingController(text: widget.farmInfo['location']);
    _descriptionController = TextEditingController(text: widget.farmInfo['description']);
  }

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
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
                  backgroundImage: _image != null
                      ? FileImage(_image!)
                      : AssetImage('images/placeholder_img.png') as ImageProvider,
                  child: Icon(Icons.camera_alt, size: 30, color: Colors.white),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _farmNameController,
                decoration: InputDecoration(labelText: 'Farm Name'),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _locationController,
                decoration: InputDecoration(labelText: 'Location'),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Description'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    widget.farmInfo['farmName'] = _farmNameController.text;
                    widget.farmInfo['location'] = _locationController.text;
                    widget.farmInfo['description'] = _descriptionController.text;
                  });
                  Navigator.pop(context, widget.farmInfo);
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
