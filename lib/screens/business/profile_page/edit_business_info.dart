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
    businessNameController.text = currentUser.businessName ?? '';
    businessAddressController.text = currentUser.businessAddress ?? '';
    businessDescriptionController.text = currentUser.businessDescription ?? '';
  }

   void _updateBusinessInfo(){
    setState(() {
        currentUser.businessName = businessNameController.text;
        currentUser.businessAddress = businessAddressController.text;
        currentUser.businessDescription = businessDescriptionController.text;
      });
      Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE0F7FA),
      appBar: AppBar(
        title: const Text('Edit Your Business Information',style: TextStyle(fontWeight: FontWeight.bold)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
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
                color: Colors.blue[900],
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.add_a_photo, size: 40, color: Colors.white),
                    Center( // Wrap the Text widget with Center
                      child: Text(
                        'Add image of your product (optional)',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 48),
          TextField(
            controller: businessNameController,
            decoration: InputDecoration(
              labelText: 'Business Name',
              hintText: 'Enter your business name',
              prefixIcon: const Icon(Icons.home),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.0),
                borderSide: const BorderSide(color: Colors.orange),
              ),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: businessDescriptionController,
            decoration: InputDecoration(
                labelText: 'Business Description',
                hintText: 'Add description for your business',
                prefixIcon: const Icon(Icons.info),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: const BorderSide(color: Colors.orange),
                ),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: businessAddressController,
            decoration: InputDecoration(
              labelText: 'Address',
              hintText: 'Enter address of your business',
              prefixIcon: const Icon(Icons.location_on),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.0),
                borderSide: const BorderSide(color: Colors.orange),
              ),
            ),
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: 250,
            child: ElevatedButton(
              onPressed: () {
                _updateBusinessInfo();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[900],
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
