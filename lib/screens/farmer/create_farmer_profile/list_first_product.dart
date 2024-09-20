import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'personal.dart';
import '../home_page.dart';
import '../../../data/dummy_data.dart';
import '../../../models/product_model.dart';
import '../../landing_page.dart';

class ListFirstProductPage extends StatefulWidget {
  @override
  _ListFirstProductPageState createState() => _ListFirstProductPageState();
}

class _ListFirstProductPageState extends State<ListFirstProductPage> {
  File? _image;
  final ImagePicker _picker = ImagePicker();
  String? _selectedCategory;
  final List<String> _categories = ['Vegetable', 'Fruit', 'Dairy', 'Grain', 'Meat'];
  String productName = '';
  int quantity = 0;
  double price = 0.0;
  String productDescription = '';

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('No image selected!!'),
          ),
        );
      }
    });
  }

  void _saveFirstProduct(){
    if (productName.isNotEmpty && _selectedCategory != null && quantity != 0 && price != 0.0) {
      if(quantity < 0 || price < 0){
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Quantity or Price cannot have negative value!'),
          ),
        );
      }else{
        // Add product to in-memory list
        productList.add(Product(
          productName: productName,
          category: _selectedCategory!,
          quantity: quantity,
          pricePerKg: price,
          productImage: _image,
          description: productDescription,
        ));

        // Navigate to farmer home page
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FarmerHomePage(),
          ),
        );
        setState(() {});
      }
    }else if(quantity == 0 || price == 0){
       ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Quantity or Price must be greater than 0'),
        ),
      );
    }else{
       // Show an error message for empty fields
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in all fields to list the product or skip for now.'),
        ),
      );
    }
  }

  void _showImageSourceActionSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Photo Library'),
                onTap: () {
                  _pickImage(ImageSource.gallery);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text('Camera'),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: const Text('FarmConnect',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),
        backgroundColor: Colors.green,
        centerTitle: true,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu,color: Colors.white,),
            onPressed: () {
              Scaffold.of(context).openDrawer(); // Opens the drawer
            },
          ),
        ),
      ),
        drawer: Drawer(
          child: Container(
            color: Colors.white,
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                const DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.green,
                  ),
                  child: Center(
                    child: Text(
                      'FarmConnect',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                ListTile(
                  leading: const Icon(Icons.home, color: Colors.green),
                  title: const Text('Welcome'),
                  onTap: () {
                    Navigator.of(context).pop(); // Close the drawer
                    // Navigate to Welcome Screen
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => LandingPage(userType: 'Farmer')));
                  },
                ),


                ListTile(
                  leading: const Icon(Icons.person, color: Colors.green),
                  title: const Text('Create Farmer Profile'),
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CreateFarmerPersonalProfile(),
                        )
                    );


                  },
                ),
                ListTile(
                  leading: const Icon(Icons.settings, color: Colors.green),
                  title: const Text('Settings'),
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                ),
                Divider(color: Colors.grey[300]), // Use a lighter gray for the divider
                ListTile(
                  leading: const Icon(Icons.logout, color: Colors.red),
                  title: const Text('Log Out'),
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.pushReplacementNamed(context, '/signin');
                  },
                ),
              ],
            ),
          ),
        ),
      body:ListView(
        padding: const EdgeInsets.all(24.0),
        children: <Widget>[
          Card(
            elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),

              ),
            color: Colors.white,
            child: Padding(
                padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  const Text('Create a Farmer Profile',
                    style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold,color: Color(0xFF4CAF50)
                    ),
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () => _showImageSourceActionSheet(context),
                    child: _image == null
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
                            Icon(Icons.add_a_photo, size: 40, color: Colors.white,),
                            Text('Add image of your product (optional)', textAlign: TextAlign.center,style: TextStyle(color: Colors.white),),
                          ],
                        ),
                      ),
                    )
                        : Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: FileImage(_image!),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),

                ],
              ),
            ),
          ),
          const SizedBox(height: 8,),
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            color: Colors.white,
            child: Padding(
                padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  const Text(
                    'Add details of your first product.',style: TextStyle(
                      fontSize: 16,fontWeight: FontWeight.w500
                  ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Product Name (optional)',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),

                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    ),
                    onChanged: (value) => productName = value,
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            labelText: 'Quantity in unit (optional)',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),

                            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          ),
                          onChanged: (value) => quantity = int.parse(value),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            labelText: 'Price per unit (optional)',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),

                            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          ),
                          onChanged: (value) => price = double.parse(value),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      labelText: 'Select a category (optional)',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),

                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
                    maxLines: 4,
                    decoration: InputDecoration(
                      labelText: 'Product Description (optional)',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),

                      alignLabelWithHint: true,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    ),
                    onChanged: (value) => productDescription = value,
                  ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: (){
                      _saveFirstProduct();
                    },
                    child: const Text('SAVE',style: TextStyle(color: Colors.white),),
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(MediaQuery.of(context).size.width * 0.3, 25),
                      backgroundColor: const Color(0xFF4CAF50),
                      padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 16),

                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FarmerHomePage(),
                        ),
                      );
                    },
                    child: const Text('SKIP',style: TextStyle(color: Colors.white),),
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(MediaQuery.of(context).size.width * 0.3, 25),
                      backgroundColor: const Color(0xFF4CAF50),
                      padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                    ),
                  ),
                ],
              ),
                ],
              ),
            ),
          )
        ],
      )
    );
  }
}
