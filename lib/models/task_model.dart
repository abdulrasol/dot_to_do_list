import 'dart:convert';

class TaskModel {
  String id; // معرف فريد للمهمة
  String title; // عنوان المهمة
  String? description; // وصف المهمة (اختياري)
  DateTime dueDate; // تاريخ استحقاق المهمة
  bool isCompleted; // حالة اكتمال المهمة
  Priority priority; // أولوية المهمة (مرتفعة، متوسطة، منخفضة)
  bool hasReminder; // هل تم تفعيل التذكير
  DateTime? reminderTime; // وقت التذكير (اختياري إذا كان hasReminder = true)
  DateTime createdAt; // وقت إنشاء المهمة
  DateTime? updatedAt; // وقت آخر تعديل للمهمة (اختياري)

  // Constructor
  TaskModel({
    required this.id,
    required this.title,
    this.description,
    required this.dueDate,
    this.isCompleted = false,
    this.priority = Priority.medium,
    this.hasReminder = false,
    this.reminderTime,
    required this.createdAt,
    this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      //'dueDate': dueDate,
      'dueDate': dueDate.toIso8601String(),
      'isCompleted': isCompleted,
      // 'priority': priority,
      'priority': priority.index,
      'hasReminder': hasReminder,
      //'reminderTime': reminderTime,
      'reminderTime': reminderTime?.toIso8601String(),
      //'createdAt': createdAt,
      'createdAt': createdAt.toIso8601String(),
      //'updatedAt': updatedAt,
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  static TaskModel fromJson(String data) {
    Map<String, dynamic> task = jsonDecode(data);
    return TaskModel(
      id: task['id'],
      title: task['title'],
      description: task['description'],
      dueDate: DateTime.parse(task['dueDate']),
      isCompleted: task['isCompleted'],
      priority: Priority.values[task['priority']],
      hasReminder: task['hasReminder'],
      reminderTime: task['reminderTime'] != null
          ? DateTime.parse(task['reminderTime'])
          : null,
      createdAt: DateTime.parse(task['createdAt']),
      updatedAt:
          task['updatedAt'] != null ? DateTime.parse(task['updatedAt']) : null,
    );
  }

  static TaskModel fromMap(Map task) {
    return TaskModel(
      id: task['id'],
      title: task['title'],
      description: task['description'],
      dueDate: DateTime.parse(task['dueDate']),
      isCompleted: task['isCompleted'],
      priority: Priority.values[task['priority']],
      hasReminder: task['hasReminder'],
      reminderTime: task['reminderTime'] != null
          ? DateTime.parse(task['reminderTime'])
          : null,
      createdAt: DateTime.parse(task['createdAt']),
      updatedAt:
          task['updatedAt'] != null ? DateTime.parse(task['updatedAt']) : null,
    );
  }
}

// Enum for Priority
enum Priority {
  high, // أولوية عالية
  medium, // أولوية متوسطة
  low, // أولوية منخفضة
}
