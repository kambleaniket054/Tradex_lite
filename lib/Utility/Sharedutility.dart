import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tradex_lite/Utility/script.dart';
import 'package:tradex_lite/Utility/varUtility.dart';
import 'package:tradex_lite/View/Login.dart';

import 'Model/WatchlistHivemodel.dart';

setsharedpref(String type, String lable,dynamic val){
  if(sharepref != null){
    if(type == 'bool'){
      sharepref!.setBool(lable, val);
    }else if(type == 'int'){
      sharepref!.setInt(lable, val);
    }
    else if(type == 'string'){
      sharepref!.setString(lable, val);
    }
    else if(type == 'double'){
      sharepref!.setDouble(lable, val);
    }
  }
}

initSharepref() async {
  // if(sharepref == null){
  sharepref = await SharedPreferences.getInstance();
  getSaveddata();
  // }
}

initHive()async{
 await Hive.initFlutter();
 await createbox("login");
 await createbox("watchlist");
 getSaveddata();
}

createbox(String Boxname) async {
    if (Boxname == 'login') {
      loginbox = await Hive.openBox(Boxname);
    }
    else {
      Hive.registerAdapter(ScriptAdapter());
      Hive.registerAdapter(WatchlistHiveModelAdapter());
      WatchlistBox = await Hive.openBox(Boxname);
    }
}

getSaveddata(){
  if(loginbox.get('LoginId') != null){
    loginId = loginbox.get('LoginId');
  }
  if(loginbox.get('password') != null){
    loginId = loginbox.get('password');
  }
  if(loginbox.get("isbiometricset") != null){
    isBiometricEnable = loginbox.get("isbiometricset");
  }
 // if (sharepref != null) {
 //  loginId = sharepref!.getString("loginId") ?? '1234';
 //   isBiometricEnable = sharepref!.getBool("isBiometricEnable") ?? true;
 // }
}

getsharedpref(String type, String lable){
  var val;
  if(sharepref != null){
    if(type == 'bool'){
      val = sharepref!.getBool(lable);
    }else if(type == 'int'){
      val =  sharepref!.getInt(lable);
    }
    else if(type == 'string'){
      val = sharepref!.getString(lable);
    }
    else if(type == 'double'){
      val = sharepref!.getDouble(lable);
    }
    return val;
  }
  else{
    return '';
  }
}