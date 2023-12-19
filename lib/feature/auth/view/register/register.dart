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

class Register extends StatelessWidget {
  const Register({super.key});

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
                    if (state is RegisterSuccessState) {
                      customSnackBar(context, 'Success');
                      Navigator.pushNamed(context, Routes.homePage);
                    } else if (state is RegisterErrorState) {
                      Navigator.pop(context);
                      customSnackBar(context, state.errorMassage);
                    } else if (state is RegisterLoadingState) {
                      showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (context) =>
                            const Center(child: CircularProgressIndicator()),
                      );
                    }
                  },
                  builder: (context, state) {
                    return Form(
                      key: bloc.formRegisterkey,
                      autovalidateMode: bloc.autovalidateModeRegister,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Gap(100),
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
                                color: Colors.blue),
                            textAlign: TextAlign.center,
                          ),
                          const Gap(50),
                          const Text(
                            'Sign up',
                            style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                            textAlign: TextAlign.start,
                          ),
                          const Gap(20),
                          CustomTextFiled(
                            hintText: 'Enter Email',
                            onSaved: (value) {
                              bloc.registerEmail = value;
                            },
                            type: 'Email',
                            inputType: TextInputType.name,
                          ),
                          const Gap(20),
                          CustomTextFiled(
                            hintText: 'Enter password',
                            type: 'Password',
                            onSaved: (value) {
                              bloc.registerPassword = value;
                            },
                            inputType: TextInputType.text,
                          ),
                          const Gap(20),
                          CustomButton(
                            type: 'Sign Up',
                            function: () {
                              bloc.add(ValidateRegeiseter());
                            },
                          ),
                          const Gap(10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Already have an account ?",
                                style: TextStyle(color: Colors.white),
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.pushReplacementNamed(
                                      context, Routes.loginPage);
                                },
                                child: const Text(
                                  ' Login',
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
