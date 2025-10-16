enum AuthState{
  authIdeal,
  autSucces,
  authFailed,
  authCancle,
}

abstract class BiometricState{}

class currentauthState extends BiometricState{
  AuthState authState;
  currentauthState({required this.authState});
}