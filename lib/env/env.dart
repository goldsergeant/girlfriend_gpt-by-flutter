import 'package:envied/envied.dart';
part 'env.g.dart';

@Envied(path: '.env')
abstract class Env {
  @EnviedField(varName: 'OPEN_AI_API_KEY') // the .env variable.
  static const String apiKey = _Env.apiKey;
  @EnviedField(varName: 'SOCIAL_AUTH_GOOGLE_CLIENT_ID')
  static const String googleClientId = _Env.googleClientId;
  @EnviedField(varName: 'SOCIAL_AUTH_GOOGLE_SECRET')
  static const String googleSecret = _Env.googleSecret;
}
