import 'package:shared_preferences/shared_preferences.dart';
import'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tradex_lite/Utility/script.dart';

import 'Model/WatchlistHivemodel.dart';
SharedPreferences? sharepref;
late Box loginbox;
late Box<WatchlistHiveModel> WatchlistBox;
String loginId = "";
bool isBiometricEnable = false;
