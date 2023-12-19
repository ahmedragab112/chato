import 'package:chatapp/core/helper/custom_snackbar.dart';
import 'package:chatapp/core/widgets/custom_button.dart';
import 'package:chatapp/core/widgets/custom_textfiled.dart';
import 'package:chatapp/feature/auth/manager/auth_bloc.dart';
import 'package:chatapp/feature/auth/manager/auth_event.dart';
import 'package:chatapp/feature/auth/manager/auth_state.dart';
import 'package:chatapp/core/router/routes.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    var bloc = BlocProvider.of<AuthBloc>(context);
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Image.asset(
              'assets/images/background.png',
              width: double.infinity,
              height: 200,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: BlocConsumer<AuthBloc, AuthState>(
                  listener: (context, state) {
                    if (state is LoginLoadingState) {
                      const Center(child: CircularProgressIndicator());
                    } else if (state is LoginSuccessState) {
                      Navigator.pushReplacementNamed(
                        context,
                        Routes.homePage,
                      );
                    } else if (state is LoginErrorState) {
                      customSnackBar(context, state.errorMassage);
                    }
                  },
                  builder: (context, state) {
                    return Form(
                      autovalidateMode: bloc.autovalidateModeLogin,
                      key: bloc.formLoginKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Gap(20),
                          Center(
                            child: Image.asset(
                              'assets/images/login.png',
                              width: 200,
                              height: 200,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const Text(
                            'Chato',
                            style: TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                          const Gap(20),
                          const Text(
                            'Login',
                            style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                            textAlign: TextAlign.start,
                          ),
                          const Gap(20),
                          CustomTextFiled(
                            onSaved: (value) {
                              bloc.loginEmail = value!;
                            },
                            hintText: 'Enter email',
                            type: 'Email',
                            inputType: TextInputType.emailAddress,
                          ),
                          const Gap(20),
                          CustomTextFiled(
                            onSaved: (value) {
                              bloc.loginPassword = value!;
                            },
                            hintText: 'Enter password',
                            type: 'Password',
                            inputType: TextInputType.text,
                          ),
                          const Gap(20),
                          CustomButton(
                            type: 'Login',
                            function: () {
                              bloc.add(ValidateLogin());
                            },
                          ),
                          const Gap(20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "don't have an account ?",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.pushReplacementNamed(
                                      context, Routes.regsisterPage);
                                },
                                child: const Text(
                                  ' Creat one',
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
