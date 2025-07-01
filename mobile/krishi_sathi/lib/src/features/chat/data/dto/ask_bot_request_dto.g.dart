// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ask_bot_request_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AskBotRequestDto _$AskBotRequestDtoFromJson(Map<String, dynamic> json) =>
    AskBotRequestDto(
      text: json['text'] as String,
      insect: json['insect'] as String,
    );

Map<String, dynamic> _$AskBotRequestDtoToJson(AskBotRequestDto instance) =>
    <String, dynamic>{
      'text': instance.text,
      'insect': instance.insect,
    };
