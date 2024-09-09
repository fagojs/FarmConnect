import 'package:flutter/material.dart';

import './edit_contact.dart';
import './edit_farm_info.dart';

import '../home_page.dart';
import '../list_product_page/list_product.dart';
import '../manage_order/manage_orders.dart';
import '../../../data/currentuser.dart';

class ProfilePage extends StatelessWidget {
  final Map<String, dynamic> contactInfo = {
    'name': currentUser.fullName,
    'location': currentUser.address,
    'phone': currentUser.contactNumber,
    'email': currentUser.email,
  };

  final Map<String, dynamic> farmInfo = {
    'farmName': currentUser.farmName,
    'location': currentUser.farmAddress,
    'description': currentUser.farmDescription,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FarmConnect'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.lightGreenAccent),
              child: Text(
                'FarmConnect',
                style: TextStyle(color: Colors.green, fontSize: 24),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () {
                Navigator.pop(context);
              }
            ),
            ListTile(
              leading: Icon(Icons.add_circle),
              title: Text('List product'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Profile'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Log Out'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushReplacementNamed(context, '/signin');
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('images/placeholder_img.png'), // Placeholder image
              ),
              SizedBox(height: 10),
              Text(currentUser.fullName ?? 'Name not provided', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              //Text('John Smith', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              Text('Farmer', style: TextStyle(color: Colors.grey, fontSize: 16)),
              SizedBox(height: 20),

              // Contact Information Card
              Card(
                child: ListTile(
                  title: Text('Contact Information'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Icon(Icons.location_on, color: Colors.grey),
                          SizedBox(width: 10),
                          //Text(contactInfo['location']),
                           Text(currentUser.address ?? 'Location not provided'),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Icon(Icons.phone, color: Colors.grey),
                          SizedBox(width: 10),
                          //Text(contactInfo['phone']),
                          Text(currentUser.contactNumber ?? 'Contact not provided'),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Icon(Icons.email, color: Colors.grey),
                          SizedBox(width: 10),
                          //Text(contactInfo['email']),
                          Text(currentUser.email ?? 'Email not provided'),
                        ],
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                  trailing: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => EditContactInfoPage(contactInfo: contactInfo)),
                      );
                    },
                    child: Text('Edit'),
                  ),
                ),
              ),

              // Farm Information Card
              Card(
                child: ListTile(
                  title: Text('Farm Information'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Icon(Icons.home, color: Colors.grey),
                          SizedBox(width: 10),
                          //Text(farmInfo['farmName']),
                          Text(currentUser.farmName ?? 'Farm name not provided'),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Icon(Icons.location_on, color: Colors.grey),
                          SizedBox(width: 10),
                          Text(currentUser.farmAddress ?? 'Farm address not provided'),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Icon(Icons.info, color: Colors.grey),
                          SizedBox(width: 10),
                         // Expanded(child: Text(farmInfo['description'])),
                          Expanded(child: Text(currentUser.farmDescription ?? 'No farm description provided')),
                        ],
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                  trailing: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => EditFarmInfoPage(farmInfo: farmInfo)),
                      );
                    },
                    child: Text('Edit'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 3, // Profile tab selected
        onTap: (index) {
          switch (index) {
            case 0:
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => FarmerHomePage()), // Replace with your Orders page
            );
              break;
            case 1:
              Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => ListProductPage()), // Replace with your Orders page
            );
              break;
            case 2:
              Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => OrdersPage()), // Replace with your Orders page
            );
              break;
            case 3:
              Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => ProfilePage()), // Replace with your Orders page
            );
              break;
          }
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.add_circle), label: 'List Product'),
          BottomNavigationBarItem(icon: Icon(Icons.checklist_rtl_sharp), label: 'Orders'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.black,
      ),
    );
  }
}
