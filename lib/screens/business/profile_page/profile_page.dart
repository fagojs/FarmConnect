import 'package:flutter/material.dart';

import './edit_personal_info.dart';
import './edit_business_info.dart';
import '../cart_page.dart';
import '../category/category_page.dart';
import '../home_page.dart';
import '../../../data/currentuser.dart';

class BusinessProfilePage extends StatefulWidget {
  @override
  _BusinessProfilePageState createState() => _BusinessProfilePageState();
}

class _BusinessProfilePageState extends State<BusinessProfilePage> {
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
              Scaffold.of(context).openDrawer();
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
              ListTile(
                leading: Icon(Icons.home, color: Colors.green),
                title: Text('Home'),
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: Icon(Icons.shopping_cart, color: Colors.green),
                title: Text('Cart'),
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: Icon(Icons.category, color: Colors.green),
                title: Text('Categories'),
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: Icon(Icons.settings, color: Colors.green),
                title: Text('Settings'),
                onTap: () {
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
                        const Text('Business Owner', style: TextStyle(color: Colors.grey, fontSize: 16)),
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
                          MaterialPageRoute(builder: (context) => EditBusinessPersonalProfile()),
                        );
                        setState(() {});
                      },
                      child:const Text('Edit', style: TextStyle(color: Colors.white),),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurpleAccent,
                          padding: EdgeInsets.symmetric(horizontal: 32, vertical: 4),
                          textStyle: TextStyle(fontSize: 18),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25.0)
                          )
                      )

                  ),
                ),
              ),

              // Business Information Card
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0)
                ),
                color: Colors.white,
                child: ListTile(
                  title: const Text('Business Information', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: Colors.green)),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10),
                      Row(
                        children: [
                          const Icon(Icons.home, color: Colors.grey),
                          const SizedBox(width: 10),
                          //Text(farmInfo['farmName']),
                          Text(currentUser.businessName ?? 'Business name not provided'),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          const Icon(Icons.location_on, color: Colors.grey),
                          const SizedBox(width: 10),
                          Text(currentUser.businessAddress ?? 'Business address not provided'),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          const Icon(Icons.info, color: Colors.grey),
                          const SizedBox(width: 10),
                          // Expanded(child: Text(farmInfo['description'])),
                          Expanded(child: Text(currentUser.businessDescription ?? 'No Business description provided')),
                        ],
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                  trailing: ElevatedButton(
                      onPressed: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => EditBusinessInformation()),
                        );
                        setState(() {});
                      },
                      child: const Text('Edit', style: TextStyle(color: Colors.white),),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurpleAccent,
                          padding: EdgeInsets.symmetric(horizontal: 32, vertical: 4),
                          textStyle: TextStyle(fontSize: 18),
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
        currentIndex: 3,
        onTap: (index) {

          switch (index) {
            case 0:
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => BusinessOwnerHomePage()),
                );
              break;
            case 1:
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => CategoryPage()),
                );
              break;
            case 2:
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => CartPage()),
                );
              break;
            case 3:
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => BusinessProfilePage()),
                );
              break;
          }
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.category), label: 'List Product'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Orders'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.black,
      ),
    );
  }
}
