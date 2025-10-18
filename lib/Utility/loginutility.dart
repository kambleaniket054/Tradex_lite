import 'package:tradex_lite/Utility/varUtility.dart';

import 'Model/user.dart';
UserModel? user;
Future logininitialize(String email, String password) async {
  final userloged = loginbox.get(email);
  if (userloged == null) return "User not found";
  else if (userloged.password != password) return "Invalide Password";
  user = userloged;
  return "Success logeded in";
}

Future<String?> register(UserModel user) async {
  // Check if user already exists
  try {
    final existing = loginbox.values.firstWhere(
          (u) => u.email == user.email,
      orElse: () => UserModel(email: "", password: "", isbiometricEnable: false),
    );

    if (existing.email.isNotEmpty) {
      return "User already registered!";
    }

    await loginbox.put(user.email, user);
    return "success";
  }  catch (e) {
    return 'failed';// TODO
  }
// success
}