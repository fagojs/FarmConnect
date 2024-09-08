import 'package:flutter/material.dart';

class ProductDetailsPage extends StatefulWidget {
  final String productName;
  final int quantity;
  final double price;
  final String description;

  ProductDetailsPage({
    required this.productName,
    required this.quantity,
    required this.price,
    required this.description,
  });

  @override
  _ProductDetailsPageState createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  bool showFarmerInfo = false;  // Initially hidden

  void _toggleFarmerInfo() {
    setState(() {
      showFarmerInfo = !showFarmerInfo;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Navigates back to the previous page
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Product Image
              Container(
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  image: DecorationImage(
                    image: AssetImage('images/placeholder_img.png'), // Replace with product image
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 10),
              // Product Details
              Text(
                'Product Details:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text('Product Name: ${widget.productName}', style: TextStyle(fontSize: 16)),
              Text('Quantity (in kg): ${widget.quantity}', style: TextStyle(fontSize: 16)),
              Text('Price (per kg): ${widget.price}\$', style: TextStyle(fontSize: 16)),
              Text('Description: ${widget.description}', style: TextStyle(fontSize: 16)),
              SizedBox(height: 20),

              // Toggle Farmer Information
              GestureDetector(
                onTap: _toggleFarmerInfo,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Farmer Information',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Icon(showFarmerInfo ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down),
                  ],
                ),
              ),
              if (showFarmerInfo) ...[
                SizedBox(height: 10),
                Text('Farmer Name: John Wick', style: TextStyle(fontSize: 16)),
                Text('Farm Location: Sydney, Australia', style: TextStyle(fontSize: 16)),
                Text('Contact Number: 042867456', style: TextStyle(fontSize: 16)),
                Text('Email: johnwick@gmail.com', style: TextStyle(fontSize: 16)),
              ],
              SizedBox(height: 20),

              // Add to Cart Button
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Add to cart logic
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Product added to cart!')),
                    );
                  },
                  child: Text('ADD TO CART'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange, // Background color
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
