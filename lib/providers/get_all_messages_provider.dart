import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gemini_chat_bot/models/message.dart';

final getAllMessagesProvider =
    StreamProvider.autoDispose.family<Iterable<Message>, String>(
  (ref, userId) {
    final controller = StreamController<Iterable<Message>>();

    final sub = FirebaseFirestore.instance
        .collection('conversations')
        .doc(userId)
        .collection('messages')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .listen((snapshot) {
      final messages = snapshot.docs.map(
        (messageData) => Message.fromMap(
          messageData.data(),
        ),
      );

      controller.sink.add(messages);
    });

    ref.onDispose(() {
      sub.cancel();
      controller.close();
    });

    return controller.stream;
  },
);
