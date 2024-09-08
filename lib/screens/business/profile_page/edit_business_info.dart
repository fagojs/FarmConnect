import 'package:flutter/material.dart';

class EditBusinessInformation extends StatefulWidget {
  final String businessName;
  final String location;
  final String description;

  EditBusinessInformation({required this.businessName, required this.location, required this.description});

  @override
  _EditBusinessInformationState createState() => _EditBusinessInformationState();
}

class _EditBusinessInformationState extends State<EditBusinessInformation> {
  late TextEditingController _businessNameController;
  late TextEditingController _locationController;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _businessNameController = TextEditingController(text: widget.businessName);
    _locationController = TextEditingController(text: widget.location);
    _descriptionController = TextEditingController(text: widget.description);
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
              controller: _businessNameController,
              decoration: InputDecoration(labelText: 'Business Name', border: OutlineInputBorder()),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(
                labelText: 'Business Description',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _locationController,
              decoration: InputDecoration(labelText: 'Location', border: OutlineInputBorder()),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // Pass back the updated data
                Navigator.pop(context, {
                  'businessName': _businessNameController.text,
                  'description': _descriptionController.text,
                  'location': _locationController.text,
                });
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
