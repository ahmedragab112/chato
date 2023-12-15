import 'package:cloud_firestore/cloud_firestore.dart';

class MassageModel {
  String massage;
  String id;
  Timestamp time;
  String email;
  MassageModel({required this.email,
    required this.massage,
    this.id = '',
    required this.time,
  });

  MassageModel.formJson(Map<String, dynamic> json)
      : this(
          id: json['id'],
          massage: json['massage'],
          time: json['time'],
          email: json['email']
        );
  Map<String, dynamic> toJson() {
    return {
      'email':email,
      'id': id,
      'massage': massage,
      'time': time,
    };
  }
}
