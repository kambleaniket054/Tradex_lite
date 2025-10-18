import 'package:hive/hive.dart';
part 'user.g.dart';
@HiveType(typeId: 0)
class UserModel extends HiveObject {
  @HiveField(0)
  final String email;

  @HiveField(1)
  final String password;

  @HiveField(2)
  bool isbiometricEnable;

  UserModel({
    required this.email,
    required this.password,
    this.isbiometricEnable = false,
  });
}