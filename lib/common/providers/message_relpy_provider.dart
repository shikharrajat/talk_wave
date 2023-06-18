import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:talk_wave/common/enums/message_enum.dart';

final messageReplyProvider = StateProvider<MessageReply?>((ref) => null);

class MessageReply {
  final String message;
  final bool isMe;
  final MessageEnum messageEnum;

  MessageReply(this.message, this.isMe, this.messageEnum);
}

