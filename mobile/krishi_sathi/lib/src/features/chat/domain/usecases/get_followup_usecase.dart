import 'package:dartz/dartz.dart';
import 'package:krishi_sathi/src/core/domain/usecase/base_usecase.dart';
import 'package:krishi_sathi/src/core/error/failure.dart';
import 'package:krishi_sathi/src/features/chat/data/dto/ask_bot_request_dto.dart';
import 'package:krishi_sathi/src/features/chat/domain/entities/message.dart';
import 'package:krishi_sathi/src/features/chat/domain/repositories/chat_repository.dart';

class GetFollowupUsecase extends BaseUseCase<MessageEntity, AskBotRequestDto> {
  final ChatRepository chatRepository;

  GetFollowupUsecase({required this.chatRepository});
  @override
  Future<Either<Failure, MessageEntity>> call(AskBotRequestDto dto) {
    return chatRepository.getFollowUp(dto);
  }
}
