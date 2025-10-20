import 'package:flutter/material.dart';
import 'dart:async'; // Para temporizador
import 'pages/login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'OCELOTL App',
      home: const SplashScreen(), // Pantalla inicial
    );
  }
}
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _bounceAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2, milliseconds: 200),
    )..repeat(reverse: true);
    
    _bounceAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticInOut,
    );
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginPage()),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(0, 0, 0, 1),
      body: Center(
        child: ScaleTransition(
          scale: _bounceAnimation,
          child: Image.asset(
            'assets/jaguar.png',
            width: 600,
            height: 600,
          ),
        ),
      ),
    );
  }
}


