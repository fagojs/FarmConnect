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
      appBar: AppBar(
        title: const Text('FarmConnect',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),
        backgroundColor: Colors.green,
        centerTitle: true,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu,color: Colors.white,),
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
                leading:const Icon(Icons.home, color: Colors.green),
                title: const Text('Home'),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => BusinessOwnerHomePage()),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.shopping_cart, color: Colors.green),
                title: const Text('Cart'),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => CartPage()),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.category, color: Colors.green),
                title: const Text('Categories'),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => CategoryPage()),
                  );
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
      body:Stack(
          children: [
      Container(
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
    ),
            SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 250,
                width: double.infinity,

                child:  Padding(
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
                        const Text('Business Owner', style: TextStyle(color: Colors.black, fontSize: 16)),
                      ],

                  ),


                ),
              ),

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
                          const SizedBox(width: 4),
                          //Text(contactInfo['email']),
                          Text(currentUser.email ?? 'Email not provided'),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          const Icon(Icons.phone, color: Colors.grey),
                          const SizedBox(width: 4),
                          //Text(contactInfo['phone']),
                          Text(currentUser.contactNumber ?? 'Contact not provided'),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          const Icon(Icons.location_on, color: Colors.grey),
                          const SizedBox(width: 4),
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
                          MaterialPageRoute(builder: (context) => EditBusinessPersonalProfile()),
                        );
                        setState(() {});
                      },
                      child:const Text('Edit', style: TextStyle(color: Colors.white),),
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
              const SizedBox(height: 16,),
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
                      const SizedBox(height: 10),


                      Row(
                        children: [
                          const Icon(Icons.home, color: Colors.grey),
                          const SizedBox(width: 4),
                          //Text(farmInfo['farmName']),
                          Expanded(child: Text(currentUser.businessName ?? 'Business name not provided'),)

                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          const Icon(Icons.info, color: Colors.grey),
                          const SizedBox(width: 4),
                          // Expanded(child: Text(farmInfo['description'])),
                          Expanded(child: Text(currentUser.businessDescription ?? 'No Business description provided')),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          const Icon(Icons.location_on, color: Colors.grey),
                          const SizedBox(width: 4),
                          Expanded(child: Text(currentUser.businessAddress ?? 'Business address not provided'),)

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
      ),]),
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
        items: const [
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
