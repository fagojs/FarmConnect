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

      appBar: AppBar(
        title: Text(
          'Product Details',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.green,
        leading: IconButton(
          icon: Icon(Icons.arrow_back,color: Colors.white,),
          onPressed: () {
            Navigator.pop(context); // Navigates back to the previous page
          },
        ),
      ),
      body:
      Stack(
          children: [
      Container(
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
    ),

       Padding(
        padding: const EdgeInsets.all(24.0),
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
                  fontWeight: FontWeight.w500,
                  color: Colors.green[800],
                ),
              ),

              Text(
                'Product Name: ${widget.productName}',
                style: TextStyle(fontSize: 16,  ),
              ),

              Text(
                'Quantity Available: ${widget.quantity}',
                style: TextStyle(fontSize: 16, ),
              ),

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

              Text(
                'Description: ${widget.description}',
                style: TextStyle(fontSize: 16,),
              ),
              SizedBox(height: 8),

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
                        color: Colors.green[800],
                      ),
                    ),
                    Icon(
                      showFarmerInfo
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down,
                      color: Colors.green[800],
                    ),
                  ],
                ),
              ),
              if (showFarmerInfo) ...[

                Text(
                  'Farmer Name: John Wick',
                  style: TextStyle(fontSize: 16,),
                ),

                Text(
                  'Farm Location: Sydney, Australia',
                  style: TextStyle(fontSize: 16, ),
                ),

                Text(
                  'Contact Number: 042867456',
                  style: TextStyle(fontSize: 16,),
                ),

                Text(
                  'Email: johnwick@gmail.com',
                  style: TextStyle(fontSize: 16, ),
                ),
              ],
              SizedBox(height: 32),

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
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(MediaQuery.of(context).size.width * 0.7, 50),
                    backgroundColor: const Color(0xFF4CAF50),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    elevation: 5, // Elevation to make it more prominent
                  ),
                ),
              ),
            ],
          ),
        ),
      ),],),
    );
  }
}
