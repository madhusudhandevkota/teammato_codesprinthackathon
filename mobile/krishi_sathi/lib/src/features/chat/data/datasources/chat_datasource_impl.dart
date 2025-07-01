import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:krishi_sathi/src/core/error/failure.dart';
import 'package:krishi_sathi/src/core/http/api_endpoints.dart';
import 'package:krishi_sathi/src/core/http/handle_error_response.dart';
import 'package:krishi_sathi/src/features/chat/data/datasources/chat_datasource.dart';
import 'package:krishi_sathi/src/features/chat/data/dto/ask_bot_request_dto.dart';
import 'package:krishi_sathi/src/features/chat/data/models/message_model.dart';

class ChatDatasourceImpl implements ChatDatasource {
  final Dio dio;

  ChatDatasourceImpl({required this.dio});

  @override
  Future<MessageModel> getMessage(File media) async {
    try {
      FormData mediaData = FormData.fromMap({
        'image': await MultipartFile.fromFile(
          media.path,
          filename: media.path.split('/').last,
        ),
      });

      final res = await dio.post(ApiEndpoints.uploadImage, data: mediaData);

      if (res.statusCode == 200) {
        return MessageModel.fromJson(
            jsonDecode(res.data) as Map<String, dynamic>);
      } else {
        throw Failure(
          message: res.statusMessage.toString(),
          statusCode: res.statusCode.toString(),
        );
      }
    } on DioException catch (e) {
      print("DioException: ${e.message}");
      return await handleErrorResponse(e);
    }
  }

  @override
  Future<List<int>> getAudio(String text) async {
    try {
      final response = await dio.post(
        ApiEndpoints.getAudio,
        data: jsonEncode({"text": text}),
        options: Options(
          headers: {'Content-Type': 'application/json'},
          responseType: ResponseType.bytes,
        ),
      );

      if (response.statusCode == 200) {
        return response.data as List<int>;
      } else {
        throw Failure(
          message: response.statusMessage ?? 'Unknown error',
          statusCode: response.statusCode.toString(),
        );
      }
    } on DioException catch (e) {
      print("DioException: ${e.message}");
      return await handleErrorResponse(e);
    }
  }

  @override
  Future<MessageModel> getFollowUp(AskBotRequestDto dto) async {
    try {
      var res = await dio.post(ApiEndpoints.askBot, data: dto.toJson());
      print("req data ${dto.toJson()}");
      print("Response data ${res.data}");
      if (res.statusCode == 200) {
        return MessageModel.fromJson(
            jsonDecode(res.data) as Map<String, dynamic>);
      } else {
        throw Failure(
          message: res.statusMessage.toString(),
          statusCode: res.statusCode.toString(),
        );
      }
    } on DioException catch (e) {
      return await handleErrorResponse(e);
    }
  }

  @override
  Future<String> getAudioTranscript(File audioData) async {
    try {
      print("media ${audioData.path}+++++++++");
      FormData mediaData = FormData.fromMap({
        'audio': await MultipartFile.fromFile(
          audioData.path,
          filename: audioData.path.split('/').last,
        ),
      });
      final res = await dio.post(ApiEndpoints.audioTranscript, data: mediaData);
      if (res.statusCode == 200) {
        print("Audio uploaded successfully!");
        return (res.toString());
        // return ("res.toString()");
      } else {
        throw Failure(
          message: res.statusMessage.toString(),
          statusCode: res.statusCode.toString(),
        );
      }
    } on DioException catch (e) {
      print("DioException: ${e.message}");
      return await handleErrorResponse(e);
    }
  }
}
