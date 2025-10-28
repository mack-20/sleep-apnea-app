import 'package:flutter/material.dart';

class ProfileListPage extends StatelessWidget {
  const ProfileListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profiles')),
      body: const Center(
        child: Text('List of saved profiles will appear here'),
      ),
    );
  }
}
