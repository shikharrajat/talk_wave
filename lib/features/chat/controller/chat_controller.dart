import 'dart:io';
import 'package:talk_wave/features/chat/repository/chat_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:talk_wave/features/auth/controller/auth_controller.dart';
import 'package:talk_wave/features/chat/repository/chat_repository.dart';
import 'package:talk_wave/models/chat_contact.dart';
import 'package:talk_wave/models/message.dart';

final chatControllerProvider = Provider((ref) {
  final chatRepository = ref.watch(chatRepositoryProvider);
  return ChatController(
    chatRepository: chatRepository,
    ref: ref,
  );
});

class ChatController {
  final ChatRepository chatRepository;
  final ProviderRef ref;
  ChatController({
    required this.chatRepository,
    required this.ref,
  });

  Stream<List<ChatContact>> chatContacts() {
    return chatRepository.getChatContacts();
  }

  Stream<List<Message>> chatStream(String recieverUserId) {
    return chatRepository.getChatStream(recieverUserId);
  }

void sendTextMessage(
    BuildContext context,
    String text,
    String recieverUserId,
   
  ) {
    
    ref.read(userDataAuthProvider).whenData(
          (value) => chatRepository.sendTextMessage(
            context: context,
            text: text,
            recieverUserId: recieverUserId,
            senderUser: value!,
         
          
          ),
        );
   
  }

}
