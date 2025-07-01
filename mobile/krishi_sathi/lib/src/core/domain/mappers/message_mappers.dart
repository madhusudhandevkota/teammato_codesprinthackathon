import 'package:krishi_sathi/src/features/chat/data/models/message_model.dart';
import 'package:krishi_sathi/src/features/chat/domain/entities/message.dart';

extension MessageModelExtension on MessageModel {
  MessageEntity toDomain() => MessageEntity(
        insect: insect,
        summaryEnglish: summaryEnglish,
        summaryNepali: summaryNepali,
        followupQuestionsEnglish: followupQuestionsEnglish.toList(),
        followupQuestionsNepali: followupQuestionsNepali.toList(),
      );
}
