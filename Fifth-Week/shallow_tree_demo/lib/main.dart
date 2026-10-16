import 'package:flutter/material.dart';

void main() {
  runApp(const ShallowTreeDemoApp());
}

class ShallowTreeDemoApp extends StatelessWidget {
  const ShallowTreeDemoApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shallow Tree Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true,
      ),
      home: const ShallowTreeHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

// ==========================================
// 1. SHALLOW TREE THROUGH A CLASS
// ==========================================
class CustomButtonCard extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onPressed;

  const CustomButtonCard({
    Key? key,
    required this.label,
    required this.icon,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // This keeps the widget tree shallow because complexity is encapsulated in a separate class.
    return Card(
      elevation: 3,
      child: ListTile(
        leading: Icon(icon, color: Colors.blueAccent),
        title: Text(label),
        trailing: ElevatedButton(
          onPressed: onPressed,
          child: const Text('Click'),
        ),
      ),
    );
  }
}

// ==========================================
// 3. OBJECT DATA MODEL FOR BUTTONS
// ==========================================
class ButtonItem {
  final String title;
  final IconData icon;
  final String message;

  ButtonItem({required this.title, required this.icon, required this.message});
}

class ShallowTreeHomePage extends StatefulWidget {
  const ShallowTreeHomePage({Key? key}) : super(key: key);

  @override
  State<ShallowTreeHomePage> createState() => _ShallowTreeHomePageState();
}

class _ShallowTreeHomePageState extends State<ShallowTreeHomePage> {
  String _statusMessage = 'Select a button below';

  // ==========================================
  // 2. SHALLOW TREE THROUGH A METHOD
  // ==========================================
  Widget _buildMethodButton(String label, Color color) {
    // Helper method keeping build method clean and shallow
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: color, foregroundColor: Colors.white),
        onPressed: () {
          setState(() {
            _statusMessage = 'Pressed Method Button: $label';
          });
        },
        child: Text(label),
      ),
    );
  }

  // Data list of button objects
  final List<ButtonItem> _buttonObjects = [
    ButtonItem(title: 'Object Button A', icon: Icons.star, message: 'Object A Clicked!'),
    ButtonItem(title: 'Object Button B', icon: Icons.favorite, message: 'Object B Clicked!'),
    ButtonItem(title: 'Object Button C', icon: Icons.bolt, message: 'Object C Clicked!'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shallow Tree Demo (Classes, Methods, Objects)'),
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Status Display
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.blue.shade200),
              ),
              child: Text(
                _statusMessage,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 20),

            const Text(
              '1. Shallow Tree via Class (Custom StatelessWidget)',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 8),
            // Using Class
            CustomButtonCard(
              label: 'Class Button 1',
              icon: Icons.class_,
              onPressed: () {
                setState(() {
                  _statusMessage = 'Pressed Class Button 1';
                });
              },
            ),
            CustomButtonCard(
              label: 'Class Button 2',
              icon: Icons.school,
              onPressed: () {
                setState(() {
                  _statusMessage = 'Pressed Class Button 2';
                });
              },
            ),

            const SizedBox(height: 20),
            const Text(
              '2. Shallow Tree via Method (Helper Function)',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 8),
            // Using Method
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildMethodButton('Method Red', Colors.red),
                _buildMethodButton('Method Green', Colors.green),
                _buildMethodButton('Method Orange', Colors.orange),
              ],
            ),

            const SizedBox(height: 20),
            const Text(
              '3. Shallow Tree via Objects (Data Model + Mapping)',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 8),
            // Using Objects mapped to widgets
            ..._buttonObjects.map((item) {
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 4),
                child: ListTile(
                  leading: Icon(item.icon, color: Colors.purple),
                  title: Text(item.title),
                  trailing: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _statusMessage = item.message;
                      });
                    },
                    child: const Text('Action'),
                  ),
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}
