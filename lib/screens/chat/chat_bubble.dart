import 'package:chat_app/screens/chat/data/message_model.dart';
import 'package:chat_app/shared/constants.dart';
import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({Key? key, required this.message}) : super(key: key);
  final MessageModel message;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.only(top: 8, bottom: 8, left: 8, right: 95),
        decoration: const BoxDecoration(
            color: kPrimaryColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
              bottomRight: Radius.circular(16),
            )),
        child: Text(
          message.message,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class ChatBubble2 extends StatelessWidget {
  const ChatBubble2({Key? key, required this.message}) : super(key: key);
  final MessageModel message;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.only(top: 8, bottom: 8, left: 95, right: 8),
        decoration: const BoxDecoration(
            color: Color(0xff006D84),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
              bottomLeft: Radius.circular(16),
            )),
        child: Text(
          message.message,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
