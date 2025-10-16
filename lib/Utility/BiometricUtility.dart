import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
class Biometricutility {
  static final LocalAuthentication auth = LocalAuthentication();

// _SupportState _supportState = _SupportState.unknown;
  late final bool? _canCheckBiometrics;
  List<BiometricType>? _availableBiometrics;
  String _authorized = 'Not Authorized';
  bool _isAuthenticating = false;

  LocalAuthentication getLocalAuthinstance(){
    return auth;
  }

  checkBiometrics() async {
    late bool canCheckBiometrics;
    try {
      canCheckBiometrics = await auth.canCheckBiometrics;
    } on PlatformException catch (e) {
      canCheckBiometrics = false;
      print(e);
    }
    _canCheckBiometrics = canCheckBiometrics;
    return canCheckBiometrics;
  }
}