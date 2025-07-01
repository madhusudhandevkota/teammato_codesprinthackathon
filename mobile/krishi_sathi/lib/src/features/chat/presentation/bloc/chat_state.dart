part of 'chat_bloc.dart';

sealed class ChatState extends Equatable {
  const ChatState();

  @override
  List<Object> get props => [];
}

final class ChatInitial extends ChatState {}

class MessageLoading extends ChatState {
  const MessageLoading();
}

class MessageLoadingSuccess extends ChatState {
  final MessageEntity message;
  const MessageLoadingSuccess({required this.message});
}

class MessageLoadingFailed extends ChatState {
  final String message;
  const MessageLoadingFailed(this.message);
}

class AudioLoading extends ChatState {
  const AudioLoading();
}

class AudioLoadingSuccess extends ChatState {
  final List<int> audioBytes;

  const AudioLoadingSuccess({required this.audioBytes});
}

class AudioLoadingFailed extends ChatState {
  final String message;
  const AudioLoadingFailed(this.message);
}

class FollowUpLoading extends ChatState {
  const FollowUpLoading();
}

class FollowUpSuccess extends ChatState {
  final MessageEntity followup;
  const FollowUpSuccess({required this.followup});
}

class FollowUpFailed extends ChatState {
  final String message;
  const FollowUpFailed(this.message);
}

class AudioTranscriptLoading extends ChatState {
  const AudioTranscriptLoading();
}

class AudioTranscriptSuccess extends ChatState {
  final String audioTranscript;
  const AudioTranscriptSuccess({required this.audioTranscript});
}

class AudioTranscriptfailed extends ChatState {
  final String message;
  const AudioTranscriptfailed(this.message);
}
