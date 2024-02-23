import 'package:chat_app/shared/constants.dart';

class MessageModel {
  final String message;
  final String id;

  MessageModel({required this.message, required this.id});

  factory MessageModel.fromJson(json) {
    return MessageModel(message: json[kMessage], id: json['id']);
  }
}
