
import 'package:chatapp/feature/auth/manager/auth_bloc.dart';
import 'package:chatapp/core/router/routes.dart';
import 'package:chatapp/feature/home/view/home.dart';
import 'package:chatapp/feature/home/manager/homecubit_cubit.dart';
import 'package:chatapp/feature/auth/view/login/login.dart';

import 'package:chatapp/feature/auth/view/register/register.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class AppRouter {
  static Route<Widget> generatRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.loginPage:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => AuthBloc(),
            child: const Login(),
          ),
        );
      case Routes.regsisterPage:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => AuthBloc(),
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
            create: (context) => AuthBloc(),
            child: const Login(),
          ),
        );
    }
  }
}
