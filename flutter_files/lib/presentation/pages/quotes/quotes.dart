import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';

class QuotesPage extends StatelessWidget {
  const QuotesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QuotesPage'),
      ),
      body: Center(
        child: ElevatedButton(
            onPressed: () {
              context.beamToNamed('login');
            },
            child: const Text('login')),
      ),
    );
  }
}
