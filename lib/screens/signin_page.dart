import 'package:farm_connect/screens/signup_page.dart';
import 'package:flutter/material.dart';
import './landing_page.dart';

import '../data/dummy_data.dart';
import '../models/business_owner_model.dart';
import '../models/farmer_model.dart';


class SignInPage extends StatefulWidget {
  final String userType;

  SignInPage({required this.userType});
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage>{

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void _signIn() {
    String email = _emailController.text;
    String password = _passwordController.text;
    // Check if any field is empty
    if (email.isEmpty || password.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('All fields are required')),
        );
        return;
    }

    if(widget.userType == 'Farmer') {
      Farmer? farmer = dummyFarmers.firstWhere(
          (farmer) => farmer.email == email && farmer.password == password,
          orElse: () => Farmer(
              email: '', password: '', confirmPassword: '')); // Empty object if not found


      // Check credentials
      if (farmer.email.isNotEmpty || farmer.password.isNotEmpty) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => LandingPage(userType: widget.userType),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Invalid credentials')),
        );
      }
    }else if (widget.userType == 'Business') {
      BusinessOwner? businessOwner = dummyBusinessOwner.firstWhere(
          (owner) => owner.email == email && owner.password == password,
          orElse: () => BusinessOwner(
              email: '', password: '', confirmPassword: '')); // Empty object if not found
       // Check credentials
      if(businessOwner.email.isNotEmpty || businessOwner.password.isNotEmpty) {
        Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => LandingPage(userType: widget.userType),
        ),
      );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Invalid credentials')),
        );
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Hi there,',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              'Welcome Back',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              'Sign In',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              'Enter your account details below.',
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.visibility_off),
              ),
              obscureText: true,
            ),
            SizedBox(height: 10),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  // Implement forgot password functionality
                },
                child: Text('Forgot Password?'),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed:(){
                _signIn();
              },
              child: Text('Sign In'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange, // background
              ),
            ),
            SizedBox(height: 10),
            TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SignUpPage(),
                  ),
                );
              },
              child: Text('Don’t have an account? Sign Up'),
            ),
          ],
        ),
      ),
    );
  }
}
