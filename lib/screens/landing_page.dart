import 'package:farm_connect/screens/business/create_business_profile/personal_info.dart';
import 'package:farm_connect/screens/business/home_page.dart';
import 'package:farm_connect/screens/farmer/create_farmer_profile/personal.dart';
import 'package:farm_connect/screens/farmer/home_page.dart';
import 'package:farm_connect/screens/signup_page.dart';
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
      backgroundColor: Color(0xFFE0F7FA),
      appBar: AppBar(
        title: Text('FarmConnect',style: TextStyle(fontWeight: FontWeight.bold),),
        centerTitle: true,
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              Scaffold.of(context).openDrawer(); // Opens the drawer
            },
          ),
        ),
      ),
      drawer: Drawer(
        child: Container(
          color: Colors.white,
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.green,
                ),
                child: Center(
                  child: Text(
                    'FarmConnect',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              widget.userType == 'Farmer'
                  ? ListTile(
                leading: Icon(Icons.person, color: Colors.green),
                title: Text('Create Business Profile'),
                onTap: () {
                  setState(() {
                    selectedPage = 'Create Business Profile';
                  });
                  Navigator.of(context).pop();
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SignUpPage()));
                },
              )
                  : ListTile(
                leading: Icon(Icons.person, color: Colors.green),
                title: Text('Create Farmer Profile'),
                onTap: () {
                  setState(() {
                    selectedPage = 'Create Farmer Profile';
                  });
                  Navigator.of(context).pop();
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SignUpPage()));
                },
              ),
              widget.userType == 'Farmer'
                  ? ListTile(
                leading: Icon(Icons.agriculture, color: Colors.green),
                title: Text('Create Farmer Profile'),
                onTap: () {
                  setState(() {
                    selectedPage = 'Create Farmer Profile';
                  });
                  Navigator.of(context).pop();
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              CreateFarmerPersonalProfile()));
                },
              )
                  : ListTile(
                leading: Icon(Icons.agriculture, color: Colors.green),
                title: Text('Create Business Profile'),
                onTap: () {
                  setState(() {
                    selectedPage = 'Create Business Profile';
                  });
                  Navigator.of(context).pop();
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              BusinessPersonalInfoPage()));
                },
              ),
              ListTile(
                leading: Icon(Icons.settings, color: Colors.green),
                title: Text('Settings'),
                onTap: () {
                  setState(() {
                    selectedPage = 'Settings';
                  });
                  Navigator.of(context).pop();
                },
              ),
              Divider(color: Colors.grey[300]),
              ListTile(
                leading: Icon(Icons.logout, color: Colors.red),
                title: Text('Log Out'),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.pushReplacementNamed(context, '/signin');
                },
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child:Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            color: Colors.white,
            child: Padding(padding: EdgeInsets.all(24.0),
            child: Column(
              children: [
                Text('Welcome to FarmConnect',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      color: widget.userType== 'Farmer' ? Colors.green : Colors.blue[900]),)
              ],
            ),
            ),
          ),
          const SizedBox(height: 20,),
          _buildUserOptions(context)
        ]
      ),
      ),
    );
  }

  Widget _buildUserOptions(BuildContext context) {
    return Column(
      children: [
        Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          color: widget.userType == 'Farmer' ? Colors.green[100] : Colors.blue[100],
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 32.0,horizontal: 32.0),
            child: Column(
              children: [
                Text(
                  'Have not created ${(widget.userType).toLowerCase()} profile?',
                  style: TextStyle(color: widget.userType== 'Farmer' ? Colors.green : Colors.blue[900],
                      fontSize: 18,fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    // Navigate to Farmer Profile Creation
                    Navigator.push(
                    context,
                    MaterialPageRoute(
                    builder: (context){
                      return widget.userType == 'Farmer' ? CreateFarmerPersonalProfile() : BusinessPersonalInfoPage();
                    }));
                  },
                  child: Text('Create ${(widget.userType)} Profile',style: TextStyle(fontWeight: FontWeight.w400,fontSize: 18,color: Colors.white),),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: widget.userType== 'Farmer'?Colors.green: Colors.blue[900],
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0)
                    )// background
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  'OR',
                  style: TextStyle(color: Colors.green[800],fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    // Navigate to Farmer Home Page
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context){
                        return widget.userType == 'Farmer'? FarmerHomePage() : BusinessOwnerHomePage();
                      }));
                  },
                  child: Text('Go to Home Page',style: TextStyle(fontWeight: FontWeight.w400,fontSize: 18,color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: widget.userType== 'Farmer' ? Colors.green : Colors.blue[900] ,
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0),// background
                  ),
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
