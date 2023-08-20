import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_frontend/cubit/authCubit/auth.cub.dart';
import 'package:todo_frontend/cubit/authCubit/auth.state.dart';
import 'package:todo_frontend/services/auth.service.dart';
import 'package:todo_frontend/views/auth/signin.scr.dart';

import '../../const/size.config.dart';
import '../../widgets/custom.widget.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({super.key});
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    AuthCubit authCub = BlocProvider.of<AuthCubit>(context);
    return Scaffold(
      body: Center(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Sign Up And Start working",
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(),
              ),
              SizedBox(
                height: 25,
              ),
              CustomWidget().CustomTextFeild(username, "Enter Username"),
              const SizedBox(
                height: 20,
              ),
              CustomWidget().CustomTextFeild(email, "Enter Email"),
              const SizedBox(
                height: 20,
              ),
              CustomWidget()
                  .CustomTextFeild(password, "Enter Password", secure: true),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: SizeConfig.width,
                child: BlocConsumer<AuthCubit, AuthState>(
                  listener: (context, state) => {
                    if (state is AuthError)
                      {CustomWidget().snackbar(state.err, context)},
                    if (state is AuthDone)
                      {
                        CustomWidget().snackbar(
                            "Successfully Created an Account", context)
                      },
                  },
                  builder: (context, state) {
                    if (state is AuthLoading) {
                      return ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.black)),
                          onPressed: () async {},
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 20),
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          ));
                    }

                    return ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.black)),
                        onPressed: () async {
                          await authCub.signupUser(username.text.trim(),
                              email.text.trim(), password.text.trim(), context);
                        },
                        child: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 20),
                          child: Text("Sign Up"),
                        ));
                  },
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have account ?",
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(fontSize: 18, color: Colors.black),
                  ),
                  InkWell(
                    onTap: () => Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (context) => SigninAuthScreen()),
                        (route) => false),
                    child: Text(
                      "Sign In",
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.black),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      )),
    );
  }
}
