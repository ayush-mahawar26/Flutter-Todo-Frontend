import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_frontend/cubit/taskCubit/taskstate.dart';
import 'package:todo_frontend/models/task.model.dart';
import 'package:todo_frontend/services/task.service.dart';

class TaskCubit extends Cubit<TaskState> {
  TaskCubit() : super(InitialTaskState());

  static List<TaskModel> tasklst = [];

  getTask() async {
    emit(TaskLoading());
    try {
      Map<dynamic, dynamic> res = await TaskService().getAllTask();
      List task = res["tasks"];
      print(task);
      for (Map i in task) {
        String title = i["title"];
        String linkedwith = i["id"];
        String taskid = i["_id"];
        String description = i["description"];
        TaskModel model = TaskModel(title, description, linkedwith, taskid);
        tasklst.add(model);
      }
      print(tasklst.length);
      emit(TaskGet());
    } catch (e) {
      emit(TaskGettingError(e.toString()));
    }
  }

  addtask(String title, String descp) async {
    emit(TaskLoading());
    try {
      Map res = await TaskService().addTask(title, descp);
      TaskModel task =
          TaskModel(res["title"], res["description"], res["id"], res["_id"]);
      tasklst.add(task);
      emit(TaskUploaded());
    } catch (e) {
      emit(TaskGettingError(e.toString()));
    }
  }

  deleteTask(TaskModel task) async {
    emit(TaskDeleting());
    try {
      print("abcc");
      Map res = await TaskService().deletetask(task.taskId);
      print(res["deleted"]);
      if (res["deleted"] == true) {
        print(true);
        tasklst.remove(task);
        emit(TaskDeleted());
      } else {
        emit(TaskDeletionFailed("Error Occured in Deletion"));
      }
    } catch (e) {
      emit(TaskDeletionFailed(e.toString()));
    }
  }

  updateTask(
      TaskModel task, String title, String descp, BuildContext context) async {
    emit(TaskUpdating());
    try {
      Map res = await TaskService().updateTask(task.taskId, title, descp);
      if (res["task"]["acknowledged"] == true) {
        print(true);
        print(res);
        tasklst[tasklst.indexOf(task)] =
            TaskModel(title, descp, task.linkedWithUid, task.taskId);
        emit(TaskUpdated());
      } else {
        emit(TaskUpdateError("Error Occured in Updationg"));
      }
    } catch (e) {
      emit(TaskUpdateError(e.toString()));
    }
  }
}
