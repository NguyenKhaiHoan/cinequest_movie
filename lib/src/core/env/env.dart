import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env')
final class Env {
  @EnviedField(varName: 'MOVIEDB_API_KEY', obfuscate: true)
  static final String movieDbApiKey = _Env.movieDbApiKey;
}
