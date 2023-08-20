import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_frontend/cubit/taskCubit/taskcub.dart';
import 'package:todo_frontend/cubit/taskCubit/taskstate.dart';
import 'package:todo_frontend/models/task.model.dart';
import 'package:todo_frontend/views/taskScr/update.task.scr.dart';

class CustomWidget {
  Widget CustomTextFeild(TextEditingController controller, String hintText,
      {bool secure = false, bool multiLine = false}) {
    return TextField(
      controller: controller,
      obscureText: secure,
      maxLines: (multiLine) ? 10 : 1,
      decoration: InputDecoration(
          hintText: hintText,
          border: const OutlineInputBorder(
              borderSide: BorderSide(width: 1, color: Colors.grey)),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(width: 1, color: Colors.grey)),
          errorBorder: const OutlineInputBorder(
              borderSide: BorderSide(width: 1, color: Colors.grey)),
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(width: 1, color: Colors.grey)),
          disabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(width: 1, color: Colors.grey))),
    );
  }

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> snackbar(
      String text, BuildContext context) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(text),
      duration: const Duration(milliseconds: 500),
    ));
  }

  Widget cardWidget(TaskModel task, BuildContext context, int ind) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Card(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                task.title,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(fontSize: 40),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                task.description,
                style: Theme.of(context).textTheme.bodySmall!.copyWith(),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                      child: ElevatedButton.icon(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.black)),
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => UpdateScreen(
                                      taskmodel: task,
                                    )));
                          },
                          label: Text("Edit"))),
                  SizedBox(
                    width: 10,
                  ),
                  BlocConsumer<TaskCubit, TaskState>(
                    listener: (context, state) {
                      if (state is TaskDeleting)
                        CustomWidget().snackbar("Deleting Task", context);
                      if (state is TaskDeleted) {
                        CustomWidget().snackbar("task Deleted", context);
                      }
                    },
                    builder: (context, state) {
                      return Expanded(
                          child: ElevatedButton.icon(
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.red)),
                              icon: Icon(Icons.delete),
                              onPressed: () async {
                                TaskCubit taskCubit =
                                    BlocProvider.of<TaskCubit>(context);
                                await taskCubit.deleteTask(task);
                              },
                              label: Text("Delete")));
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
