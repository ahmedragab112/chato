import 'package:chatapp/feature/home/data/model/massage_model.dart';
import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final bool myChat;

  final Color color;
  final MassageModel massage;
  const ChatBubble(
      {super.key,
      required this.myChat,
    
      required this.color, required this.massage});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: myChat == true ? Alignment.centerLeft : Alignment.centerRight,
      child: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: color,
          borderRadius: myChat == true
              ? const BorderRadius.only(
                  bottomRight: Radius.circular(20),
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20))
              : const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
        ),
        child: Text(
          massage.massage,
          textAlign: TextAlign.start,
        ),
      ),
    );
  }
}
