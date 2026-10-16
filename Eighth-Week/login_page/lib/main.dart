import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AuthScreen(),
    );
  }
}

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  // State for AnimatedCrossFade (Login vs Sign Up)
  bool _isLogin = true;

  // State for AnimatedOpacity and AnimatedScale (Image details & size)
  bool _isImageZoomed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isLogin ? 'Login' : 'Sign Up'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const SizedBox(height: 10),

            // Profile Picture - Tap to increase size & show details
            GestureDetector(
              onTap: () {
                setState(() {
                  _isImageZoomed = !_isImageZoomed;
                });
              },
              child: AnimatedScale(
                scale: _isImageZoomed ? 1.3 : 1.0,
                duration: const Duration(seconds: 3),
                curve: Curves.bounceOut, // Bouncing curve on image zoom
                child: const CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage('web/Image/profile.jpeg'),
                ),
              ),
            ),
            const SizedBox(height: 10),

            // AnimatedOpacity (3-second duration) for Image Details
            AnimatedOpacity(
              opacity: _isImageZoomed ? 1.0 : 0.0,
              duration: const Duration(seconds: 3),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.blue.shade200),
                ),
                child: const Column(
                  children: [
                    Text(
                      'Profile Picture Details',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'File: web/Image/profile.jpeg\nUser: Profile Account',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Bouncing Button to switch between pages
            BouncingButton(
              onPressed: () {
                setState(() {
                  _isLogin = !_isLogin;
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  _isLogin ? 'Switch to Sign Up Form' : 'Switch to Login Form',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // AnimatedCrossFade with Bouncing Curves
            AnimatedCrossFade(
              duration: const Duration(seconds: 3),
              firstCurve: Curves.bounceOut,
              secondCurve: Curves.bounceOut,
              crossFadeState: _isLogin
                  ? CrossFadeState.showFirst
                  : CrossFadeState.showSecond,
              firstChild: _buildLoginForm(),
              secondChild: _buildSignupForm(),
            ),
          ],
        ),
      ),
    );
  }

  // LOGIN FORM
  Widget _buildLoginForm() {
    return Column(
      key: const ValueKey('loginForm'),
      children: [
        const TextField(
          decoration: InputDecoration(
            labelText: 'Email',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 12),
        const TextField(
          obscureText: true,
          decoration: InputDecoration(
            labelText: 'Password',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 20),
        SizedBox(
          width: double.infinity,
          height: 45,
          child: BouncingButton(
            onPressed: () {},
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Text(
                'Login',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // SIGN UP FORM
  Widget _buildSignupForm() {
    return Column(
      key: const ValueKey('signupForm'),
      children: [
        const TextField(
          decoration: InputDecoration(
            labelText: 'Full Name',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 12),
        const TextField(
          decoration: InputDecoration(
            labelText: 'Email',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 12),
        const TextField(
          obscureText: true,
          decoration: InputDecoration(
            labelText: 'Password',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 20),
        SizedBox(
          width: double.infinity,
          height: 45,
          child: BouncingButton(
            onPressed: () {},
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Text(
                'Sign Up',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// BOUNCING BUTTON WIDGET
// ---------------------------------------------------------------------------
class BouncingButton extends StatefulWidget {
  final VoidCallback onPressed;
  final Widget child;

  const BouncingButton({
    super.key,
    required this.onPressed,
    required this.child,
  });

  @override
  State<BouncingButton> createState() => _BouncingButtonState();
}

class _BouncingButtonState extends State<BouncingButton> {
  double _scale = 1.0;

  void _onTapDown(TapDownDetails details) {
    setState(() {
      _scale = 0.85; // Scale down on tap down
    });
  }

  void _onTapUp(TapUpDetails details) {
    setState(() {
      _scale = 1.0; // Scale back up with bounce
    });
    widget.onPressed();
  }

  void _onTapCancel() {
    setState(() {
      _scale = 1.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      child: AnimatedScale(
        scale: _scale,
        duration: const Duration(milliseconds: 200),
        curve: Curves.bounceOut,
        child: widget.child,
      ),
    );
  }
}
