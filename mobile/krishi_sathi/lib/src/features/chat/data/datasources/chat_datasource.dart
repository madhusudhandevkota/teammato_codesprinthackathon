import 'dart:io';

import 'package:krishi_sathi/src/features/chat/data/dto/ask_bot_request_dto.dart';
import 'package:krishi_sathi/src/features/chat/data/models/message_model.dart';

abstract class ChatDatasource {
  Future<MessageModel> getMessage(File media);
  Future<List<int>> getAudio(String text);
  Future<MessageModel> getFollowUp(AskBotRequestDto dto);
  Future<String> getAudioTranscript(File audioData);
}
