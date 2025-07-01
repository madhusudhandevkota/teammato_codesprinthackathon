import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class MessageModel extends Equatable {
  final String insect;
  final String summaryEnglish;
  final String summaryNepali;
  final List<String> followupQuestionsEnglish;
  final List<String> followupQuestionsNepali;

  const MessageModel({
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

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      insect: json['insect'] as String,
      // insect: "insect",
      summaryEnglish: json['message']['summary']['summary_english'] as String,
      summaryNepali: json['message']['summary']['summary_nepali'] as String,
      followupQuestionsEnglish: List<String>.from(
          json['message']['followup_questions']['english'] as List),
      followupQuestionsNepali: List<String>.from(
          json['message']['followup_questions']['nepali'] as List),
    );
  }
}
