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
        const SnackBar(content: Text('All fields are required!')),
      );
      return;
    }

    if (!isValidEmail(email)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid email address')),
      );
      return;
    }

    if (password.length < 5) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Password must be at least 5 characters')),
      );
      return;
    }

    if (password != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Passwords do not match')),
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
      body:  Container(
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
        padding: const EdgeInsets.all(24.0),
        children: <Widget>[
          const SizedBox(height: 120),
                  Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                   const Text(
                      'FarmConnect',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF4CAF50),
                      ),
                    ),
                  const SizedBox(height: 4),
                  const Text(
                    'Sign Up',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF4CAF50),
                    ),
                  ),

    ],
                  ),
    ),
          const SizedBox(height: 24,),
          Padding(
            padding: const EdgeInsets.only(left: 16.0), // Adjust the padding as needed
            child: Text(
              'Create an Account',
              style: TextStyle(
                color: Colors.green[800],
                fontSize: 20,
                fontWeight: FontWeight.w500,

              ),
            ),
          ),
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
                    'Who are you?',
                    style: TextStyle(color: Colors.black,fontSize: 16),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ChoiceChip(
                        label:
                            const Text('Farmer'),


                        labelStyle: TextStyle(
                            color: userType == 'Farmer'
                                ? Colors.white
                                : Colors.black),
                        selected: userType == 'Farmer',
                        selectedColor: const Color(0xFF4CAF50),
                        onSelected: (bool selected) {
                          setState(() {
                            userType = 'Farmer';
                          });
                        },
                      ),
                      const SizedBox(width: 10),
                      ChoiceChip(
                        label: const Text('Business'),
                        labelStyle: TextStyle(
                            color: userType == 'Business'
                                ? Colors.white
                                : Colors.black),
                        selected: userType == 'Business',
                        selectedColor: const Color(0xFF4CAF50),
                        onSelected: (bool selected) {
                          setState(() {
                            userType = 'Business';
                          });
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      labelStyle: TextStyle(
                          color: Colors.green,
                          fontSize: 16
                      ),
                      border: const OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: BorderSide(
                          color: Colors.green,
                          width: 3.0,
                        ),
                      ),
                      prefixIcon: Icon(Icons.email, color: Colors.green[600]),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle: TextStyle(
                          color: Colors.green,
                          fontSize: 16
                      ),
                      border: const OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: BorderSide(
                          color: Colors.green,
                          width: 3.0,
                        ),
                      ),
                      prefixIcon: Icon(Icons.lock, color: Colors.green[600]),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.green[600],
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
                  const SizedBox(height: 10),
                  TextField(
                    controller: _confirmPasswordController,
                    decoration: InputDecoration(
                      labelText: 'Confirm Password',
                      labelStyle: TextStyle(
                          color: Colors.green,
                          fontSize: 16
                      ),
                      border: const OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: BorderSide(
                          color: Colors.green,
                          width: 3.0,
                        ),
                      ),
                      prefixIcon: Icon(Icons.lock, color: Colors.green[600]),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.green[600],
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
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      _register();
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(MediaQuery.of(context).size.width * 0.7, 50),
                      backgroundColor: const Color(0xFF4CAF50),
                      padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                      // textStyle: const TextStyle(fontSize: 18),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                    ),
                    child: const Text('Sign Up',
                        style: TextStyle(color: Colors.white)),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Already have an account?',
                          style: TextStyle(color: Colors.grey[600])),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, '/signin');
                        },
                        child: const Text(
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
    ),
    );
  }
}