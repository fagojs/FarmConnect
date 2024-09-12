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

  // Email validation regex
  bool isValidEmail(String email) {
    return EmailValidator.validate(email); // Using package to validate email
  }

  void _register() {
    String email = _emailController.text;
    String password = _passwordController.text;
    String confirmPassword = _confirmPasswordController.text;

    // Check if any field is empty
    if (email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('All fields are required!')),
      );
      return;
    }

   // Validate email format
    if (!isValidEmail(email)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter a valid email address')),
      );
      return;
    }

    // Check password length
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
      // Add a new Farmer
      Farmer newFarmer = Farmer(email: email, password: password, confirmPassword: confirmPassword);
      setState(() {
        dummyFarmers.add(newFarmer);
      });
    } else if (userType == 'Business') {
      // Add a new Business Owner
      BusinessOwner newBusinessOwner =
          BusinessOwner(email: email, password: password, confirmPassword: confirmPassword);
      setState(() {
        dummyBusinessOwner.add(newBusinessOwner);
      });
    }

    // Navigate to SignIn page with the correct user type
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

      body: SingleChildScrollView(      
      child:Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 20),
            Text(
              'Welcome To FarmConnect',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              'Sign Up',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              'Let’s create your account.\nEnter your email and password',
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Text('Who are you?'),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ChoiceChip(
                  label: Text('Farmer'),
                  selected: userType == 'Farmer',
                  onSelected: (bool selected) {
                    setState(() {
                      userType = 'Farmer';
                    });
                  },
                ),
                SizedBox(width: 10),
                ChoiceChip(
                  label: Text('Business'),
                  selected: userType == 'Business',
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
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                    icon: Icon(
                      _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                  ),
                ),
                obscureText: !_isPasswordVisible,  // Toggle password visibility
              ),
            SizedBox(height: 10),
            TextField(
              controller: _confirmPasswordController,
              decoration: InputDecoration(
                labelText: 'Confirm Password',
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                    icon: Icon(
                      _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                  ),
                ),
                obscureText: !_isPasswordVisible,  // Toggle password visibility
              ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: (){
                _register();
              },
              child: Text('Sign Up'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange, // background
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Already have an account?'),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/signin');
                  },
                  child: Text('Sign In', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.orange),),
                ),
              
            ],),
            SizedBox(height: 20),
          ],
        ),
      ),
      )
    );
  }
}
