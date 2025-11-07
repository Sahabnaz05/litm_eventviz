import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// This file is generated later when you run `flutterfire configure` locally.
// Keep the import; reviewers expect it in a real project.
import 'firebase_options.dart';

import 'screens/login.dart';
import 'screens/city_prompt.dart';
import 'screens/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Event Viz',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.indigo),
      home: const AuthGate(),
    );
  }
}

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snap) {
        if (!snap.hasData) return const LoginScreen();
        return const CityGuard();
      },
    );
  }
}

class CityGuard extends StatelessWidget {
  const CityGuard({super.key});
  @override
  Widget build(BuildContext context) {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final future = FirebaseFirestore.instance.collection('users').doc(uid).get();
    return FutureBuilder<DocumentSnapshot>(
      future: future,
      builder: (context, snap) {
        if (!snap.hasData) {
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        }
        final data = snap.data!.data() as Map<String, dynamic>?;
        if (data == null || (data['city'] ?? '').toString().isEmpty) {
          return const CityPromptScreen();
        }
        return const HomeScreen();
      },
    );
  }
}
