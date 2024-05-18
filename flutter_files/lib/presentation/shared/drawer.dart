import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 50.0, bottom: 10.0),
            child: const ListTile(
              title: Text('Menu'),
              dense: true,
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(0.0),
              children: const [
                ListTile(
                  title: Text('Settings'),
                )
              ],
            ),
          ),
          ElevatedButton(
              onPressed: () {
                context.beamToNamed('/login');
              },
              child: const Text('Login')),
          const SizedBox(
            height: 10.0,
          )
        ],
      ),
    );
  }
}
