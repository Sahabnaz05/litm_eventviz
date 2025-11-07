import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EventDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> event;
  const EventDetailsScreen({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    final dt = (event['date']).toDate();
    final dateStr = DateFormat.yMMMMd().add_jm().format(dt);
    return Scaffold(
      appBar: AppBar(title: Text(event['name'] ?? 'Event')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(dateStr, style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          Text(event['location'] ?? ''),
          const SizedBox(height: 12),
          Text(event['description'] ?? 'No description'),
        ]),
      ),
    );
  }
}
