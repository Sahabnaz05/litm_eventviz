import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final name = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  String? error;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: name, decoration: const InputDecoration(labelText: 'Name')),
            TextField(controller: email, decoration: const InputDecoration(labelText: 'Email')),
            TextField(controller: password, decoration: const InputDecoration(labelText: 'Password'), obscureText: true),
            const SizedBox(height: 12),
            if (error != null) Text(error!, style: const TextStyle(color: Colors.red)),
            FilledButton(
              onPressed: () async {
                try {
                  final cred = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                    email: email.text.trim(),
                    password: password.text,
                  );
                  await FirebaseFirestore.instance.collection('users').doc(cred.user!.uid).set({
                    'name': name.text.trim(),
                    'email': email.text.trim(),
                    'city': '',
                    'createdAt': FieldValue.serverTimestamp(),
                  });
                  if (mounted) Navigator.pop(context);
                } on FirebaseAuthException catch (e) {
                  setState(() => error = e.message);
                }
              },
              child: const Text('Create'),
            ),
          ],
        ),
      ),
    );
  }
}
