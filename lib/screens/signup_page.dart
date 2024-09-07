import 'package:flutter/material.dart';
import './signin_page.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  String userType = 'Farmer';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Welcome To',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              'FarmConnect',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              'Sign Up',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              'Let’s create your account. Enter your email and password',
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Text('Who are you?'),
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
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.visibility_off),
              ),
              obscureText: true,
            ),
            SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                labelText: 'Confirm Password',
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.visibility_off),
              ),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to Sign In and pass the user type
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SignInPage(userType: userType),
                  ),
                );
              },
              child: Text('Sign Up'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange, // background
              ),
            ),
            SizedBox(height: 10),
            TextButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/signin');
              },
              child: Text('Already have an account? Sign In'),
            ),
          ],
        ),
      ),
    );
  }
}
