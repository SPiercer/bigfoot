import 'package:bigfoot/app/shared/extensions/datetime_extension.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final String message;
  final Timestamp createdAt;
  final String senderId;

  const MessageBubble({
    super.key,
    required this.message,
    required this.createdAt,
    required this.senderId,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment:
            _isSentByMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.7,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: _isSentByMe
                  ? Theme.of(context).colorScheme.primary
                  : Colors.white.withOpacity(0.10),
              borderRadius: BorderRadius.circular(15),
            ),
            child: DefaultTextStyle(
              style: TextStyle(
                color: _isSentByMe
                    ? Theme.of(context).colorScheme.surface
                    : Theme.of(context).colorScheme.onSurface,
              ),
              child: Column(
                crossAxisAlignment: _isSentByMe
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.start,
                children: [
                  Text(
                    createdAt.toDate().formattedTime,
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(message),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool get _isSentByMe => senderId == FirebaseAuth.instance.currentUser!.uid;
}
