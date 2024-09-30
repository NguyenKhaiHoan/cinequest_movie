import 'package:cinequest/src/core/di/injection_container.import.dart';
import 'package:cinequest/src/external/services/storage/local/secure_storage_service.dart';
import 'package:cinequest/src/features/auth/data/data_sources/auth_local_datasource.dart';
import 'package:cinequest/src/features/auth/data/data_sources/auth_remote_datasource.dart';
import 'package:cinequest/src/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:cinequest/src/features/auth/domain/repositories/auth_repository.dart';
import 'package:cinequest/src/features/auth/domain/usecases/get_email_password.dart';
import 'package:cinequest/src/features/auth/domain/usecases/get_profile_user_use_case.dart';
import 'package:cinequest/src/features/auth/domain/usecases/login_use_case.dart';
import 'package:cinequest/src/features/auth/domain/usecases/save_email_password.dart';
import 'package:cinequest/src/features/auth/domain/usecases/save_profile_use_case.dart';
import 'package:cinequest/src/features/auth/domain/usecases/sign_out_use_case.dart';
import 'package:cinequest/src/features/auth/domain/usecases/sign_up_use_case.dart';
import 'package:cinequest/src/features/auth/domain/usecases/verificate_code_use_case.dart';

part 'auth_dependency.dart';
