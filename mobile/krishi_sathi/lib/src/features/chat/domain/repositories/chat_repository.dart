import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:krishi_sathi/src/core/error/failure.dart';
import 'package:krishi_sathi/src/features/chat/data/dto/ask_bot_request_dto.dart';
import 'package:krishi_sathi/src/features/chat/domain/entities/message.dart';

abstract class ChatRepository {
  Future<Either<Failure, MessageEntity>> getMessage(File media);
  Future<Either<Failure, List<int>>> getAudio(String text);
  Future<Either<Failure, MessageEntity>> getFollowUp(AskBotRequestDto dto);
  Future<Either<Failure, String>> getAudioTranscript(File audioData);
}
