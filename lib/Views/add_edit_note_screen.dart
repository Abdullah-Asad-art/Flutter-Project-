import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/note_model.dart';
import '../view_models/note_view_model.dart';
import '../view_models/auth_view_model.dart';

class AddEditNoteScreen extends StatelessWidget {
  final Note? note;

  const AddEditNoteScreen({this.note, super.key});

  @override
  Widget build(BuildContext context) {
    final titleController = TextEditingController(text: note?.title ?? '');
    final contentController = TextEditingController(text: note?.content ?? '');
    final noteViewModel = Provider.of<NoteViewModel>(context);
    final authViewModel = Provider.of<AuthViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(note == null ? 'Add Note' : 'Edit Note'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: contentController,
              decoration: const InputDecoration(labelText: 'Content'),
              maxLines: 5,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final newNote = Note(
                  noteId: note?.noteId,
                  title: titleController.text,
                  content: contentController.text,
                  createdAt: note?.createdAt ?? DateTime.now(),
                );

                if (note == null) {
                  await noteViewModel.addNote(authViewModel.currentUser!.uid, newNote);
                } else {
                  await noteViewModel.updateNote(newNote);
                }

                if (context.mounted) {
                  Navigator.pop(context);
                }
              },
              child: Text(note == null ? 'Add Note' : 'Update Note'),
            ),
          ],
        ),
      ),
    );
  }
}