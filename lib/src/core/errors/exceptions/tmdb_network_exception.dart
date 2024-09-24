import 'dart:io';

import 'package:cinequest/src/core/extensions/string_extension.dart';
import 'package:cinequest/src/core/network/model/tmdb_api_error_dto.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

class TMDBNetworkException extends Equatable {
  late final String message;

  TMDBNetworkException.fromDioException(DioException dioException) {
    switch (dioException.type) {
      case DioExceptionType.cancel:
        message = 'The request to the API server was cancelled'.hardcoded;
        break;
      case DioExceptionType.connectionTimeout:
        message = 'Connection to the API server timed out'.hardcoded;
        break;
      case DioExceptionType.receiveTimeout:
        message = 'Receiving response from the API server timed out'.hardcoded;
        break;
      case DioExceptionType.sendTimeout:
        message = 'Sending data to the API server timed out'.hardcoded;
        break;
      case DioExceptionType.connectionError:
        if (dioException.error is SocketException) {
          message = 'Please check your internet connection'.hardcoded;
        } else {
          message = 'An unexpected error occurred'.hardcoded;
        }
        break;
      case DioExceptionType.badCertificate:
        message = 'Invalid certificate received from the server'.hardcoded;
        break;
      case DioExceptionType.badResponse:
        final dto = TMDBApiErrorDto.fromJson(
            dioException.response?.data as Map<String, dynamic>);
        message = dto.statusMessage ??
            'Invalid response from the API server'.hardcoded;
        break;
      case DioExceptionType.unknown:
        message = 'An unknown error occurred'.hardcoded;
        break;
      default:
        message = 'An unexpected error occurred'.hardcoded;
        break;
    }
  }

  @override
  List<Object?> get props => [message];
}
