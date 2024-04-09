import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gemini_chat_bot/providers/get_all_messages_provider.dart';
import 'package:gemini_chat_bot/widgets/message_tile.dart';

class MessagesList extends ConsumerWidget {
  const MessagesList({
    super.key,
    required this.userId,
  });

  final String userId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final messageData = ref.watch(getAllMessagesProvider(userId));

    return messageData.when(
      data: (messages) {
        return ListView.builder(
          reverse: true,
          itemCount: messages.length,
          itemBuilder: (context, index) {
            final message = messages.elementAt(index);

            return MessageTile(
              isOutgoing: message.isMine,
              message: message,
            );
          },
        );
      },
      error: (error, stackTrace) {
        return Center(
          child: Text(error.toString()),
        );
      },
      loading: () {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
