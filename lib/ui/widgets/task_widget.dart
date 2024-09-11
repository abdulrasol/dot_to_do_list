import 'package:dot_to_do_list/controllers/data_controller.dart';
import 'package:dot_to_do_list/models/task_model.dart';
import 'package:dot_to_do_list/controllers/ui_controller.dart';
import 'package:dot_to_do_list/ui/add_edit_task.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

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
    UiController uiController = Get.put(UiController());
    DataController dataController = Get.find();
    //var format = DateFormat.yMd('ar');
    return GestureDetector(
      onLongPress: () {
        Get.to(() => AddEditTaskPage(task: widget.task));
      },
      child: Card(
        color: widget.task.isCompleted ? Colors.white54 : Colors.white,
        child: SizedBox(
          height: 80,
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
                            //dataController.compeletetask(widget.task);
                            setState(() {
                              widget.task.isCompleted = value!;
                            });
                          }),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              widget.task.title,
                              overflow: TextOverflow.ellipsis,
                              softWrap: T,
                              maxLines: 1,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontStyle: widget.task.isCompleted
                                    ? FontStyle.italic
                                    : FontStyle.normal,
                              ),
                            ),
                            Text(
                              widget.task.description ??
                                  'task has no description',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              softWrap: F,
                              style: TextStyle(
                                fontWeight: FontWeight.w100,
                                fontStyle: widget.task.isCompleted
                                    ? FontStyle.italic
                                    : FontStyle.normal,
                              ),
                            ),
                            // Text.rich(
                            //   TextSpan(children: [
                            //     TextSpan(
                            //       text: uiController.dateFormat
                            //           .format(widget.task.dueDate),
                            //     ),
                            //     TextSpan(text: ' - '),
                            //     TextSpan(
                            //         text: widget.task.hasReminder
                            //             ? widget.task.reminderTime!
                            //                 .format(context)
                            //             : ''),
                            //     // )
                            //   ]),
                            //   style: TextStyle(
                            //     fontWeight: FontWeight.normal,
                            //     fontStyle: widget.task.isCompleted
                            //         ? FontStyle.italic
                            //         : FontStyle.normal,
                            //   ),
                            // ),
                            Text(
                              uiController.dateFormat
                                  .format(widget.task.dueDate),
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontStyle: widget.task.isCompleted
                                    ? FontStyle.italic
                                    : FontStyle.normal,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Expanded(child: SizedBox()),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(widget.task.hasReminder
                              ? Icons.alarm
                              : Icons.alarm_off),
                          // Text(widget.task.hasReminder
                          //     ? widget.task.reminderTime!.format(context)
                          //     : ''),
                          Text(
                            '${widget.task.priority.toString().split('.')[1][0].capitalize}',
                            style: const TextStyle(
                                fontSize: 12, fontWeight: FontWeight.bold),
                          ),
                        ],
                      )
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
      ),
    );
  }
}
