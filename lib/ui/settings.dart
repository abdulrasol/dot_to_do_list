import 'package:flutter/material.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          // Account management
          ListTile(
            leading: Icon(Icons.account_circle),
            title: Text('Account Management'),
          ),
        ],
      ),
    );
  }
}
