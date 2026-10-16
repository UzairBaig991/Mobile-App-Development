import 'package:flutter/material.dart';

void main() {
  runApp(const MyCvApp());
}

class MyCvApp extends StatelessWidget {
  const MyCvApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Uzair Baig - Riphah Student',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: const CvHomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

// ============================================================================
// SHALLOW TREE COMPONENTS
// ============================================================================

// 1. Profile Header with CircleAvatar & Circular Border Ring
class ProfileHeader extends StatelessWidget {
  const ProfileHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // CircleAvatar with circular border ring
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.teal, width: 3),
            boxShadow: [
              BoxShadow(
                color: Colors.teal.withOpacity(0.3),
                blurRadius: 10,
                spreadRadius: 2,
              ),
            ],
          ),
          child: const CircleAvatar(
            radius: 60,
            backgroundImage: AssetImage('assets/images/profile.jpeg'),
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          'Uzair Baig',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.teal),
        ),
        const SizedBox(height: 4),
        Text(
          'Software Engineering Student',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.grey.shade700),
        ),
        const SizedBox(height: 6),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.school, size: 16, color: Colors.teal),
            SizedBox(width: 6),
            Text(
              'Riphah International University',
              style: TextStyle(fontSize: 14, color: Colors.teal, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ],
    );
  }
}

// 2. Section Card Component (Shallow Tree Structure)
class CvSectionCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Widget child;

  const CvSectionCard({
    Key? key,
    required this.title,
    required this.icon,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: Colors.teal),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.teal),
                ),
              ],
            ),
            const Divider(height: 20, thickness: 1),
            child,
          ],
        ),
      ),
    );
  }
}

// 3. Contact Information Footer Component (Placed at the bottom)
class ContactFooter extends StatelessWidget {
  const ContactFooter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.teal.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.teal.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            'Contact Information',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.teal),
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Icon(Icons.email, size: 18, color: Colors.teal),
              SizedBox(width: 10),
              Text('55225@students.riphah.edu.pk', style: TextStyle(fontSize: 14)),
            ],
          ),
          SizedBox(height: 6),
          Row(
            children: [
              Icon(Icons.phone, size: 18, color: Colors.teal),
              SizedBox(width: 10),
              Text('+92 314 5487196', style: TextStyle(fontSize: 14)),
            ],
          ),
          SizedBox(height: 6),
          Row(
            children: [
              Icon(Icons.location_on, size: 18, color: Colors.teal),
              SizedBox(width: 10),
              Text('Islamabad / Rawalpindi, Pakistan', style: TextStyle(fontSize: 14)),
            ],
          ),
          SizedBox(height: 6),
          Row(
            children: [
              Icon(Icons.code, size: 18, color: Colors.teal),
              SizedBox(width: 10),
              Text('github.com/uzairbaigg991', style: TextStyle(fontSize: 14)),
            ],
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// MAIN CV SCREEN
// ============================================================================
class CvHomeScreen extends StatelessWidget {
  const CvHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Short CV'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Profile Header with CircleAvatar
            const ProfileHeader(),
            const SizedBox(height: 20),

            // Paragraph About Me (Software Engineering student at Riphah)
            CvSectionCard(
              title: 'About Me',
              icon: Icons.person,
              child: const Text(
                'I am a passionate and dedicated Software Engineering student currently studying at Riphah International University. '
                'I have a strong academic foundation in object-oriented programming, algorithms, data structures, and software design principles. '
                'I am deeply enthusiastic about mobile application development, especially creating sleek, performant, and user-friendly apps using Flutter and Dart. '
                'I thrive in collaborative environments and am constantly eager to learn new technologies and build impactful software solutions.',
                style: TextStyle(fontSize: 15, height: 1.5, color: Colors.black87),
              ),
            ),

            // Education Section
            CvSectionCard(
              title: 'Education',
              icon: Icons.school,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Bachelor of Science in Software Engineering (BSSE)',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Riphah International University | 2023 - 2027 (Expected)',
                    style: TextStyle(color: Colors.grey, fontSize: 13),
                  ),
                  SizedBox(height: 6),
                  Text(
                    'Relevant Coursework: Mobile Application Development, Object-Oriented Programming, Data Structures, Software Engineering.',
                    style: TextStyle(fontSize: 14, color: Colors.black87),
                  ),
                ],
              ),
            ),

            // Skills Section
            CvSectionCard(
              title: 'Skills & Expertise',
              icon: Icons.star,
              child: Wrap(
                spacing: 8.0,
                runSpacing: 4.0,
                children: [
                  'Flutter',
                  'Dart',
                  'Java / Kotlin',
                  'C++',
                  'Object-Oriented Programming',
                  'Data Structures',
                  'UI/UX Design',
                  'Git & GitHub',
                  'Firebase',
                ].map((skill) {
                  return Chip(
                    label: Text(skill),
                    backgroundColor: Colors.teal.shade50,
                    labelStyle: const TextStyle(color: Colors.teal, fontWeight: FontWeight.bold),
                  );
                }).toList(),
              ),
            ),

            const SizedBox(height: 10),

            // Contact Information at the bottom
            const ContactFooter(),
          ],
        ),
      ),
    );
  }
}
