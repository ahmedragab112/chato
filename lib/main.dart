import 'package:chatapp/firebase_options.dart';
import 'package:chatapp/observer.dart';
import 'package:chatapp/core/router/router.dart';
import 'package:chatapp/core/router/routes.dart';
import 'package:chatapp/core/theme/app_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.theme,
      initialRoute: Routes.loginPage,
      onGenerateRoute: AppRouter.generatRoute,
      debugShowCheckedModeBanner: false,
    );
  }
}
