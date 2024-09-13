
import 'package:flutter/material.dart';

import './edit_contact.dart';
import './edit_farm_info.dart';
import '../home_page.dart';
import '../list_product_page/list_product.dart';
import '../manage_order/manage_orders.dart';
import '../../../data/currentuser.dart';

class FarmerProfilePage extends StatefulWidget {

  @override
  _FarmerProfilePageState createState() => _FarmerProfilePageState();

}
 
class _FarmerProfilePageState extends State<FarmerProfilePage> {
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
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => FarmerHomePage()),
                );
              }
            ),
            ListTile(
              leading: const Icon(Icons.add_circle),
              title: const Text('List product'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => ListProductPage()),
                );
              },

            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Profile'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => FarmerProfilePage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            const Divider(),
            ListTile(
              leading: Icon(Icons.logout),
              title: const Text('Log Out'),
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
              const CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('images/placeholder_img.png'), // Placeholder image
              ),
              const SizedBox(height: 10),
              Text(currentUser.fullName ?? 'Name not provided', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              //Text('John Smith', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              const Text('Farmer', style: TextStyle(color: Colors.grey, fontSize: 16)),
              const SizedBox(height: 20),

              // Contact Information Card
              Card(
                child: ListTile(
                  title: const Text('Contact Information'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          const Icon(Icons.location_on, color: Colors.grey),
                          const SizedBox(width: 10),
                          //Text(contactInfo['location']),
                           Text(currentUser.address ?? 'Location not provided'),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          const Icon(Icons.phone, color: Colors.grey),
                          const SizedBox(width: 10),
                          //Text(contactInfo['phone']),
                          Text(currentUser.contactNumber ?? 'Contact not provided'),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          const Icon(Icons.email, color: Colors.grey),
                          const SizedBox(width: 10),
                          //Text(contactInfo['email']),
                          Text(currentUser.email ?? 'Email not provided'),
                        ],
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                  trailing: ElevatedButton(
                    onPressed: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => EditContactInfoPage()),
                      );
                      setState(() {});
                    },
                    child:const Text('Edit'),
                  ),
                ),
              ),

              // Farm Information Card
              Card(
                child: ListTile(
                  title: const Text('Farm Information'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10),
                      Row(
                        children: [
                          const Icon(Icons.home, color: Colors.grey),
                          const SizedBox(width: 10),
                          //Text(farmInfo['farmName']),
                          Text(currentUser.farmName ?? 'Farm name not provided'),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          const Icon(Icons.location_on, color: Colors.grey),
                          const SizedBox(width: 10),
                          Text(currentUser.farmAddress ?? 'Farm address not provided'),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          const Icon(Icons.info, color: Colors.grey),
                          const SizedBox(width: 10),
                         // Expanded(child: Text(farmInfo['description'])),
                          Expanded(child: Text(currentUser.farmDescription ?? 'No farm description provided')),
                        ],
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                  trailing: ElevatedButton(
                    onPressed: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => EditFarmInfoPage()),
                      );
                      setState(() {});
                    },
                    child: const Text('Edit'),
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
              MaterialPageRoute(builder: (context) => FarmerProfilePage()), // Replace with your Orders page
            );
              break;
          }
        },
        items: const [
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
