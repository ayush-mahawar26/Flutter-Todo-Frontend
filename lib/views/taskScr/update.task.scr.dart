import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../const/size.config.dart';
import '../../cubit/taskCubit/taskcub.dart';
import '../../cubit/taskCubit/taskstate.dart';
import '../../models/task.model.dart';
import '../../widgets/custom.widget.dart';

class UpdateScreen extends StatefulWidget {
  TaskModel taskmodel;
  UpdateScreen({super.key, required this.taskmodel});

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      title.text = widget.taskmodel.title;
      description.text = widget.taskmodel.description;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Update Your Task"),
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
                    if (state is TaskUpdated) {
                      CustomWidget().snackbar("Task Updated", context);
                      Navigator.of(context).pop();
                    }
                    if (state is TaskUpdateError)
                      CustomWidget()
                          .snackbar("task Updated Failed ! ", context);
                  },
                  builder: (context, state) {
                    if (state is TaskUpdating) {
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
                            await task.updateTask(
                                widget.taskmodel,
                                title.text.trim(),
                                description.text.trim(),
                                context);
                          } else {
                            CustomWidget().snackbar("Fill All feild", context);
                          }
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 15),
                          child: Text(
                            "Update Task",
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
