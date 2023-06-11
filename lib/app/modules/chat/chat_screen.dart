import 'package:bigfoot/app/modules/chat/models/chat.dart';
import 'package:bigfoot/app/modules/chat/models/message.dart';
import 'package:bigfoot/app/modules/chat/widgets/message_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  static const routeName = '/chat';

  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  bool _isInit = false;
  late String _chatId;
  String? _productName;
  final _textEditingController = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!_isInit) {
      final arguments =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
      print(arguments);
      _chatId = arguments['chatId'] as String;
      _productName = arguments['productName'] as String?;
      _isInit = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_productName ?? "Chat with support")),
      body: Column(
        children: [
          Expanded(
            child: FirestoreListView(
              query: _messagesQuery,
              padding: const EdgeInsets.all(16),
              reverse: true,
              itemBuilder: (context, snapshot) {
                final message = snapshot.data();
                return MessageBubble(
                  createdAt: message.createdAt,
                  senderId: message.senderId,
                  message: message.message,
                );
              },
            ),
          ),
          const Divider(height: 1),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _textEditingController,
                    decoration: const InputDecoration.collapsed(
                      hintText: 'Type a message ...',
                    ),
                  ),
                ),
                IconButton(
                  onPressed: _sendMessage,
                  icon: const Icon(Icons.send),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _sendMessage() {
    if (_textEditingController.text.trim().isEmpty) return;

    final message = Message(
      message: _textEditingController.text,
      createdAt: Timestamp.now(),
      senderId: FirebaseAuth.instance.currentUser!.uid,
    );

    final chat = FirebaseFirestore.instance.collection('chats').doc(_chatId);

    chat.collection('messages').add(message.toJson());
    chat.update({'lastMessage': message.toJson()});

    _textEditingController.clear();
  }

  Query<Message> get _messagesQuery {
    return FirebaseFirestore.instance
        .collection('chats')
        .doc(_chatId)
        .collection('messages')
        .orderBy('createdAt', descending: true)
        .withConverter<Message>(
          fromFirestore: (snapshot, _) => Message.fromJson(snapshot.data()!),
          toFirestore: (message, _) => message.toJson(),
        );
  }
}
