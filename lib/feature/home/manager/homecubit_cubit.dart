
import 'package:bloc/bloc.dart';
import 'package:chatapp/core/constant/constant.dart';
import 'package:chatapp/feature/home/data/model/massage_model.dart';
import 'package:chatapp/feature/home/manager/homecubit_state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomeCubit extends Cubit<HomecubitState> {
  final TextEditingController controlle = TextEditingController();
  List<MassageModel> massages = [];
  HomeCubit() : super(HomecubitInitial());
  final ScrollController scrollController = ScrollController();
  CollectionReference<MassageModel> getMassageCollection() {
    return FirebaseFirestore.instance
        .collection(messagesCollection)
        .withConverter<MassageModel>(
          fromFirestore: (snapshot, options) =>
              MassageModel.formJson(snapshot.data()!),
          toFirestore: (value, options) => value.toJson(),
        );
  }

  Future<void> sendMessage(MassageModel massage) async {
    try {
      CollectionReference<MassageModel> collection = getMassageCollection();
      var doc = collection.doc();
      massage.id = doc.id;
      await doc.set(massage);
    } catch (e) {
      emit(HomecubitError(errorMassage: e.toString()));
    }
  }

  void getMesssages() {
    emit(HomecubitLoadingState());
    CollectionReference<MassageModel> collection = getMassageCollection();
    collection.orderBy('time', descending: true).snapshots().listen((event) {
      massages = event.docs
          .map(
            (e) => e.data(),
          )
          .toList();
      emit(HomecubitSuccess());
    });
  }

  void scrollDown() {
    scrollController.animateTo(
      scrollController.position.minScrollExtent,
      duration: const Duration(seconds: 2),
      curve: Curves.fastOutSlowIn,
    );
  }
}
