
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
      backgroundColor: const Color(0xFFE0F7FA),
      appBar: AppBar(
        title: const Text('FarmConnect',style: TextStyle(fontWeight: FontWeight.bold),),
        centerTitle: true,
      ),
      drawer: Drawer(
        child: Container(
          color: Colors.white,
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              const DrawerHeader(
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
              ListTile(
                leading: const Icon(Icons.home, color: Colors.green),
                title: const Text('Home'),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => FarmerHomePage()));
                },
              ),
              ListTile(
                leading: const Icon(Icons.add_circle, color: Colors.green),
                title: const Text('List Product'),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => ListProductPage()));
                },
              ),
              ListTile(
                leading: const Icon(Icons.person, color: Colors.green),
                title: const Text('Profile'),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => FarmerProfilePage()));
                },
              ),
              ListTile(
                leading: const Icon(Icons.settings, color: Colors.green),
                title: const Text('Settings'),
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
              Divider(color: Colors.grey[300]),
              ListTile(
                leading: const Icon(Icons.logout, color: Colors.red),
                title: const Text('Log Out'),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.pushReplacementNamed(context, '/signin');
                },
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
              height: 250,
              width: 400,

              child: Card(
                elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0)
              ),
            color: Colors.white,
                margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 32.0),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 32.0),
                  child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      const CircleAvatar(
                        radius: 50,
                        backgroundImage: AssetImage('images/placeholder_img.png'), // Placeholder image
                      ),
                      const SizedBox(height: 10),
                      Text(currentUser.fullName ?? 'Name not provided', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                      //Text('John Smith', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                      const Text('Farmer', style: TextStyle(color: Colors.black, fontSize: 16)),
                    ],
                ),
                ),


          ),
              ),
              const SizedBox(height: 20),

              // Contact Information Card
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0)
                ),
                color: Colors.white,
                child: ListTile(
                  title: const Text('Contact Information', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: Colors.green),),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                          const Icon(Icons.location_on, color: Colors.grey),
                          const SizedBox(width: 10),
                          //Text(contactInfo['location']),
                           Text(currentUser.address ?? 'Location not provided'),
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
                    child: const Text('Edit', style: TextStyle(color: Colors.white),),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurpleAccent,
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 4),
                      textStyle: const TextStyle(fontSize: 18),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0)
                      )
                    )
                    
                  ),
                ),
              ),

              // Farm Information Card
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0)
                ),
                color: Colors.white,
                child: ListTile(
                  title: const Text('Farm Information', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: Colors.green)),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
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
                          const Icon(Icons.info, color: Colors.grey),
                          const SizedBox(width: 10),
                          // Expanded(child: Text(farmInfo['description'])),
                          Expanded(child: Text(currentUser.farmDescription ?? 'No farm description provided')),
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
                    child: const Text('Edit', style: TextStyle(color: Colors.white),),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurpleAccent,
                          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 4),
                          textStyle: const TextStyle(fontSize: 18),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25.0)
                          )
                      )
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
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.black,
      ),
    );
  }
}
