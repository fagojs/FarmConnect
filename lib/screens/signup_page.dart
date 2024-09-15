import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';

import './signin_page.dart';
import '../models/business_owner_model.dart';
import '../models/farmer_model.dart';
import '../data/dummy_data.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  String userType = 'Farmer';

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _isPasswordVisible = false;

  bool isValidEmail(String email) {
    return EmailValidator.validate(email);
  }

  void _register() {
    String email = _emailController.text;
    String password = _passwordController.text;
    String confirmPassword = _confirmPasswordController.text;

    if (email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('All fields are required!')),
      );
      return;
    }

    if (!isValidEmail(email)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter a valid email address')),
      );
      return;
    }

    if (password.length < 5) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Password must be at least 5 characters')),
      );
      return;
    }

    if (password != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Passwords do not match')),
      );
      return;
    }

    if (userType == 'Farmer') {
      Farmer newFarmer = Farmer(
          email: email, password: password, confirmPassword: confirmPassword);
      setState(() {
        dummyFarmers.add(newFarmer);
      });
    } else if (userType == 'Business') {
      BusinessOwner newBusinessOwner = BusinessOwner(
          email: email, password: password, confirmPassword: confirmPassword);
      setState(() {
        dummyBusinessOwner.add(newBusinessOwner);
      });
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SignInPage(userType: userType),
      ),
    );
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
                    'Welcome to FarmConnect',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF4CAF50),
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Sign Up',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF4CAF50),
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Let’s create your account.\nEnter your email and password',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey[600]),
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
                    'Who are you?',
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ChoiceChip(
                        label: Text('Farmer'),
                        labelStyle: TextStyle(
                            color: userType == 'Farmer'
                                ? Colors.white
                                : Colors.grey[600]),
                        selected: userType == 'Farmer',
                        selectedColor: Color(0xFF4CAF50),
                        onSelected: (bool selected) {
                          setState(() {
                            userType = 'Farmer';
                          });
                        },
                      ),
                      SizedBox(width: 10),
                      ChoiceChip(
                        label: Text('Business'),
                        labelStyle: TextStyle(
                            color: userType == 'Business'
                                ? Colors.white
                                : Colors.grey[600]),
                        selected: userType == 'Business',
                        selectedColor: Color(0xFF4CAF50),
                        onSelected: (bool selected) {
                          setState(() {
                            userType = 'Business';
                          });
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
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
                  TextField(
                    controller: _confirmPasswordController,
                    decoration: InputDecoration(
                      labelText: 'Confirm Password',
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
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      _register();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF4CAF50),
                      padding:
                      EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                      textStyle: TextStyle(fontSize: 18),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                    ),
                    child: Text('Sign Up',
                        style: TextStyle(color: Colors.white)),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Already have an account?',
                          style: TextStyle(color: Colors.grey[600])),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, '/signin');
                        },
                        child: Text(
                          'Sign In',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF4CAF50)),
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