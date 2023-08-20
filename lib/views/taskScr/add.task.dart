import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_frontend/const/size.config.dart';
import 'package:todo_frontend/cubit/taskCubit/taskcub.dart';
import 'package:todo_frontend/cubit/taskCubit/taskstate.dart';
import 'package:todo_frontend/widgets/custom.widget.dart';

class AddTask extends StatelessWidget {
  AddTask({super.key});

  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Your Task"),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              CustomWidget().CustomTextFeild(title, "Title for Work"),
              SizedBox(
                height: 20,
              ),
              CustomWidget().CustomTextFeild(
                  description, "Add Your Description",
                  multiLine: true),
              SizedBox(
                height: 30,
              ),
              SizedBox(
                width: SizeConfig.width,
                child: BlocConsumer<TaskCubit, TaskState>(
                  listener: (context, state) {
                    if (state is TaskUploaded) {
                      CustomWidget().snackbar("Task Addded", context);
                      Navigator.of(context).pop();
                    }
                    if (state is TaskGettingError)
                      CustomWidget().snackbar("task Added Failed ! ", context);
                  },
                  builder: (context, state) {
                    if (state is TaskLoading) {
                      return ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.black)),
                          onPressed: () async {},
                          child: const Padding(
                              padding: EdgeInsets.symmetric(vertical: 15),
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              )));
                    }
                    return ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.black)),
                        onPressed: () async {
                          TaskCubit task = BlocProvider.of<TaskCubit>(context);
                          if (title.text.trim() != "" &&
                              description.text.trim() != "") {
                            await task.addtask(
                                title.text.trim(), description.text.trim());
                          } else {
                            CustomWidget().snackbar("Fill All feild", context);
                          }
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 15),
                          child: Text(
                            "Add Task",
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(color: Colors.white),
                          ),
                        ));
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
