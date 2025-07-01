import 'package:equatable/equatable.dart';

class MessageEntity extends Equatable {
  final String insect;
  final String summaryEnglish;
  final String summaryNepali;
  final List<String> followupQuestionsEnglish;
  final List<String> followupQuestionsNepali;

  const MessageEntity({
    required this.insect,
    required this.summaryEnglish,
    required this.summaryNepali,
    required this.followupQuestionsEnglish,
    required this.followupQuestionsNepali,
  });

  @override
  List<Object?> get props => [
        insect,
        summaryEnglish,
        summaryNepali,
        followupQuestionsEnglish,
        followupQuestionsNepali
      ];
}
