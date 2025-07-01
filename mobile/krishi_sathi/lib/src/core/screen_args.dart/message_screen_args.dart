import 'dart:io';

import 'package:krishi_sathi/src/features/chat/domain/entities/message.dart';

class MessageScreenArgs {
  final MessageEntity message;
  final File media;

  MessageScreenArgs({required this.message, required this.media});
}

class FollowupScreenArgs {
  final String question;
  final MessageEntity message;

  FollowupScreenArgs({required this.question, required this.message});
}

class SuggestedQuestionScreenArgs {
  final List<String> suggestedQuestionsEnglish;
  final List<String> suggestedQuestionsNepali;
  final String insect;

  SuggestedQuestionScreenArgs(
      {required this.suggestedQuestionsEnglish,
      required this.suggestedQuestionsNepali,
      required this.insect});
}
