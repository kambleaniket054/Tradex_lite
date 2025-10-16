import 'package:local_auth/local_auth.dart';

abstract class BiomtricEvent{
}
 class onAuthenticate extends BiomtricEvent{
  onAuthenticate();
}

class onAuthenticationCancle extends BiomtricEvent{
  LocalAuthentication auth;
  onAuthenticationCancle({required this.auth});
}