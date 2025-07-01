import 'package:krishi_sathi/src/config/container_injector.dart';
import 'package:krishi_sathi/src/features/chat/data/datasources/chat_datasource.dart';
import 'package:krishi_sathi/src/features/chat/data/datasources/chat_datasource_impl.dart';
import 'package:krishi_sathi/src/features/chat/data/repositories/chat_remote_repository.dart';
import 'package:krishi_sathi/src/features/chat/domain/repositories/chat_repository.dart';
import 'package:krishi_sathi/src/features/chat/domain/usecases/get_audio_transcript_usecase.dart';
import 'package:krishi_sathi/src/features/chat/domain/usecases/get_audio_usecase.dart';
import 'package:krishi_sathi/src/features/chat/domain/usecases/get_followup_usecase.dart';
import 'package:krishi_sathi/src/features/chat/domain/usecases/get_message_usecase.dart';
import 'package:krishi_sathi/src/features/chat/presentation/bloc/chat_bloc.dart';

void initChat() {
  sl.registerLazySingleton<ChatDatasource>(() => ChatDatasourceImpl(dio: sl()));
  sl.registerLazySingleton<ChatRepository>(
      () => ChatRemoteRepository(chatDatasource: sl()));
  sl.registerLazySingleton(() => GetMessageUsecase(chatRepository: sl()));
  sl.registerLazySingleton(() => GetAudioUsecase(chatRepository: sl()));
  sl.registerLazySingleton(() => GetFollowupUsecase(chatRepository: sl()));
  sl.registerLazySingleton(
      () => GetAudioTranscriptUsecase(chatRepository: sl()));
  sl.registerFactory<ChatBloc>(() => ChatBloc(
        getMessageUsecase: sl(),
        getAudioUsecase: sl(),
        getFollowupUsecase: sl(),
        getAudioTranscriptUsecase: sl(),
      ));
}
