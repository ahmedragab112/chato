// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'regsister_cubit_state.dart';

class RegsisterCubit extends Cubit<RegsisterCubitState> {
  RegsisterCubit() : super(RegsisterCubitInitial());
  String? email;
  String? password;
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  final GlobalKey<FormState> formkey = GlobalKey();
  Future<void> createUserWithEmailAndPassword() async {
    try {
      emit(RegisterLoadingState());
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email!, password: password!);
      emit(RegisterSuccessState());
    } on FirebaseAuthException catch (e) {
      emit(RegisterErrorState(errorMassage: e.message!));
    } catch (e) {
      emit(RegisterErrorState(errorMassage: e.toString()));
    }
  }

  void checkFormVlidation() {
    emit(FormNotVlidate());
    if (formkey.currentState!.validate()) {
      emit(FormVlidate());
      formkey.currentState!.save();
      createUserWithEmailAndPassword();
    } else {
      autovalidateMode = AutovalidateMode.always;
    }
  }
}
