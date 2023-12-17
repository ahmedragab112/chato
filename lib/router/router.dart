import 'package:chatapp/feature/auth%20feature/cubit/auth_cubit.dart';
import 'package:chatapp/router/routes.dart';
import 'package:chatapp/screens/home/home.dart';
import 'package:chatapp/screens/home/manager/homecubit_cubit.dart';
import 'package:chatapp/screens/login/login.dart';
import 'package:chatapp/screens/register/register.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouter {
  static Route<Widget> generatRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.loginPage:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => AuthCubit(),
            child: const Login(),
          ),
        );
      case Routes.regsisterPage:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => AuthCubit(),
            child: const Register(),
          ),
        );
      case Routes.homePage:
        return MaterialPageRoute(
          builder: (context) =>  BlocProvider(
            create: (context) => HomeCubit()..getMesssages(),
            child:const Home(),
          ),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => AuthCubit(),
            child: const Login(),
          ),
        );
    }
  }
}
