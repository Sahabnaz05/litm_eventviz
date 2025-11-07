import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CityPromptScreen extends StatefulWidget {
  const CityPromptScreen({super.key});
  @override
  State<CityPromptScreen> createState() => _CityPromptScreenState();
}

class _CityPromptScreenState extends State<CityPromptScreen> {
  final city = TextEditingController();
  String? error;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Your City')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text('Enter your city to personalize events.'),
            const SizedBox(height: 8),
            TextField(controller: city, decoration: const InputDecoration(labelText: 'City')),
            const SizedBox(height: 12),
            if (error != null) Text(error!, style: const TextStyle(color: Colors.red)),
            FilledButton(
              onPressed: () async {
                try {
                  final uid = FirebaseAuth.instance.currentUser!.uid;
                  final c = city.text.trim();
                  if (c.isEmpty) {
                    setState(() => error = 'City is required');
                    return;
                  }
                  await FirebaseFirestore.instance.collection('users').doc(uid).update({'city': c});
                  if (mounted) setState(() {});
                } catch (e) {
                  setState(() => error = 'Could not save city');
                }
              },
              child: const Text('Save'),
            )
          ],
        ),
      ),
    );
  }
}
