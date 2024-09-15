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
      backgroundColor: Color(0xFFE0F7FA),
      appBar: AppBar(
        title: Text('Edit Your Farm Profile',style: TextStyle(fontWeight: FontWeight.bold),),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    _showImagePickerOptions();
                  },
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.green,
                            width: 3.0,
                          ),
                        ),
                        child: CircleAvatar(
                          radius: 70, // Larger avatar
                          backgroundImage: _selectedImage != null
                              ? FileImage(_selectedImage!)
                              : const AssetImage('images/placeholder_img.png'),
                        ),
                      ),
                      const Icon(Icons.camera_alt, size: 50, color: Colors.white),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                TextFormField(
                  controller: farmNameController,
                  decoration: InputDecoration(
                    labelText: 'Farm Name',
                    hintText: 'Enter your farm name',

                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: const BorderSide(color: Colors.green),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: farmAddressController,
                  decoration: InputDecoration(
                    labelText: 'Location',
                    hintText: 'Enter your farm location',

                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: const BorderSide(color: Colors.green),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: farmDescriptionController,
                  maxLines: 4,
                  decoration: InputDecoration(
                    labelText: 'Description',
                    hintText: 'Tell us about your farm',
                    alignLabelWithHint: true,

                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: const BorderSide(color: Colors.green),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                SizedBox(
                  width: 250, // Wider button
                  child: ElevatedButton(
                    onPressed: () {
                      _updateFarmInfo();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
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
