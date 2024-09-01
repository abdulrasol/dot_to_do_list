import 'package:dot_to_do_list/models/task_model.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

// ignore: must_be_immutable
class TaskWidget extends StatefulWidget {
  TaskModel task;
  TaskWidget({super.key, required this.task});

  @override
  State<TaskWidget> createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  @override
  Widget build(BuildContext context) {
    initializeDateFormatting();
    var format = DateFormat.yMd('ar');
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
        child: Row(
          children: [
            Checkbox(
                value: widget.task.isCompleted,
                onChanged: (value) {
                  setState(() {
                    widget.task.isCompleted = value!;
                  });
                }),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.task.title,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  widget.task.description ?? 'task has no description',
                  style: const TextStyle(fontWeight: FontWeight.w100),
                ),
                Text(
                  format.format(widget.task.dueDate),
                  style: const TextStyle(fontWeight: FontWeight.w100),
                ),
              ],
            ),
            const Expanded(child: SizedBox()),
            Icon(widget.task.hasReminder ? Icons.alarm : Icons.alarm_off)
          ],
        ),
      ),
    );
  }
}
