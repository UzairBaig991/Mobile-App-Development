import 'package:flutter/material.dart';
import 'utils/constants.dart';

void main() {
  runApp(const ComprehensiveWidgetsApp());
}

class ComprehensiveWidgetsApp extends StatelessWidget {
  const ComprehensiveWidgetsApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConstants.appTitle,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const DashboardScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

// ============================================================================
// 1. SHALLOW TREE COMPONENT: Custom TopBar Widget
// ============================================================================
class CustomTopBarWidget extends StatelessWidget {
  final String userName;
  final String userEmail;

  const CustomTopBarWidget({
    Key? key,
    required this.userName,
    required this.userEmail,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Uses CircleAvatar, Text, and IconButton widgets in a shallow layout
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.deepPurple.shade50,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.deepPurple.shade200),
      ),
      child: Row(
        children: [
          // CircleAvatar Widget
          const CircleAvatar(
            radius: 30,
            backgroundColor: Colors.deepPurple,
            child: Icon(Icons.person, size: 35, color: Colors.white),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  userName,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  userEmail,
                  style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.notifications_active, color: Colors.deepPurple),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// 2. DASHBOARD SCREEN WITH MULTIPLE WIDGETS
// ============================================================================
class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  bool _isDarkMode = false;
  double _sliderValue = 50.0;
  bool _switchValue = true;
  String _selectedChip = 'Flutter';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Widgets Showcase Dashboard'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(_isDarkMode ? Icons.dark_mode : Icons.light_mode),
            onPressed: () {
              setState(() {
                _isDarkMode = !_isDarkMode;
              });
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Custom TopBar Widget containing CircleAvatar & Text
            const CustomTopBarWidget(
              userName: 'Alex Johnson',
              userEmail: 'alex.johnson@flutter.dev',
            ),
            const SizedBox(height: 20),

            // Divider Widget
            const Divider(thickness: 2, color: Colors.deepPurpleAccent),
            const SizedBox(height: 10),

            // Switch Widget (SwitchListTile)
            SwitchListTile(
              title: const Text('Enable Notifications', style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text('Status: ${_switchValue ? "Active" : "Disabled"}'),
              value: _switchValue,
              onChanged: (value) {
                setState(() {
                  _switchValue = value;
                });
              },
            ),

            const SizedBox(height: 10),
            const Divider(thickness: 1),
            const SizedBox(height: 10),

            // Slider Widget
            Text(
              'Slider Value: ${_sliderValue.toInt()}%',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Slider(
              value: _sliderValue,
              min: 0,
              max: 100,
              divisions: 10,
              label: _sliderValue.round().toString(),
              onChanged: (value) {
                setState(() {
                  _sliderValue = value;
                });
              },
            ),

            const SizedBox(height: 10),
            const Divider(thickness: 1),
            const SizedBox(height: 10),

            // Chip Widgets
            const Text(
              'Select Technology (Chip Widgets):',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8.0,
              children: ['Flutter', 'Dart', 'Android', 'Compose'].map((tech) {
                return ChoiceChip(
                  label: Text(tech),
                  selected: _selectedChip == tech,
                  onSelected: (selected) {
                    setState(() {
                      _selectedChip = tech;
                    });
                  },
                );
              }).toList(),
            ),

            const SizedBox(height: 20),
            const Divider(thickness: 2, color: Colors.deepPurpleAccent),
            const SizedBox(height: 10),

            // Card and Icon widgets with Vertical Dividers
            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: const [
                    Column(
                      children: [
                        Icon(Icons.star, color: Colors.amber, size: 30),
                        SizedBox(height: 4),
                        Text('Rating', style: TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                    VerticalDivider(width: 20, thickness: 1, color: Colors.grey),
                    Column(
                      children: [
                        Icon(Icons.verified, color: Colors.blue, size: 30),
                        SizedBox(height: 4),
                        Text('Verified', style: TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                    VerticalDivider(width: 20, thickness: 1, color: Colors.grey),
                    Column(
                      children: [
                        Icon(Icons.code, color: Colors.green, size: 30),
                        SizedBox(height: 4),
                        Text('Code', style: TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
