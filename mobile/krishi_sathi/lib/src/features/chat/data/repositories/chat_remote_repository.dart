import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:krishi_sathi/src/core/domain/mappers/message_mappers.dart';
import 'package:krishi_sathi/src/core/error/failure.dart';
import 'package:krishi_sathi/src/features/chat/data/datasources/chat_datasource.dart';
import 'package:krishi_sathi/src/features/chat/data/dto/ask_bot_request_dto.dart';
import 'package:krishi_sathi/src/features/chat/data/models/message_model.dart';
import 'package:krishi_sathi/src/features/chat/domain/entities/message.dart';
import 'package:krishi_sathi/src/features/chat/domain/repositories/chat_repository.dart';

class ChatRemoteRepository implements ChatRepository {
  final ChatDatasource chatDatasource;

  ChatRemoteRepository({required this.chatDatasource});
  @override
  Future<Either<Failure, MessageEntity>> getMessage(File media) async {
    try {
      final MessageModel messageModel = await chatDatasource.getMessage(media);
      return Right(messageModel.toDomain());
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<int>>> getAudio(String text) async {
    try {
      final List<int> audioBytes = await chatDatasource.getAudio(text);
      return Right(audioBytes);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, MessageEntity>> getFollowUp(
      AskBotRequestDto dto) async {
    try {
      final MessageModel messageModel = await chatDatasource.getFollowUp(dto);
      return Right(messageModel.toDomain());
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> getAudioTranscript(File audioData) async {
    try {
      final String audioTranscript =
          await chatDatasource.getAudioTranscript(audioData);
      return Right(audioTranscript);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }
}
