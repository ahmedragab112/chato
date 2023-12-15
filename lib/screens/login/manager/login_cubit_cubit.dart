import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'login_cubit_state.dart';

class LoginCubit extends Cubit<LoginCubitState> {
  String? password;
  String? email;
  final GlobalKey<FormState> formKey = GlobalKey();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  LoginCubit() : super(LoginCubitInitial());
  Future<void> signInWithEmailAndPassword() async {
    try {
      emit(LoginLoadingState());
           await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email!, password: password!);
      emit(LoginSuccessState());
    } on FirebaseAuthException catch (e) {
      emit(LoginErrorState(errorMassage: e.message.toString()));
      log(e.toString());
    } catch (e) {
      emit(LoginErrorState(errorMassage: e.toString()));
      log(e.toString());
    }
  }

  void checkFormVlidation() {
    emit(FormNotVlidate());
    if (formKey.currentState!.validate()) {
      emit(FormVlidate());
      formKey.currentState!.save();
      signInWithEmailAndPassword();
    } else {
      autovalidateMode = AutovalidateMode.always;
    }
  }
}
