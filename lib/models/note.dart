class Note {
  int id;
  String title;
  String content;
  DateTime modifiedTime;

  Note ({
    required this.id,
    required this.title,
    required this.content,
    required this.modifiedTime,
  });
}

List<Note> sampleNotes = [
  Note(
    id: 0,
    title: 'SampleNote 1',
    content: "Content 0",
    modifiedTime: DateTime(2022,1,1,34,5),
  ),
  Note(
    id: 1,
    title: 'SampleNote 2',
    content: "Content 1",
    modifiedTime: DateTime(2023,2,1,21,2),
  ),
  Note(
    id: 2,
    title: 'NoteSample 1',
    content: "Content 2",
    modifiedTime: DateTime(2024,2,1,21,2),
  ),
  Note(
    id: 3,
    title: 'NoteSample 2',
    content: "Content 4",
    modifiedTime: DateTime(2025,2,1,21,2),
  ),
];