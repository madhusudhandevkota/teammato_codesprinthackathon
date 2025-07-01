import 'package:dio/dio.dart';
import 'package:krishi_sathi/src/core/http/api_endpoints.dart';
import 'package:krishi_sathi/src/core/http/dio_service_interceptor.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class HttpService {
  final Dio _dio;

  Dio get dio => _dio;

  HttpService(this._dio) {
    _dio
      ..options.baseUrl = ApiEndpoints.baseUrl
      ..options.connectTimeout = ApiEndpoints.connectionTimeout
      ..options.receiveTimeout = ApiEndpoints.receiveTimeout
      ..options.responseType = ResponseType.plain
      ..options.headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      }
      ..interceptors.add(DioErrorInterceptor())
      ..interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
        responseBody: true,
        error: true,
        compact: false,
        maxWidth: 90,
      ));
  }
}
