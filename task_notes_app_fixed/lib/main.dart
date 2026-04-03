import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:task_notes_app_fixed/theme.dart';
import 'package:task_notes_app_fixed/providers/task_provider.dart';
import 'package:task_notes_app_fixed/screens/home_screen.dart';
import 'package:task_notes_app_fixed/constants.dart';

/// Entry point of the Task Notes Manager application
///
/// Initializes the app with Firebase and Provider state management
/// and theme configuration for light/dark mode support.
void main() async {
  // Ensure Flutter is initialized
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const TaskNotesApp());
}

/// Root widget of the Task Notes Manager application
class TaskNotesApp extends StatelessWidget {
  const TaskNotesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TaskProvider()..initialize(),
      child: Consumer<TaskProvider>(
        builder: (context, taskProvider, child) {
          return MaterialApp(
            title: UIText.appTitle,
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: taskProvider.isDarkMode
                ? ThemeMode.dark
                : ThemeMode.light,
            home: const HomeScreen(),
          );
        },
      ),
    );
  }
}
