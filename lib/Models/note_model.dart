class Note {
  String? noteId;
  String title;
  String content;
  DateTime createdAt;

  Note({
    this.noteId,
    required this.title,
    required this.content,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'noteId': noteId,
      'title': title,
      'content': content,
      'createdAt': createdAt,
    };
  }

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      noteId: map['noteId'],
      title: map['title'],
      content: map['content'],
      createdAt: map['createdAt'].toDate(),
    );
  }
}