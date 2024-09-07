

import 'package:farm_connect/screens/business/create_business_profile/personal_info.dart';
import 'package:farm_connect/screens/farmer/create_farmer_profile/personal.dart';
import 'package:flutter/material.dart';

class LandingPage extends StatefulWidget {
  final String userType;

  LandingPage({required this.userType});

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  String selectedPage = 'Home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FarmConnect'),
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              Scaffold.of(context).openDrawer(); // Opens the drawer
            },
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
              // User profile logic
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.lightGreenAccent,
              ),
              child: Text(
                'FarmConnect',
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Create Business Profile'),
              onTap: () {
                setState(() {
                  selectedPage = 'Create Business Profile';
                });
                Navigator.of(context).pop(); // Close the drawer
                // Implement navigation to Create Business Profile Screen
              },
            ),
            ListTile(
              leading: const Icon(Icons.agriculture),
              title: const Text('Create Farmer Profile'),
              onTap: () {
                setState(() {
                  selectedPage = 'Create Farmer Profile';
                });
                Navigator.of(context).pop(); // Close the drawer
                // Implement navigation to Create Farmer Profile Screen
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                setState(() {
                  selectedPage = 'Settings';
                });
                Navigator.of(context).pop(); // Close the drawer
                // Implement navigation to Settings Screen
              },
            ),
            Divider(),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Log Out'),
              onTap: () {
                Navigator.of(context).pop(); // Close the drawer
                Navigator.pushReplacementNamed(context, '/signin');
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Welcome to FarmConnect',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            widget.userType == 'Farmer'
                ? _buildFarmerOptions(context)
                : _buildBusinessOptions(context),
          ],
        ),
      ),
    );
  }

  Widget _buildFarmerOptions(BuildContext context) {
    return Column(
      children: [
        Card(
          color: Colors.green,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text(
                  'Have not created farmer profile?',
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    // Navigate to Farmer Profile Creation
                    Navigator.push(
                    context,
                    MaterialPageRoute(
                    builder: (context) => CreateFarmerPersonalProfile(),
                    ),
                    );
                  },
                  child: Text('Create Farmer Profile'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange, // background
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'or',
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    // Navigate to Farmer Home Page
                  },
                  child: Text('Go to Home Page'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange, // background
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBusinessOptions(BuildContext context) {
    return Column(
      children: [
        Card(
          color: Colors.blueGrey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text(
                  'Have not created business profile?',
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    // Navigate to Business Profile Creation
                    Navigator.push(
                    context,
                    MaterialPageRoute(
                    builder: (context) => BusinessPersonalInfoPage(),
                    ),
                    );
                  },
                  child: Text('Create Business Profile'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange, // background
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'or',
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    // Navigate to Business Home Page
                  },
                  child: Text('Go to Home Page'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange, // background
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
