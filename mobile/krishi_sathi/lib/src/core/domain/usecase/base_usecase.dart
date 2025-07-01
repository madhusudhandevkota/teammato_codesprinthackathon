import 'package:dartz/dartz.dart';
import 'package:krishi_sathi/src/core/error/failure.dart';

abstract class BaseUseCase<Type, Dto> {
  Future<Either<Failure, Type>> call(Dto dto);
}

abstract class StreamUseCase<Type, Params> {
  Either<Failure, Stream<Type>> call(Params params);
}

class NoParams {
  NoParams._internal();
  static final NoParams _instance = NoParams._internal();
  factory NoParams() => _instance;
}
