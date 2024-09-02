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
      color: widget.task.isCompleted ? Colors.white54 : Colors.white,
      child: SizedBox(
        height: 90,
        width: double.infinity,
        child: Stack(children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: 0,
            child: Center(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          widget.task.title,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontStyle: widget.task.isCompleted
                                ? FontStyle.italic
                                : FontStyle.normal,
                          ),
                        ),
                        Text(
                          widget.task.description ?? 'task has no description',
                          style: TextStyle(
                            fontWeight: FontWeight.w100,
                            fontStyle: widget.task.isCompleted
                                ? FontStyle.italic
                                : FontStyle.normal,
                          ),
                        ),
                        Text(
                          format.format(widget.task.dueDate),
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontStyle: widget.task.isCompleted
                                ? FontStyle.italic
                                : FontStyle.normal,
                          ),
                        ),
                      ],
                    ),
                    const Expanded(child: SizedBox()),
                    Icon(
                        widget.task.hasReminder ? Icons.alarm : Icons.alarm_off)
                  ],
                ),
              ),
            ),
          ),
          widget.task.isCompleted
              ? const Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Center(
                      child: Divider(
                    thickness: 2,
                    color: Colors.grey,
                  )))
              : const SizedBox(),
        ]),
      ),
    );
  }
}
