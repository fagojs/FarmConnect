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
        const SnackBar(content: Text('All fields are required')),
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

      Future.delayed(const Duration(seconds: 2), () {
        if (farmer.email.isNotEmpty || farmer.password.isNotEmpty) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => LandingPage(userType: widget.userType),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Invalid credentials')),
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

      Future.delayed(const Duration(seconds: 2), () {
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
            const SnackBar(content: Text('Invalid credentials')),
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
        padding: const EdgeInsets.all(24.0),
        children: <Widget>[
          const SizedBox(height: 120),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'FarmConnect',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF4CAF50), // Green
                  ),
                ),
                Text(
                  'Hi, Wecome Back! 👋',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF4CAF50), // Green
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),
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
                    'Sign In',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF4CAF50), // Green
                    ),
                  ),
                  const SizedBox(height: 8,),
                  Text(
                    'Enter your account details below.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black
                    ,
                    fontSize: 14),
                  ),
                  const SizedBox(height: 24),
                  TextField(
                    controller: _emailController,
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
                  const SizedBox(height: 24),
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

                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text(
                                  'Password reset link is sent to your email')),
                        );
                      },
                      child: const Text(
                        'Forgot Password',
                        style: TextStyle(color: Color(0xFF4CAF50),
                        fontWeight: FontWeight.bold,
                        fontSize: 16), // Green
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: _isLoading ? null : _signIn,
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(MediaQuery.of(context).size.width * 0.7, 50),
                      backgroundColor: const Color(0xFF388E3C), // Green
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                      // textStyle: const TextStyle(fontSize: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                    ),
                    child: _isLoading
                        ? const SizedBox(
                      height: 24,
                      width: 24,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation(Colors.white),
                      ),
                    )
                        : const Text('Sign In', style: TextStyle(fontSize:16,

                        
                        color: Colors.white)),
                  ), // <-- Closing the ElevatedButton here.

                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Don’t have an account?', style: TextStyle(color: Colors.grey[600])),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SignUpPage(),
                            ),
                          );
                        },
                        child: const Text(
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
    ),
    );
  }
}