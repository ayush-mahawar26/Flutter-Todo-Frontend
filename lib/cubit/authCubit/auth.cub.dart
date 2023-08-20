import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_frontend/cubit/authCubit/auth.state.dart';
import 'package:todo_frontend/services/auth.service.dart';
import 'package:todo_frontend/services/jwtservice.dart';
import 'package:todo_frontend/views/home/home.scr.dart';

import '../../models/user.model.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(InitialAuthState());

  static User user = User(uid: "", userEmail: "", token: "", username: "");

  signupUser(
      String username, String email, String pass, BuildContext context) async {
    emit(AuthLoading());
    print("loading");
    try {
      Map<dynamic, dynamic> details =
          await AuthService().signUpService(username, email, pass);
      print(details);

      if (details.isEmpty || details == null) {
        emit(AuthError("Sever Issue"));
      } else {
        if (details["auth"]) {
          user.uid = details["_id"];
          user.token = details["token"];
          user.userEmail = details["email"];
          user.username = details["username"];
          await JwtServices().setJwt(user.token);
          emit(AuthDone(user));
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => HomeScr()),
              (route) => false);
        } else {
          print(details["mssg"]);
          emit(AuthError(details["mssg"]));
        }
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  signinUser(String email, String pass, BuildContext context) async {
    emit(AuthLoading());
    print("loading");
    try {
      Map<dynamic, dynamic> details =
          await AuthService().signInService(email, pass);

      print(details);

      if (details.isEmpty || details == null) {
        emit(AuthError("Sever Issue"));
      } else {
        if (details["auth"]) {
          user.uid = details["_id"];
          user.token = details["token"];
          user.userEmail = details["email"];
          user.username = details["username"];
          await JwtServices().setJwt(user.token);
          print(user.uid);
          emit(AuthDone(user));
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => HomeScr()),
              (route) => false);
        } else {
          print(details["mssg"]);
          emit(AuthError(details["mssg"]));
        }
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  userUpdate() async {
    if (AuthCubit.user.uid == "") {
      Map res = await AuthService().getUser();
      String uid = res["id"]["id"];
      AuthCubit.user.token = res["token"];
      Map user = await AuthService().getUserById(uid);
      AuthCubit.user.uid = user["_id"];
      AuthCubit.user.username = user["username"];
      AuthCubit.user.userEmail = user["email"];
    }
  }
}
