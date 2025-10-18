import 'package:shared_preferences/shared_preferences.dart';
import'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tradex_lite/Utility/Model/AlertsModel.dart';
import 'package:tradex_lite/Utility/Model/script.dart';
import 'package:tradex_lite/Utility/Model/user.dart';

import 'Model/WatchlistHivemodel.dart';
SharedPreferences? sharepref;
late Box<UserModel> loginbox;
late Box preferdTheme;
late Box activeuserbox;
late Box<WatchlistHiveModel> WatchlistBox;
String loginId = "";
bool isBiometricEnable = false;

List<alertsModel> alerts = [];
