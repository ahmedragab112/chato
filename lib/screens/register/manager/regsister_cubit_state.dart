
abstract class RegsisterCubitState {}

class RegsisterCubitInitial extends RegsisterCubitState {}

class RegisterSuccessState extends RegsisterCubitState {}

class RegisterErrorState extends RegsisterCubitState {
  String errorMassage;
  RegisterErrorState({
    required this.errorMassage,
  });
}

class RegisterLoadingState extends RegsisterCubitState {}
class FormVlidate extends RegsisterCubitState {}

class FormNotVlidate extends RegsisterCubitState {}
