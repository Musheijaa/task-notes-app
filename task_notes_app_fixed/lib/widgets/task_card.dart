import 'package:flutter/material.dart';
import 'package:task_notes_app_fixed/models/task_item.dart';
import 'package:task_notes_app_fixed/theme.dart';
import 'package:task_notes_app_fixed/constants.dart';

/// A card widget displaying a single task item
/// 
/// Shows task title, description, priority badge, and completion status
/// with callbacks for completion toggle and deletion
class TaskCard extends StatelessWidget {
  final TaskItem task;
  final Function(bool) onCompletionChanged;
  final VoidCallback onDelete;

  const TaskCard({
    super.key,
    required this.task,
    required this.onCompletionChanged,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: AppConstants.defaultMargin,
        vertical: 8,
      ),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.cardBorderRadius),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(AppConstants.cardBorderRadius),
          onTap: () => onCompletionChanged(!task.isCompleted),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Checkbox for completion status
                Checkbox(
                  value: task.isCompleted,
                  onChanged: (value) => onCompletionChanged(value ?? false),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                const SizedBox(width: 12),
                
                // Task content (title, description, priority)
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Task title with strikethrough if completed
                      Text(
                        task.title,
                        style: theme.textTheme.titleMedium?.copyWith(
                          decoration: task.isCompleted
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                          color: task.isCompleted
                              ? colorScheme.onSurface.withValues(alpha: 0.5)
                              : colorScheme.onSurface,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      
                      // Task description if present
                      if (task.description.isNotEmpty) ...[
                        const SizedBox(height: 4),
                        Text(
                          task.description,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: colorScheme.onSurface.withValues(alpha: 0.6),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                      
                      // Priority badge
                      const SizedBox(height: 6),
                      _buildPriorityBadge(context),
                    ],
                  ),
                ),
                
                const SizedBox(width: 8),
                
                // Delete button
                IconButton(
                  icon: Icon(
                    Icons.delete_outline,
                    color: colorScheme.error.withValues(alpha: 0.7),
                    size: 20,
                  ),
                  onPressed: onDelete,
                  iconSize: 24,
                  constraints: const BoxConstraints(),
                  padding: const EdgeInsets.all(4),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Build priority badge with appropriate color
  Widget _buildPriorityBadge(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    
    Color badgeColor;
    switch (task.priority) {
      case AppConstants.priorityHigh:
        badgeColor = SemanticColors.danger(context);
        break;
      case AppConstants.priorityMedium:
        badgeColor = SemanticColors.warning(context);
        break;
      case AppConstants.priorityLow:
        badgeColor = SemanticColors.success(context);
        break;
      default:
        badgeColor = colorScheme.primary;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: badgeColor.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        task.priority,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
          color: badgeColor,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

/// Skeleton loader card for task list during loading state
class TaskCardSkeleton extends StatelessWidget {
  const TaskCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: AppConstants.defaultMargin,
        vertical: 8,
      ),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.cardBorderRadius),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Skeleton checkbox
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: colorScheme.surfaceContainer,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const SizedBox(width: 12),
              
              // Skeleton content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title skeleton
                    Container(
                      height: 16,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: colorScheme.surfaceContainer,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    const SizedBox(height: 8),
                    
                    // Description skeleton
                    Container(
                      height: 12,
                      width: 200,
                      decoration: BoxDecoration(
                        color: colorScheme.surfaceContainer,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    const SizedBox(height: 8),
                    
                    // Badge skeleton
                    Container(
                      height: 20,
                      width: 60,
                      decoration: BoxDecoration(
                        color: colorScheme.surfaceContainer,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
