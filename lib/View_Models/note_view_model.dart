import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/note_model.dart';

class NoteViewModel with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<Note> _notes = [];
  List<Note> get notes => _notes;

  Future<void> fetchNotes(String userId) async {
    try {
      final snapshot = await _firestore
          .collection('notes')
          .where('userId', isEqualTo: userId)
          .get();
      _notes = snapshot.docs.map((doc) => Note.fromMap(doc.data())).toList();
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addNote(String userId, Note note) async {
    try {
      final docRef = await _firestore.collection('notes').add({
        ...note.toMap(),
        'userId': userId,
      });
      note.noteId = docRef.id;
      _notes.add(note);
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateNote(Note note) async {
    try {
      await _firestore.collection('notes').doc(note.noteId).update(note.toMap());
      final index = _notes.indexWhere((n) => n.noteId == note.noteId);
      _notes[index] = note;
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteNote(String noteId) async {
    try {
      await _firestore.collection('notes').doc(noteId).delete();
      _notes.removeWhere((note) => note.noteId == noteId);
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }
}