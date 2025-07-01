part of 'chat_bloc.dart';

sealed class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object> get props => [];
}

class GetMessage extends ChatEvent {
  final File media;

  const GetMessage({required this.media});
}

class GetAudio extends ChatEvent {
  final String text;

  const GetAudio({required this.text});
}

class GetFollowUp extends ChatEvent {
  final AskBotRequestDto dto;

  const GetFollowUp({required this.dto});
}

class GetAudioTranscript extends ChatEvent {
  final File audioData;
  const GetAudioTranscript({required this.audioData});
}
