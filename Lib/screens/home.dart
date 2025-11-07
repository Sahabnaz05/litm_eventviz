import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

import 'event_details.dart';
import 'account.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final users = FirebaseFirestore.instance.collection('users').doc(uid);

    return FutureBuilder<DocumentSnapshot>(
      future: users.get(),
      builder: (context, snap) {
        if (!snap.hasData) {
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        }
        final city = (snap.data!.data() as Map<String, dynamic>)['city'] as String;
        final events = FirebaseFirestore.instance
            .collection('events')
            .where('city', isEqualTo: city)
            .orderBy('date')
            .limit(3)
            .snapshots();

        return Scaffold(
          appBar: AppBar(title: Text('Events in $city'), actions: [
            IconButton(
              icon: const Icon(Icons.person),
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AccountScreen())),
            ),
          ]),
          body: StreamBuilder<QuerySnapshot>(
            stream: events,
            builder: (context, qsnap) {
              if (qsnap.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              final docs = qsnap.data?.docs ?? [];
              if (docs.isEmpty) {
                return const Center(child: Text('No events yet'));
              }
              return ListView.separated(
                itemCount: docs.length,
                separatorBuilder: (_, __) => const Divider(height: 1),
                itemBuilder: (context, i) {
                  final e = docs[i].data() as Map<String, dynamic>;
                  final dt = (e['date']).toDate();
                  final dateStr = DateFormat.yMMMMd().add_jm().format(dt);
                  return ListTile(
                    title: Text(e['name'] ?? ''),
                    subtitle: Text('$dateStr • ${e['location'] ?? ''}'),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => EventDetailsScreen(event: e)),
                    ),
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}
