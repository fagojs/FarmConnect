import 'package:flutter/material.dart';

import './landing_page.dart';
import './signup_page.dart';

import '../data/dummy_data.dart';
import '../models/business_owner_model.dart';
import '../models/farmer_model.dart';

class SignInPage extends StatefulWidget {
  final String userType;

  SignInPage({required this.userType});

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isPasswordVisible = false;
  bool _isLoading = false;

  void _signIn() {
    setState(() {
      _isLoading = true;
    });

    String email = _emailController.text;
    String password = _passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('All fields are required')),
      );
      setState(() {
        _isLoading = false;
      });
      return;
    }

    if (widget.userType == 'Farmer') {
      Farmer? farmer = dummyFarmers.firstWhere(
              (farmer) => farmer.email == email && farmer.password == password,
          orElse: () => Farmer(
              email: '', password: '', confirmPassword: ''));

      Future.delayed(Duration(seconds: 2), () {
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
        setState(() {
          _isLoading = false;
        });
      });
    } else if (widget.userType == 'Business') {
      BusinessOwner? businessOwner = dummyBusinessOwner.firstWhere(
              (owner) => owner.email == email && owner.password == password,
          orElse: () => BusinessOwner(
              email: '', password: '', confirmPassword: ''));

      Future.delayed(Duration(seconds: 2), () {
        if (businessOwner.email.isNotEmpty ||
            businessOwner.password.isNotEmpty) {
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
        setState(() {
          _isLoading = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE0F7FA),
      body: ListView(
        padding: EdgeInsets.all(24.0),
        children: <Widget>[
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            color: Colors.white,
            child: Padding(
              padding: EdgeInsets.all(24.0),
              child: Column(
                children: [
                  Text(
                    'Hi there,',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF4CAF50), // Green
                    ),
                  ),
                  Text(
                    'Welcome '
                        'Back',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF4CAF50), // Green
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 24),
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            color: Colors.white,
            child: Padding(
              padding: EdgeInsets.all(24.0),
              child: Column(
                children: [
                  Text(
                    'Sign In',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF4CAF50), // Green
                    ),
                  ),
                  Text(
                    'Enter your account details below.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.email, color: Colors.grey[600]),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.lock, color: Colors.grey[600]),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.grey[600],
                        ),
                        onPressed: () {
                          setState(() {
                            _isPasswordVisible = !_isPasswordVisible;
                          });
                        },
                      ),
                    ),
                    obscureText: !_isPasswordVisible,
                  ),
                  SizedBox(height: 10),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text(
                                  'Password reset link is sent to your email')),
                        );
                      },
                      child: Text(
                        'Forgot Password?',
                        style: TextStyle(color: Color(0xFF4CAF50)), // Green
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _isLoading ? null : _signIn,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF4CAF50), // Green
                      padding:
                      EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                      textStyle: TextStyle(fontSize: 18),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                    ),
                    child: _isLoading
                        ? CircularProgressIndicator(
                      valueColor:
                      AlwaysStoppedAnimation<Color>(Colors.white),
                    )
                        : Text('Sign In', style: TextStyle(color: Colors.white)),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Don’t have an account?',
                          style: TextStyle(color: Colors.grey[600])),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SignUpPage(),
                            ),
                          );
                        },
                        child: Text(
                          'Sign Up',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF4CAF50), // Green
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}