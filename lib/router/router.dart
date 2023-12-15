import 'package:chatapp/router/routes.dart';
import 'package:chatapp/screens/home/home.dart';
import 'package:chatapp/screens/login/login.dart';
import 'package:chatapp/screens/login/manager/login_cubit_cubit.dart';
import 'package:chatapp/screens/register/manager/regsister_cubit_cubit.dart';
import 'package:chatapp/screens/register/register.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouter {
  static Route<Widget> generatRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.loginPage:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => LoginCubit(),
            child: const Login(),
          ),
        );
      case Routes.regsisterPage:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => RegsisterCubit(),
            child: const Register(),
          ),
        );
      case Routes.homePage:
        return MaterialPageRoute(
          builder: (context) => const Home(),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => LoginCubit(),
            child: const Login(),
          ),
        );
    }
  }
}
