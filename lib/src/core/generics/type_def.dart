import 'package:cinequest/src/core/errors/failure.dart';
import 'package:dartz/dartz.dart';

/// Sử dụng typedef để rút gọn Future<Either<Failure, Type>>
typedef FutureEither<Type> = Future<Either<Failure, Type>>;
