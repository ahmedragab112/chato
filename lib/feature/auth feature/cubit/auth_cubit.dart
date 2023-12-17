import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  String? loginPassword, loginEmail;
  AutovalidateMode autovalidateModeLogin = AutovalidateMode.disabled;
  final GlobalKey<FormState> formLoginKey = GlobalKey();
  String? registerEmail;
  String? registerPassword;

  final GlobalKey<FormState> formRegisterkey = GlobalKey();
  AutovalidateMode autovalidateModeRegister = AutovalidateMode.disabled;
  Future<void> signInWithEmailAndPassword() async {
    try {
      emit(LoginLoadingState());
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: loginEmail!, password: loginPassword!);
      emit(LoginSuccessState());
    } on FirebaseAuthException catch (e) {
      emit(LoginErrorState(errorMassage: e.message.toString()));
      log(e.toString());
    } catch (e) {
      emit(LoginErrorState(errorMassage: e.toString()));
      log(e.toString());
    }
  }

  void checkLoginFormVlidation() {
    emit(FormLoginNotVlidate());
    if (formLoginKey.currentState!.validate()) {
      emit(FormLoginVlidate());
      formLoginKey.currentState!.save();
      signInWithEmailAndPassword();
    } else {
      autovalidateModeLogin = AutovalidateMode.always;
    }
  }

  Future<void> createUserWithEmailAndPassword() async {
    try {
      emit(RegisterLoadingState());
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: registerEmail!, password: registerPassword!);
      emit(RegisterSuccessState());
    } on FirebaseAuthException catch (e) {
      emit(RegisterErrorState(errorMassage: e.message!));
    } catch (e) {
      emit(RegisterErrorState(errorMassage: e.toString()));
    }
  }

  void checkFormRegisterVlidation() {
    emit(FormNotVlidateRegister());
    if (formRegisterkey.currentState!.validate()) {
      emit(FormVlidateRegsister());
      formRegisterkey.currentState!.save();
      createUserWithEmailAndPassword();
    } else {
      autovalidateModeRegister = AutovalidateMode.always;
    }
  }
}
