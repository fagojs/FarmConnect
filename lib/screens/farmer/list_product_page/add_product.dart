import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class AddProductPage extends StatefulWidget {
  @override
  _AddProductPageState createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  String? _selectedCategory;
  final List<String> _categories = ['Vegetable', 'Fruit', 'Dairy', 'Grain', 'Meat'];

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  File? _productImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List Product'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Navigate back to List Product Page
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'List Product',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: () async {
                  final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
                  if (pickedFile != null) {
                    setState(() {
                      _productImage = File(pickedFile.path);
                    });
                  }
                },
                child: _productImage == null
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
                    : Image.file(
                        _productImage!,
                        width: 150,
                        height: 150,
                        fit: BoxFit.cover,
                      ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _nameController,
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
                      controller: _quantityController,
                      decoration: InputDecoration(
                        labelText: 'Quantity (in kg)',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: _priceController,
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
                controller: _descriptionController,
                maxLines: 4,
                decoration: InputDecoration(
                  labelText: 'Product Description',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Pass the new product data back to List Product Page
                  Navigator.pop(context, {
                    'name': _nameController.text,
                    'quantity': _quantityController.text,
                    'price': _priceController.text,
                    'description': _descriptionController.text,
                    'image': _productImage,
                  });
                },
                child: Text('Add Product'),
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
