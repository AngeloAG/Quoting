import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Center(
        child: ElevatedButton(
            onPressed: () {
              context.beamToNamed('/');
            },
            child: const Text('Quotes')),
      ),
    );
  }
}
