import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_frontend/const/app.theme.dart';
import 'package:todo_frontend/cubit/authCubit/auth.cub.dart';
import 'package:todo_frontend/cubit/taskCubit/taskcub.dart';
import 'package:todo_frontend/services/jwtservice.dart';
import 'package:todo_frontend/views/auth/signin.scr.dart';
import 'package:todo_frontend/views/home/home.scr.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String? jwt;

  getKey() async {
    String? val = await JwtServices().getJwt("token");
    if (val != null) {
      setState(() {
        jwt = val;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getKey();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(create: (context) => AuthCubit()),
        BlocProvider<TaskCubit>(create: (context) => TaskCubit())
      ],
      child: MaterialApp(
        theme: AppTheme().appTheme(),
        home: (jwt == null) ? SigninAuthScreen() : HomeScr(),
      ),
    );
  }
}
