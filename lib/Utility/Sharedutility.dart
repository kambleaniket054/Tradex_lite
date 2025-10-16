import 'package:shared_preferences/shared_preferences.dart';
import 'package:tradex_lite/Utility/varUtility.dart';

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

getSaveddata(){
 if (sharepref != null) {
  loginId = sharepref!.getString("loginId") ?? '1234';
   isBiometricEnable = sharepref!.getBool("isBiometricEnable") ?? true;
 }
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