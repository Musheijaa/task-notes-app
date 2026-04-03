/// Core constants used throughout the application for UI text, database schema, and app configuration.
class UIText {
  // App title
  static const String appTitle = 'Task Notes';

  // Header section
  static const String darkTheme = 'Dark Theme';
  static const String darkThemeEnabled = 'Dark theme enabled';
  static const String darkThemeDisabled = 'Dark theme disabled';

  // Statistics section
  static const String total = 'Total';
  static const String pending = 'Pending';
  static const String completed = 'Completed';

  // Error and empty states
  static const String oops = 'Oops!';
  static const String noTasksYet = 'No Tasks Yet';
  static const String noTasksMessage = 'Create your first task to get started!';
  static const String retry = 'Retry';

  // Delete dialog
  static const String deleteTask = 'Delete Task';
  static const String deleteTaskConfirmation = 'Are you sure you want to delete this task?';
  static const String cancel = 'Cancel';
  static const String delete = 'Delete';

  // Add task screen
  static const String addNewTask = 'Add New Task';
  static const String formInstruction = 'Fill in the details below to create a new task';
  static const String taskTitleLabel = 'Task Title';
  static const String taskTitleHint = 'Enter task title';
  static const String titleRequired = 'Title is required';
  static const String titleTooShort = 'Title must be at least 3 characters';
  static const String titleTooLong = 'Title must be at most 100 characters';
  static const String priorityLabel = 'Priority Level';
  static const String descriptionLabel = 'Description (Optional)';
  static const String descriptionHint = 'Add more details about this task';
  static const String markAsCompleted = 'Mark as Completed';
  static const String markAsCompletedSubtitle = 'This task will start as completed';
  static const String creatingTask = 'Creating Task...';
  static const String createTask = 'Create Task';
}

class SuccessMessages {
  static const String taskCreated = '✓ Task created successfully!';
  static const String taskCompleted = '✓ Task marked as completed!';
  static const String taskMarkedPending = '✓ Task marked as pending!';
  static const String taskDeleted = '✓ Task deleted successfully!';
}

class ErrorMessages {
  static const String taskCreationError = '✗ Failed to create task. Please try again.';
  static const String taskDeletionError = '✗ Failed to delete task. Please try again.';
  static const String genericError = 'An error occurred. Please try again.';
}

class AppConstants {
  // Database table and column names
  static const String tasksTable = 'tasks';
  static const String idColumn = 'id';
  static const String titleColumn = 'title';
  static const String priorityColumn = 'priority';
  static const String descriptionColumn = 'description';
  static const String isCompletedColumn = 'is_completed';

  // Priority options
  static const String priorityHigh = 'High';
  static const String priorityMedium = 'Medium';
  static const String priorityLow = 'Low';
  
  static const List<String> priorityOptions = [
    priorityHigh,
    priorityMedium,
    priorityLow,
  ];

  // Form validation constraints
  static const int minTitleLength = 3;
  static const int maxTitleLength = 100;
  static const int maxDescriptionLength = 500;

  // UI dimensions
  static const double defaultBorderRadius = 12.0;
  static const double cardBorderRadius = 10.0;
  static const double defaultPadding = 16.0;
  static const double defaultMargin = 16.0;

  // Durations
  static const Duration snackbarShortDuration = Duration(seconds: 2);
  static const Duration snackbarLongDuration = Duration(seconds: 4);
  static const Duration animationDuration = Duration(milliseconds: 300);
}
