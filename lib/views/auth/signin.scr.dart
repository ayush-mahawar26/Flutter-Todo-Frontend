import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_frontend/const/size.config.dart';
import 'package:todo_frontend/cubit/authCubit/auth.cub.dart';
import 'package:todo_frontend/cubit/authCubit/auth.state.dart';
import 'package:todo_frontend/views/auth/signup.scr.dart';
import 'package:todo_frontend/widgets/custom.widget.dart';

class SigninAuthScreen extends StatelessWidget {
  SigninAuthScreen({super.key});

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    AuthCubit authCub = BlocProvider.of<AuthCubit>(context);
    SizeConfig().init(context);
    return Scaffold(
      body: Center(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Welcome Back! Word Hard",
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(),
              ),
              const SizedBox(
                height: 25,
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
                  listener: (context, state) {
                    if (state is AuthError) {
                      CustomWidget().snackbar(state.err, context);
                    }

                    if (state is AuthDone) {
                      CustomWidget().snackbar("SignIn Successfully", context);
                    }
                  },
                  builder: (context, state) {
                    if (state is AuthLoading) {
                      return ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.black)),
                          onPressed: () async {},
                          child: const Padding(
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
                          await authCub.signinUser(
                              email.text.trim(), password.text.trim(), context);
                        },
                        child: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 20),
                          child: Text("Sign In"),
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
                    "Don't have account ?",
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(fontSize: 18, color: Colors.black),
                  ),
                  InkWell(
                    onTap: () => Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => SignUpPage()),
                        (route) => false),
                    child: Text(
                      "SignUp",
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
