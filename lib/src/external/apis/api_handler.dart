import 'dart:io';

import 'package:cinequest/src/core/errors/failure.dart';
import 'package:cinequest/src/core/utils/exception_handler_util.dart';
import 'package:dartz/dartz.dart';
import 'package:retrofit/retrofit.dart';

abstract class ApiHandler {
  Future<Either<Failure, T>> fetchData<T>({
    required Future<HttpResponse> Function() apiCall,
    required T Function(dynamic data) dtoToEntity,
    int statusCode = HttpStatus.ok,
  }) async {
    return ExceptionHandlerUtil.executeWithExceptionHandling(() async {
      final httpResponse = await apiCall();
      if (httpResponse.response.statusCode == statusCode) {
        final dto = httpResponse.data;
        final entity = dtoToEntity(dto);
        return entity;
      } else {
        throw Exception(
          httpResponse.response.statusMessage ?? 'Api exception',
        );
      }
    });
  }

  Future<Either<Failure, List<T>>> fetchDataList<T>({
    required Future<HttpResponse> Function() apiCall,
    required List<T> Function(List<dynamic> data) dtoToEntity,
    int statusCode = HttpStatus.ok,
  }) async {
    return ExceptionHandlerUtil.executeWithExceptionHandling(() async {
      final httpResponse = await apiCall();
      if (httpResponse.response.statusCode == statusCode) {
        final dtos = httpResponse.data as List<dynamic>;
        final entity = dtoToEntity(dtos);
        return entity;
      } else {
        throw Exception(
          httpResponse.response.statusMessage ?? 'Api exception',
        );
      }
    });
  }
}
