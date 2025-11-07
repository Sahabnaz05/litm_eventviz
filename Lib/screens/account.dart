import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    return Scaffold(
      appBar: AppBar(title: const Text('Account')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Signed in as ${user.email}'),
          const SizedBox(height: 16),
          FilledButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              if (context.mounted) Navigator.pop(context);
            },
            child: const Text('Log out'),
          ),
          const SizedBox(height: 12),
          OutlinedButton(
            onPressed: () async {
              final uid = user.uid;
              // Delete profile first
              await FirebaseFirestore.instance.collection('users').doc(uid).delete().catchError((_) {});
              // Then delete the auth user
              await user.delete();
            },
            child: const Text('Delete account'),
          ),
        ]),
      ),
    );
  }
}
