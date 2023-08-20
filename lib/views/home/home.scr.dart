import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_frontend/cubit/authCubit/auth.cub.dart';
import 'package:todo_frontend/cubit/taskCubit/taskcub.dart';
import 'package:todo_frontend/cubit/taskCubit/taskstate.dart';
import 'package:todo_frontend/services/jwtservice.dart';
import 'package:todo_frontend/views/auth/signin.scr.dart';
import 'package:todo_frontend/views/taskScr/add.task.dart';
import 'package:todo_frontend/widgets/custom.widget.dart';

class HomeScr extends StatefulWidget {
  const HomeScr({super.key});

  @override
  State<HomeScr> createState() => _HomeScrState();
}

class _HomeScrState extends State<HomeScr> {
  update(AuthCubit auth) async {
    await auth.userUpdate();
    if (AuthCubit.user.uid != "") {
      TaskCubit task = BlocProvider.of(context);
      print("get");
      task.getTask();
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    AuthCubit auth = BlocProvider.of(context);
    update(auth);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("TodoApp"),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: InkWell(
              onTap: () async {
                CustomWidget().snackbar("Signing Out", context);
                await JwtServices().deleteKey("token");
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => SigninAuthScreen()),
                    (route) => false);
              },
              child: Icon(Icons.exit_to_app),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => AddTask()));
        },
        child: Icon(Icons.add),
      ),
      body: BlocConsumer<TaskCubit, TaskState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (TaskCubit.tasklst.isEmpty) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Text("No task Available"),
                )
              ],
            );
          } else if (state is TaskGet || !TaskCubit.tasklst.isEmpty) {
            return (TaskCubit.tasklst.isEmpty)
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Text("No task Available"),
                      )
                    ],
                  )
                : ListView.builder(
                    itemCount: TaskCubit.tasklst.length,
                    itemBuilder: (context, index) {
                      return CustomWidget()
                          .cardWidget(TaskCubit.tasklst[index], context, index);
                    },
                  );
          }

          return const Center(
            child: CircularProgressIndicator(
              color: Colors.black,
            ),
          );
        },
      ),
    );
  }
}
