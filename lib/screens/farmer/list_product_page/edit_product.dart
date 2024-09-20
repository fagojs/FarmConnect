import 'package:flutter/material.dart';
import 'dart:io';

import 'package:image_picker/image_picker.dart';
import '../../../models/product_model.dart';

class EditProductPage extends StatefulWidget {
  final Product product;

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
    _nameController.text = widget.product.productName;
    _quantityController.text = widget.product.quantity.toString();
    _priceController.text = widget.product.pricePerKg.toString();
    _descriptionController.text = widget.product.description;
    _selectedCategory = widget.product.category;
    _productImage = widget.product.productImage;
  }

  void _updateProduct(){
     if (_nameController.text.isEmpty ||
      _quantityController.text.isEmpty ||
      _priceController.text.isEmpty ||
      _selectedCategory == null ||
      _descriptionController.text.isEmpty) {
      // Show a snackbar if any field is empty
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('All fields are required!')),
      );
    }
    // Validate that the quantity is a valid integer and greater than zero
    if (int.tryParse(_quantityController.text) == null || int.parse(_quantityController.text) <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Quantity must have integer value greater than zero')),
      );
      return;
    }
    // Validate that the price is a valid double and greater than zero
    if (double.tryParse(_priceController.text) == null || double.parse(_priceController.text) <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Price must have integer value greater than zero')),
      );
      return;
    }
    // Update the product details in the CurrentUser's product list
    setState(() {
      widget.product.productName = _nameController.text;
      widget.product.quantity = int.parse(_quantityController.text);
      widget.product.pricePerKg = double.parse(_priceController.text);
      widget.product.description = _descriptionController.text;
      widget.product.category = _selectedCategory.toString();
      widget.product.productImage = _productImage;
    });
    // Return to the previous page with updated product list
    Navigator.pop(context, widget.product);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
           appBar: AppBar(
        title: const Text('Edit Product',style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),),
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back,color: Colors.white,),
          onPressed: () {
            Navigator.pop(context); // Go back to the previous page
          },
        ),
      ),
      body: Container(
    decoration: const BoxDecoration(
    gradient: LinearGradient(
    colors: [
    Color(0xFFd4fc79),
    Color(0xFF96e6a1),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    ),
    ),


      child: ListView(
        padding: EdgeInsets.all(24.0),
        children: <Widget>[
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),

            ),
            color: Colors.white,
            child: Padding(padding: EdgeInsets.all(24.0),
              child: Column(
                children: [
                  Text('Edit Your Product Details',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color:Color(0xFF4CAF50) ),
                  ),
                  SizedBox(height: 20,),
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
                        color: Colors.green[300],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.add_a_photo, size: 40),
                            Text('Select your product (optional)', textAlign: TextAlign.center,style: TextStyle(color: Colors.white70)),
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

                ],
              ),
            ),
          ),
          SizedBox(height: 8,),
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),

            ),
            color: Colors.white,
            child: Padding(padding: EdgeInsets.all(24.0),
              child: Column(
                children: [
                  SizedBox(height: 4),
                  TextField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: 'Product Name',
                      border: OutlineInputBorder(
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _quantityController,
                          decoration: InputDecoration(
                            labelText: 'Quantity Available (in ${widget.product.category == 'Dairy' ? 'litre' : 'kg'})',
                            border: const OutlineInputBorder(),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextField(
                          controller: _priceController,
                          decoration: InputDecoration(
                            labelText: 'Price (per ${widget.product.category == 'Dairy' ? 'litre' : 'kg'})',
                            border: const OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
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
                  const SizedBox(height: 10),
                  TextField(
                    controller: _descriptionController,
                    maxLines: 4,
                    decoration: const InputDecoration(
                      labelText: 'Product Description',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: (){
                      _updateProduct();
                    },
                    child: Text('Update',style: TextStyle(color: Colors.white),),
                    style: ElevatedButton.styleFrom(
                        minimumSize: Size(MediaQuery.of(context).size.width * 0.7, 50),
                        backgroundColor: const Color(0xFF4CAF50),
                        padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                        // textStyle: TextStyle(fontSize: 18),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        )
                      // background
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      )






















      // Padding(
      //   padding: const EdgeInsets.all(16.0),
      //   child: SingleChildScrollView(
      //     child: Column(
      //       mainAxisAlignment: MainAxisAlignment.center,
      //       children: <Widget>[
      //         const Text(
      //           'Edit Your Product Details',
      //           style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      //         ),
      //         const SizedBox(height: 20),
      //         GestureDetector(
      //           onTap: () async {
      //             final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
      //             if (pickedFile != null) {
      //               setState(() {
      //                 _productImage = File(pickedFile.path);
      //               });
      //             }
      //           },
      //           child: _productImage == null
      //               ? Container(
      //                   width: 150,
      //                   height: 150,
      //                   decoration: BoxDecoration(
      //                     color: Colors.grey[200],
      //                     borderRadius: BorderRadius.circular(10),
      //                   ),
      //                   child: const Center(
      //                     child: Column(
      //                       mainAxisAlignment: MainAxisAlignment.center,
      //                       children: [
      //                         Icon(Icons.add_a_photo, size: 40),
      //                         Text('Select your product photo (optional)', textAlign: TextAlign.center,),
      //                       ],
      //                     ),
      //                   ),
      //                 )
      //               : Image.file(
      //                   _productImage!,
      //                   width: 150,
      //                   height: 150,
      //                   fit: BoxFit.cover,
      //                 ),
      //         ),
      //         const SizedBox(height: 20),
      //         TextField(
      //           controller: _nameController,
      //           decoration: const InputDecoration(
      //             labelText: 'Product Name',
      //             border: OutlineInputBorder(),
      //           ),
      //         ),
      //         const SizedBox(height: 10),
      //         Row(
      //           children: [
      //             Expanded(
      //               child: TextField(
      //                 controller: _quantityController,
      //                 decoration: InputDecoration(
      //                   labelText: 'Quantity Available (in ${widget.product.category == 'Dairy' ? 'litre' : 'kg'})',
      //                   border: const OutlineInputBorder(),
      //                 ),
      //               ),
      //             ),
      //             const SizedBox(width: 10),
      //             Expanded(
      //               child: TextField(
      //                 controller: _priceController,
      //                 decoration: InputDecoration(
      //                   labelText: 'Price (per ${widget.product.category == 'Dairy' ? 'litre' : 'kg'})',
      //                   border: const OutlineInputBorder(),
      //                 ),
      //               ),
      //             ),
      //           ],
      //         ),
      //         const SizedBox(height: 10),
      //         DropdownButtonFormField<String>(
      //           decoration: const InputDecoration(
      //             labelText: 'Select a category',
      //             border: OutlineInputBorder(),
      //           ),
      //           value: _selectedCategory,
      //           onChanged: (newValue) {
      //             setState(() {
      //               _selectedCategory = newValue;
      //             });
      //           },
      //           items: _categories.map((category) {
      //             return DropdownMenuItem(
      //               child: Text(category),
      //               value: category,
      //             );
      //           }).toList(),
      //         ),
      //         const SizedBox(height: 10),
      //         TextField(
      //           controller: _descriptionController,
      //           maxLines: 4,
      //           decoration: const InputDecoration(
      //             labelText: 'Product Description',
      //             border: OutlineInputBorder(),
      //           ),
      //         ),
      //         const SizedBox(height: 20),
      //         ElevatedButton(
      //           onPressed: () {
      //             _updateProduct();
      //           },
      //           child: const Text('Update'),
      //           style: ElevatedButton.styleFrom(
      //             backgroundColor: Colors.orange, // background color
      //           ),
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
    ),
    );
  }
}
