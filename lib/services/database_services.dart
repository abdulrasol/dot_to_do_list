import 'dart:core';

import 'package:appwrite/appwrite.dart';
import 'package:dot_to_do_list/models/task_model.dart';
import 'package:flutter/foundation.dart';
import 'package:get_storage/get_storage.dart';

abstract class AbstractDataBase {
  Future<List<TaskModel>> getTasks();
  Future<int> addTask(TaskModel task);
  Future<int> removeTask(TaskModel task);
  Future<int> editTask(TaskModel oldTask, TaskModel newTask);
}

// Abstract base class

class DatabaseServices {
  Client client = Client();
  GetStorage box = GetStorage();
  late Databases databases;
  final String databaseID = '66d40ec5001fd6f45d88';
  final String taskID = '66d40ec5001fd6f45d88-tasks';

  DatabaseServices() {
    client
        .setEndpoint('https://cloud.appwrite.io/v1')
        .setProject('66d40908001cfa0aae91')
        .setSelfSigned(status: true);

    databases = Databases(client);
  }

  Future addTask(TaskModel task) async {
    try {
      String id = ID.unique();
      task.id = id;

      await databases.createDocument(
          databaseId: databaseID,
          collectionId: taskID,
          documentId: id,
          data: task.toMap());
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<List<TaskModel>> getTasks() async {
    /// await client.
    databases
        .listDocuments(databaseId: databaseID, collectionId: taskID)
        .asStream();
    return await databases
        .listDocuments(databaseId: databaseID, collectionId: taskID)
        .then(
          (tasks) => tasks.documents.map((task) {
            return TaskModel.fromMap(task.data);
          }).toList(),
        );
  }
}

class LocalDataBase extends AbstractDataBase {
  var box = GetStorage();
  late List _tasks;

  LocalDataBase() {
    _tasks = box.read('tasks') ?? [];
  }
  @override
  Future<int> addTask(TaskModel task) async {
    //print('local db add');
    try {
      _tasks.add(task.toMap());
      box.write('tasks', _tasks);
    } catch (e) {
      return 1;
    }
    return 0;
  }

  @override
  Future<int> removeTask(TaskModel task) async {
    _tasks.removeWhere((test) => test.toString() == task.toMap().toString());

    box.write('tasks', _tasks);
    return 0;
  }

  @override
  Future<int> editTask(TaskModel oldTask, TaskModel newTask) async {
    _tasks.add(newTask.toMap());
    _tasks.removeWhere((test) => test.toString() == oldTask.toMap().toString());

    //
    // _tasks.map((t) {
    //   print(t['isCompleted']);
    //   if (t.toString() == oldTask.toMap().toString()) {
    //     print('match');
    //   }
    // });
    // _tasks.add(newTask.toMap());
    box.write('tasks', _tasks);
    return 0;
  }

  @override
  Future<List<TaskModel>> getTasks() async {
    //print('from db local get');

    if (_tasks.isNotEmpty) {
      return _tasks.map((i) {
        return TaskModel.fromMap(i as Map);
      }).toList();
    } else {
      return [];
    }
  }
}

class OnlineDataBase extends AbstractDataBase {
  Client client = Client();
  GetStorage box = GetStorage();
  late Databases databases;
  final String databaseID = '66d40ec5001fd6f45d88';
  final String collectionId = '66d40ec5001fd6f45d88-tasks';

  OnlineDataBase() {
    client
        .setEndpoint('https://cloud.appwrite.io/v1')
        .setProject('66d40908001cfa0aae91')
        .setSelfSigned(status: true);

    databases = Databases(client);
  }
  @override
  Future<int> addTask(TaskModel task) async {
    try {
      await databases.createDocument(
          databaseId: databaseID,
          collectionId: collectionId,
          documentId: task.id,
          data: task.toMap());
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return 0;
  }

  @override
  Future<int> editTask(TaskModel oldTask, TaskModel newTask) async {
    try {
      await databases.updateDocument(
        databaseId: databaseID,
        collectionId: collectionId,
        documentId: oldTask.id,
        data: newTask.toMap(),
      );
      //await getTasks();
    } catch (e) {
      return 1;
    }
    return 0;
  }

  @override
  Future<List<TaskModel>> getTasks() async {
    return await databases
        .listDocuments(databaseId: databaseID, collectionId: collectionId)
        .then(
          (tasks) => tasks.documents.map((task) {
            return TaskModel.fromMap(task.data);
          }).toList(),
        );
  }

  @override
  Future<int> removeTask(TaskModel task) async {
    try {
      await databases.deleteDocument(
          databaseId: databaseID,
          collectionId: collectionId,
          documentId: task.id);
      await getTasks();
    } catch (e) {
      return 1;
    }
    return 0;
  }
}
