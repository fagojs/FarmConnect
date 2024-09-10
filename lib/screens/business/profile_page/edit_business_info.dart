import 'package:flutter/material.dart';

import '../../../data/currentuser.dart';

class EditBusinessInformation extends StatefulWidget {
  @override
  _EditBusinessInformationState createState() => _EditBusinessInformationState();
}

class _EditBusinessInformationState extends State<EditBusinessInformation> {
  final TextEditingController businessNameController = TextEditingController();
  final TextEditingController businessAddressController = TextEditingController();
  final TextEditingController businessDescriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    businessNameController.text = currentUser.fullName ?? '';
    businessAddressController.text = currentUser.address ?? '';
    businessDescriptionController.text = currentUser.contactNumber ?? '';
  }

   void _updateBusinessInfo(){
    setState(() {
        currentUser.farmName = businessNameController.text;
        currentUser.farmAddress = businessAddressController.text;
        currentUser.farmDescription = businessDescriptionController.text;
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
            Text('Update your business details below.', style: TextStyle(fontSize: 16)),
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
              controller: businessNameController,
              decoration: InputDecoration(labelText: 'Business Name', border: OutlineInputBorder()),
            ),
            SizedBox(height: 10),
            TextField(
              controller: businessDescriptionController,
              decoration: InputDecoration(
                labelText: 'Business Description',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: businessAddressController,
              decoration: InputDecoration(labelText: 'Location', border: OutlineInputBorder()),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
               _updateBusinessInfo();
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
