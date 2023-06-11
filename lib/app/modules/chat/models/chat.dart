import 'package:bigfoot/app/modules/chat/models/message.dart';

class Chat {
  final String? productId;
  final String clientId;
  final String clientName;
  final Message? lastMessage;

  const Chat({
    required this.productId,
    required this.clientId,
    required this.clientName,
    required this.lastMessage,
  });

  factory Chat.fromJson(Map<String, dynamic> json) {
    return Chat(
      productId: json['productId'],
      clientId: json['clientId'],
      clientName: json['clientName'],
      lastMessage: json['lastMessage'] == null
          ? null
          : Message.fromJson(json['lastMessage']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'clientId': clientId,
      'clientName': clientName,
      'lastMessage': lastMessage?.toJson(),
    };
  }
}
