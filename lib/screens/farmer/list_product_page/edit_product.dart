import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class EditProductPage extends StatefulWidget {
  final Map<String, dynamic> product;

  EditProductPage({required this.product});

  @override
  _EditProductPageState createState() => _EditProductPageState();
}

class _EditProductPageState extends State<EditProductPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  String? _selectedCategory;
  File? _productImage;

  final List<String> _categories = ['Vegetable', 'Fruit', 'Dairy', 'Grain', 'Meat'];

  @override
  void initState() {
    super.initState();
    // Pre-fill the fields with existing product information
    _nameController.text = widget.product['name'];
    _quantityController.text = widget.product['quantity'];
    _priceController.text = widget.product['price'];
    _descriptionController.text = widget.product['description'];
    _selectedCategory = widget.product['category'];
    _productImage = widget.product['image'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Product'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Go back to the previous page
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
                'Edit Your Product Details',
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
                              Text('Select your photo'),
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
                  // Pass the updated product data back to List Product Page
                  Navigator.pop(context, {
                    'name': _nameController.text,
                    'quantity': _quantityController.text,
                    'price': _priceController.text,
                    'description': _descriptionController.text,
                    'category': _selectedCategory,
                    'image': _productImage,
                  });
                },
                child: Text('Update'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange, // background color
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
