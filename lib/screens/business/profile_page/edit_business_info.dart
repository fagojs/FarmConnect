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
      backgroundColor: Color(0xFFE0F7FA),
      appBar: AppBar(
        title: Text('Edit Your Business Information',style: TextStyle(fontWeight: FontWeight.bold)),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    body: SingleChildScrollView(
      child: Padding(padding: const EdgeInsets.all(20.0),
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
                    const Icon(Icons.add_a_photo, size: 40),
                    Center( // Wrap the Text widget with Center
                      child: Text(
                        'Add image of your product',
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.white60),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 48),
          TextField(
            controller: businessNameController,
            decoration: InputDecoration(labelText: 'Business Name', border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0),
              borderSide: const BorderSide(color: Colors.green),
            )),
          ),
          SizedBox(height: 16),
          TextField(
            controller: businessDescriptionController,
            decoration: InputDecoration(
              labelText: 'Business Description',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.0),
                borderSide: const BorderSide(color: Colors.green),
              ),
            ),
          ),
          SizedBox(height: 16),
          TextField(
            controller: businessAddressController,
            decoration: InputDecoration(labelText: 'Location', border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0),
              borderSide: const BorderSide(color: Colors.green),
            )),
          ),
          SizedBox(height: 24),
          SizedBox(
            width: 250,
            child: ElevatedButton(
              onPressed: () {
                _updateBusinessInfo();
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
}
