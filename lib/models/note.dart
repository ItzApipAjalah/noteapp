// note.dart
class Note {
  final String id;
  final String title;
  final String description;
  final DateTime createdAt;
  final String? imagePath; // Tambahkan atribut imagePath

  Note({
    required this.id,
    required this.title,
    required this.description,
    required this.createdAt,
    this.imagePath, // Inisialisasi imagePath
  });

  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      createdAt: DateTime.parse(json['createdAt']),
      imagePath: json['imagePath'], // Inisialisasi imagePath
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'createdAt': createdAt.toIso8601String(),
      'imagePath': imagePath, // Tambahkan imagePath ke JSON
    };
  }
}
