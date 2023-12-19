import 'dart:developer';

import 'package:bloc/bloc.dart';

import 'package:chatapp/feature/auth/manager/auth_event.dart';
import 'package:chatapp/feature/auth/manager/auth_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  String? loginPassword, loginEmail;
  AutovalidateMode autovalidateModeLogin = AutovalidateMode.disabled;
  final GlobalKey<FormState> formLoginKey = GlobalKey();
  final GlobalKey<FormState> formRegisterkey = GlobalKey();
  AutovalidateMode autovalidateModeRegister = AutovalidateMode.disabled;
  String? registerEmail;
  String? registerPassword;
  AuthBloc() : super(AuthInitial()) {
    on<AuthEvent>((event, emit) async {
      if (event is LoginEvent) {
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
      } else if (event is ValidateLogin) {
        emit(FormLoginNotVlidate());
        if (formLoginKey.currentState!.validate()) {
          emit(FormLoginVlidate());
          formLoginKey.currentState!.save();
          add(LoginEvent());
        } else {
          autovalidateModeLogin = AutovalidateMode.always;
        }
      } else if (event is ValidateRegeiseter) {
        emit(FormNotVlidateRegister());
        if (formRegisterkey.currentState!.validate()) {
          emit(FormVlidateRegsister());
          formRegisterkey.currentState!.save();
          add(Regeiseter());
        } else {
          autovalidateModeRegister = AutovalidateMode.always;
        }
      } else if (event is Regeiseter) {
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
    });
  }
}
