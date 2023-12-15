import 'package:chatapp/router/routes.dart';
import 'package:chatapp/screens/home/manager/homecubit_cubit.dart';
import 'package:chatapp/screens/login/manager/login_cubit_cubit.dart';
import 'package:chatapp/screens/login/manager/login_cubit_state.dart';
import 'package:chatapp/widgets/custom_button.dart';
import 'package:chatapp/helper/custom_snackbar.dart';
import 'package:chatapp/widgets/custom_textfiled.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    var bloc = BlocProvider.of<LoginCubit>(context);
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
                child: BlocConsumer<LoginCubit, LoginCubitState>(
                  listener: (context, state) {
                    if (state is LoginLoadingState) {
                      const Center(child: CircularProgressIndicator());
                    } else if (state is LoginSuccessState) {
                      BlocProvider.of<HomeCubit>(context).getMesssages();
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
                      autovalidateMode: bloc.autovalidateMode,
                      key: bloc.formKey,
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
                              bloc.email = value!;
                            },
                            hintText: 'Enter email',
                            type: 'Email',
                            inputType: TextInputType.emailAddress,
                          ),
                          const Gap(20),
                          CustomTextFiled(
                            onSaved: (value) {
                              bloc.password = value!;
                            },
                            hintText: 'Enter password',
                            type: 'Password',
                            inputType: TextInputType.text,
                          ),
                          const Gap(20),
                          CustomButton(
                            type: 'Login',
                            function: () {
                              bloc.checkFormVlidation();
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
