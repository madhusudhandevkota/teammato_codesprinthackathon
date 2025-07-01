import 'package:dartz/dartz.dart';
import 'package:krishi_sathi/src/core/domain/usecase/base_usecase.dart';
import 'package:krishi_sathi/src/core/error/failure.dart';
import 'package:krishi_sathi/src/features/chat/domain/repositories/chat_repository.dart';

class GetAudioUsecase extends BaseUseCase<List<int>, String> {
  final ChatRepository chatRepository;

  GetAudioUsecase({required this.chatRepository});
  @override
  Future<Either<Failure, List<int>>> call(String dto) {
    return chatRepository.getAudio(dto);
  }
}
