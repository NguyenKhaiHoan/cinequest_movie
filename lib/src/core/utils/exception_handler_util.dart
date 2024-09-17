import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';

import '../errors/failure.dart';

class ExceptionHandlerUtil {
  ExceptionHandlerUtil._();

  static Future<Either<Failure, T>> executeWithExceptionHandling<T>(
      Future<T> Function() action) async {
    try {
      final result = await action();
      return Right(result);
    } on DioException catch (e) {
      return Left(
        Failure(
            exception: e,
            message: e.message ?? 'Dio exception',
            stackTrace: e.stackTrace),
      );
    } on FirebaseException catch (e) {
      return Left(
        Failure(
          exception: e,
          message: e.message ?? 'Firebase Exception.',
        ),
      );
    } catch (e) {
      return Left(
        Failure(exception: e as Exception, message: e.toString()),
      );
    }
  }

  static Future<T> executeWithoutExceptionHandling<T>(
      Future<T> Function() action) async {
    try {
      final result = await action();
      return result;
    } catch (e) {
      rethrow;
    }
  }
}
