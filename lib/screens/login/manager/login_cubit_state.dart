abstract class LoginCubitState {}

class LoginCubitInitial extends LoginCubitState {}

class LoginSuccessState extends LoginCubitState {}

class LoginErrorState extends LoginCubitState {
 final String errorMassage;
  LoginErrorState({
    required this.errorMassage,
  });
}

class LoginLoadingState extends LoginCubitState {}

class FormVlidate extends LoginCubitState {}

class FormNotVlidate extends LoginCubitState {}
