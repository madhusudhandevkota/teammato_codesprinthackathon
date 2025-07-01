import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:krishi_sathi/src/core/domain/usecase/base_usecase.dart';
import 'package:krishi_sathi/src/core/error/failure.dart';
import 'package:krishi_sathi/src/features/chat/domain/entities/message.dart';
import 'package:krishi_sathi/src/features/chat/domain/repositories/chat_repository.dart';

class GetMessageUsecase extends BaseUseCase<MessageEntity, File> {
  final ChatRepository chatRepository;

  GetMessageUsecase({required this.chatRepository});

  @override
  Future<Either<Failure, MessageEntity>> call(File dto) {
    return chatRepository.getMessage(dto);
  }
}
