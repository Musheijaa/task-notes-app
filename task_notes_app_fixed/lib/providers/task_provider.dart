import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:task_notes_app_fixed/models/task_item.dart';

class TaskProvider extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  
  // State management
  bool _isDarkMode = false;
  List<TaskItem> _tasks = [];
  bool _isLoading = false;
  String? _error;

  // Getters
  bool get isDarkMode => _isDarkMode;
  List<TaskItem> get tasks => _tasks;
  bool get isLoading => _isLoading;
  String? get error => _error;
  
  int get completedTasksCount => _tasks.where((task) => task.isCompleted).length;
  int get pendingTasksCount => _tasks.where((task) => !task.isCompleted).length;

  /// Initialize the provider and load tasks
  Future<void> initialize() async {
    await loadTasks();
  }

  /// Toggle dark mode and persist preference
  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
    // TODO: Persist theme preference to Firestore or local storage
  }

  /// Load all tasks from Firestore
  Future<void> loadTasks() async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      final snapshot = await _firestore
          .collection('tasks')
          .orderBy('id', descending: true)
          .get();

      _tasks = snapshot.docs
          .map((doc) => TaskItem.fromJson({...doc.data(), 'id': doc.id}))
          .toList();
      
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = 'Failed to load tasks: ${e.toString()}';
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Add a new task to Firestore
  Future<bool> addTask(TaskItem task) async {
    try {
      final docRef = _firestore.collection('tasks').doc();
      final taskWithId = task.copyWith(id: int.parse(docRef.id.hashCode.toString()));
      
      await docRef.set({
        'id': taskWithId.id,
        'title': taskWithId.title,
        'priority': taskWithId.priority,
        'description': taskWithId.description,
        'isCompleted': taskWithId.isCompleted,
        'createdAt': FieldValue.serverTimestamp(),
      });
      
      await loadTasks();
      return true;
    } catch (e) {
      _error = 'Failed to add task: ${e.toString()}';
      notifyListeners();
      return false;
    }
  }

  /// Delete a task from Firestore
  Future<bool> deleteTask(int id) async {
    try {
      // Find the document with matching id field
      final query = await _firestore
          .collection('tasks')
          .where('id', isEqualTo: id)
          .get();

      if (query.docs.isNotEmpty) {
        await query.docs.first.reference.delete();
      }
      
      await loadTasks();
      return true;
    } catch (e) {
      _error = 'Failed to delete task: ${e.toString()}';
      notifyListeners();
      return false;
    }
  }

  /// Toggle task completion status
  Future<void> toggleTaskCompletion(TaskItem task) async {
    try {
      // Find the document with matching id field
      final query = await _firestore
          .collection('tasks')
          .where('id', isEqualTo: task.id)
          .get();

      if (query.docs.isNotEmpty) {
        await query.docs.first.reference.update({
          'isCompleted': !task.isCompleted,
        });
      }
      
      await loadTasks();
    } catch (e) {
      _error = 'Failed to update task: ${e.toString()}';
      notifyListeners();
    }
  }
}
