import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String senderId;
  final String message;
  final Timestamp createdAt;

  const Message({
    required this.senderId,
    required this.message,
    required this.createdAt,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      senderId: json['senderId'],
      message: json['message'],
      createdAt: json['createdAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'senderId': senderId,
      'message': message,
      'createdAt': createdAt,
    };
  }
}
