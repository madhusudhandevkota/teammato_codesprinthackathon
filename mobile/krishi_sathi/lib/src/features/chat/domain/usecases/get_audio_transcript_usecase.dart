import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:krishi_sathi/src/core/domain/usecase/base_usecase.dart';
import 'package:krishi_sathi/src/core/error/failure.dart';
import 'package:krishi_sathi/src/features/chat/domain/repositories/chat_repository.dart';

class GetAudioTranscriptUsecase extends BaseUseCase<String, File> {
  final ChatRepository chatRepository;

  GetAudioTranscriptUsecase({required this.chatRepository});
  @override
  Future<Either<Failure, String>> call(dto) {
    return chatRepository.getAudioTranscript(dto);
  }
}
