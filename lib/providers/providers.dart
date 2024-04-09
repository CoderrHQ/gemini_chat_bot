import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gemini_chat_bot/repositories/auth_repository.dart';
import 'package:gemini_chat_bot/repositories/chat_repository.dart';

final chatProvider = Provider(
  (ref) => ChatRepository(),
);

final authProvider = Provider(
  (ref) => AuthRepository(),
);
