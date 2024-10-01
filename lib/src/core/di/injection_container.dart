import 'package:cinequest/src/common/common_dependency.dart';
import 'package:cinequest/src/external/external_dependency.dart';
import 'package:cinequest/src/features/auth/auth_dependency.dart';
import 'package:cinequest/src/features/movie/movie_dependency.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

/// Khởi tạo phụ thuộc
Future<void> initDependencies() async {
  CommonDependency.init();
  ExternalDependency.init();
  AuthDependency.init();
  MovieDependency.init();
}
