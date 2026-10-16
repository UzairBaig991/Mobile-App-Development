import 'package:flutter/material.dart';

void main(){
  runApp(const TestApp());
}
class TestApp extends StatelessWidget {
  const TestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'My First Test App',
      home: HomePage(),
    );
  }
}
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My CV'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  const Text("Hello World !!!"),
                  const Divider(),
                  Container(
                    width: 100,
                    height: 100,
                    color: Colors.grey,
                  ),
                  const Text("Welcome"),
                  const Text("Welcome"),
                ],
              ),
              const SizedBox(height: 10),
              const CircleAvatar(
                radius: 100,
                backgroundImage: AssetImage('web/Image/profile.jpeg'),
                //child: Icon(Icons.person, size: 50),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Text("ABBCKJHGFGHJKJHGF"),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}