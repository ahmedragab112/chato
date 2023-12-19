abstract class HomecubitState {}

class HomecubitInitial extends HomecubitState {}

class HomecubitSuccess extends HomecubitState {}

class HomecubitError extends HomecubitState {
 final String errorMassage;

  HomecubitError({required this.errorMassage});

}

class HomecubitLoadingState extends HomecubitState {}
