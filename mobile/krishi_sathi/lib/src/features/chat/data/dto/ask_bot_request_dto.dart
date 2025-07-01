import 'package:json_annotation/json_annotation.dart';

part 'ask_bot_request_dto.g.dart';

@JsonSerializable()
class AskBotRequestDto {
  final String text;
  final String insect;

  AskBotRequestDto({required this.text, required this.insect});

  factory AskBotRequestDto.fromJson(Map<String, dynamic> json) =>
      _$AskBotRequestDtoFromJson(json);

  Map<String, dynamic> toJson() => _$AskBotRequestDtoToJson(this);
}
