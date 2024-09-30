import 'package:cinequest/firebase_options.dart';
import 'package:cinequest/src/common/di/common_dependency.dart';
import 'package:cinequest/src/core/network/dio_client.dart';
import 'package:cinequest/src/core/repositories/user_repository.dart';
import 'package:cinequest/src/external/apis/themovidedb/tmdb_api.dart';
import 'package:cinequest/src/external/services/connectivity/connectivity_service.dart';
import 'package:cinequest/src/external/services/storage/local/get_storage_service.dart';
import 'package:cinequest/src/external/services/storage/local/secure_storage_service.dart';
import 'package:cinequest/src/external/services/storage/local/shared_preferences_service.dart';
import 'package:cinequest/src/external/services/storage/local/sqlite_service.dart';
import 'package:cinequest/src/features/auth/di/auth_dependency.import.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

part 'injection_container.dart';

final sl = GetIt.instance;
