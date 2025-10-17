import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:local_auth/local_auth.dart';
import 'package:tradex_lite/Utility/varUtility.dart';

import 'BiometricEvent.dart';
import 'BiometricState.dart';

class Biometricbloc extends Bloc<BiomtricEvent, BiometricState>{
  LocalAuthentication auth;
  Biometricbloc(this.auth) : super(currentauthState(authState: AuthState.authIdeal)){
   on<onAuthenticate>(AuthenticateBiometric);
   on<onAuthenticationCancle>(cancleAuthentication);
 }

  Future<void> AuthenticateBiometric(onAuthenticate event, Emitter<BiometricState> emit) async {
   try {
     final bool authenticated = await auth.authenticate(
        localizedReason: 'Let OS determine authentication method',
        options: const AuthenticationOptions(
          biometricOnly: true,
          stickyAuth: true,
        ),
      );
     if(authenticated){
       loginbox.put("isbiometricset", true);
       emit(currentauthState(authState: AuthState.autSucces));
     }
     else{
       loginbox.put("isbiometricset", false);
       emit(currentauthState(authState: AuthState.authFailed));
     }
   }  catch (e) {
     loginbox.put("isbiometricset", false);
     print(e.toString());// TODO
     emit(currentauthState(authState: AuthState.authFailed));
   }
  }

  FutureOr<void> cancleAuthentication(onAuthenticationCancle event, Emitter<BiometricState> emit) {
    auth.stopAuthentication();
    emit(currentauthState(authState: AuthState.authCancle));
  }
}