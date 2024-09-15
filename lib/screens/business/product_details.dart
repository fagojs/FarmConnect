import 'package:flutter/material.dart';
import '../../data/cart_state.dart';

class ProductDetailsPage extends StatefulWidget {
  final String productName;
  final String quantity;
  final String price;
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
  bool showFarmerInfo = false; // Initially hidden

  void _toggleFarmerInfo() {
    setState(() {
      showFarmerInfo = !showFarmerInfo;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE0F7FA),
      appBar: AppBar(
        title: Text(
          'Product Details',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
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
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                      offset: Offset(0, 5),
                    ),
                  ],
                  image: DecorationImage(
                    image: AssetImage('images/placeholder_img.png'), // Replace with product image
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 20),

              // Product Details Section
              Text(
                'Product Details',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[900],
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Product Name: ${widget.productName}',
                style: TextStyle(fontSize: 16,  ),
              ),
              SizedBox(height: 5),
              Text(
                'Quantity Available: ${widget.quantity}',
                style: TextStyle(fontSize: 16, ),
              ),
              SizedBox(height: 5),
              if (widget.quantity.split(" ")[1] == "kg")
                Text(
                  'Price: \$${widget.price} per kg',
                  style: TextStyle(fontSize: 16, ),
                )
              else
                Text(
                  'Price: \$${widget.price} per litre',
                  style: TextStyle(fontSize: 16, ),
                ),
              SizedBox(height: 5),
              Text(
                'Description: ${widget.description}',
                style: TextStyle(fontSize: 16,),
              ),
              SizedBox(height: 20),

              // Toggle Farmer Information
              GestureDetector(
                onTap: _toggleFarmerInfo,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Farmer Information',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue[900],
                      ),
                    ),
                    Icon(
                      showFarmerInfo
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down,
                      color: Colors.blue[900],
                    ),
                  ],
                ),
              ),
              if (showFarmerInfo) ...[
                SizedBox(height: 10),
                Text(
                  'Farmer Name: John Wick',
                  style: TextStyle(fontSize: 16,),
                ),
                SizedBox(height: 5),
                Text(
                  'Farm Location: Sydney, Australia',
                  style: TextStyle(fontSize: 16, ),
                ),
                SizedBox(height: 5),
                Text(
                  'Contact Number: 042867456',
                  style: TextStyle(fontSize: 16,),
                ),
                SizedBox(height: 5),
                Text(
                  'Email: johnwick@gmail.com',
                  style: TextStyle(fontSize: 16, ),
                ),
              ],
              SizedBox(height: 30),

              // Add to Cart Button
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Add to cart logic
                    String unit = widget.quantity.split(" ")[1] == "kg" ? "kg" : "litre";
                    cartState.addToCart({
                      "name": widget.productName,
                      "price": double.parse(widget.price),
                      "quantity": 1,
                      "unit": unit,
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('${widget.productName} added to cart!'),
                        duration: Duration(seconds: 1),
                      ),
                    );
                  },
                  child: Text(
                    'ADD TO CART',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green, // Button background color
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 5, // Elevation to make it more prominent
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
