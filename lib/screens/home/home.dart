import 'package:chatapp/model/massage_model.dart';
import 'package:chatapp/router/routes.dart';
import 'package:chatapp/screens/home/chat_buble.dart';
import 'package:chatapp/screens/home/manager/homecubit_cubit.dart';
import 'package:chatapp/screens/home/manager/homecubit_state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    var bloc = BlocProvider.of<HomeCubit>(context);
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                FirebaseAuth.instance.signOut().then((value) =>
                    Navigator.pushReplacementNamed(context, Routes.loginPage));
              },
              icon: const Icon(Icons.logout)),
          centerTitle: true,
          title: const Text('Chato'),
        ),
        body: Column(
          children: [
            BlocBuilder<HomeCubit, HomecubitState>(
              builder: (context, state) => Expanded(
                child: ListView.builder(
                  reverse: true,
                  controller: bloc.scrollController,
                  itemBuilder: (context, index) => bloc.massages[index].email ==
                          FirebaseAuth.instance.currentUser!.email
                      ? ChatBubble(
                          myChat: true,
                          massage: bloc.massages[index],
                          color: Colors.blue,
                        )
                      : ChatBubble(
                          myChat: false,
                          massage: bloc.massages[index],
                          color: Colors.orange,
                        ),
                  itemCount: bloc.massages.length,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: bloc.controlle,
                decoration: InputDecoration(
                    prefixIcon: IconButton(
                      onPressed: () {
                        bloc.scrollDown();
                      },
                      icon: const Icon(Icons.arrow_downward),
                    ),
                    hintText: 'Send massage',
                    suffixIcon: IconButton(
                      onPressed: () {
                        bloc.sendMessage(MassageModel(
                          massage: bloc.controlle.text,
                          time: Timestamp.fromDate(DateTime.now()),
                          email: FirebaseAuth.instance.currentUser!.email!,
                        ));

                        bloc.scrollController
                            .animateTo(
                                bloc.scrollController.position.minScrollExtent,
                                duration: const Duration(milliseconds: 200),
                                curve: Curves.easeIn)
                            .then((value) => bloc.controlle.clear());
                      },
                      icon: const Icon(Icons.send),
                    ),
                    enabled: true,
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(color: Colors.blue)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(color: Colors.blue)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(color: Colors.blue))),
              ),
            )
          ],
        ));
  }
}
