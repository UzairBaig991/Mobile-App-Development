import 'package:flutter/material.dart';

void main() => runApp(const RestaurantApp());

class RestaurantApp extends StatelessWidget {
  const RestaurantApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Restaurant App',
      home: RestaurantHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class RestaurantHomePage extends StatelessWidget {
  const RestaurantHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final drawerItems = [
      (Icons.home, 'Home'),
      (Icons.restaurant_menu, 'Menu'),
      (Icons.info, 'About Us'),
      (Icons.contact_support, 'Contact Us'),
    ];

    final menuItems = [
      (Icons.fastfood, 'Classic Burger', 'Juicy beef patty with cheese', 'Rs. 250'),
      (Icons.local_pizza, 'Cheese Pizza', 'Wood-fired cheesy pizza', 'Rs. 450'),
      (Icons.local_drink, 'Cold Coffee', 'Chilled creamy coffee', 'Rs. 150'),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Restaurant'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: Colors.deepPurple),
              accountName: Text('Uzair Baig'),
              accountEmail: Text('baiguzaiur53@gmail.com'),
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('web/Image/profile.jpeg'),
              ),
            ),
            ...drawerItems.map((item) => ListTile(
                  leading: Icon(item.$1),
                  title: Text(item.$2),
                  onTap: () => Navigator.pop(context),
                )),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(
              'https://images.unsplash.com/photo-1504674900247-0877df9cc836?w=800&auto=format&fit=crop&q=60',
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 10),
            const Text(
              'Welcome to Our Restaurant',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            ...menuItems.map((item) => Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    leading: Icon(item.$1, color: Colors.deepPurple),
                    title: Text(item.$2),
                    subtitle: Text(item.$3),
                    trailing: Text(
                      item.$4,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
