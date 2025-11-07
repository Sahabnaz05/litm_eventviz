class EventModel {
  final String id;
  final String name;
  final DateTime date;
  final String location;
  final String city;
  final String? description;
  final String? imageUrl;

  EventModel({
    required this.id,
    required this.name,
    required this.date,
    required this.location,
    required this.city,
    this.description,
    this.imageUrl,
  });

  factory EventModel.fromMap(String id, Map<String, dynamic> m) {
    return EventModel(
      id: id,
      name: m['name'] ?? '',
      date: (m['date']).toDate(),
      location: m['location'] ?? '',
      city: m['city'] ?? '',
      description: m['description'],
      imageUrl: m['imageUrl'],
    );
  }
}
