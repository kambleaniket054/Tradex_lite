import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tradex_lite/Blocs/ThemeBloc.dart';
import 'package:tradex_lite/Utility/Model/user.dart';
import 'package:tradex_lite/Utility/varUtility.dart';

import '../Blocs/ThemeState.dart';
import '../Blocs/themeEvent.dart';
import '../Utility/BiometricUtility.dart';
import '../Utility/Dialogutility.dart';
import '../Utility/loginutility.dart';
import '../main.dart';

class login extends StatefulWidget{
  createState() => loginState();
}

class loginState extends State<login>{
  TextEditingController _conEmail =  TextEditingController();
  TextEditingController _conPass =  TextEditingController();

  @override
  void initState() {
    if(loginId != ''){
      if (loginbox.get(loginId) != null && loginbox.get(loginId)?.isbiometricEnable == true) {
        UserModel? user  = loginbox.get(loginId);
        WidgetsBinding.instance.addPostFrameCallback((v){
           if (user!.isbiometricEnable) {
             getBiometric(context);
           }
        });
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   actions: [
      //     IconButton(onPressed: (){
      //       final state = context.read<Themebloc>().state as currentThemeState;
      //       context.read<Themebloc>().add(onthemeSwitchtoggle(isdark: !state.isdark));
      //     }, icon: Icon(Icons.brightness_4_outlined,color: Theme.of(context).iconTheme.color,))
      //   ],
      // ),
      body: SafeArea(
        top: true,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 26),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Login",style: Theme.of(context).textTheme.headlineLarge,),
              SizedBox(height: 27,),
              TextFormField(
                controller: _conEmail,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  hintText: "Email",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.outlineVariant,
                        )
                    )
                ),
              ),
              SizedBox(height: 16,),
              TextFormField(
                controller: _conPass,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  hintText: "password",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.outlineVariant,
                    )
                  )
                ),
              ),
              SizedBox(height: 27,),
              InkWell(
                onTap: () async {

                 var res = await logininitialize(_conEmail.text, _conPass.text);
                  if (res == "User not found") {
                   showRegisterBottomSheet(context, onTap:() async {
                     final newuser = UserModel(email: _conEmail.text,password: _conPass.text);
                     var res = await register(newuser);
                     if (res == "success") {
                       loginId = newuser.email;
                       activeuserbox.put('username',newuser.email);
                       bool isbioAvaliable = await Biometricutility().checkBiometrics();
                       if(isbioAvaliable){
                         return showSetBiometricBottomSheet(context);
                       }
                     }
                     else{
                       Fluttertoast.showToast(msg:"Oops Something Went Wrong",toastLength: Toast.LENGTH_SHORT,gravity: ToastGravity.BOTTOM,);
                     }
                   });
                  }
                  else if(res == "Invalide Password"){
                    Fluttertoast.showToast(msg:res,toastLength: Toast.LENGTH_SHORT,gravity: ToastGravity.BOTTOM,);
                  }
                  else{
                    bool isbioAvaliable = await Biometricutility().checkBiometrics();
                    if(isbioAvaliable){
                      if (user!.isbiometricEnable) {
                        return showLoginBiometricBottomSheet(context,title: 'Login');
                      }
                      else{
                        return showSetBiometricBottomSheet(context);
                      }
                    }
                    else {
                      Navigator.pushReplacement(context, MaterialPageRoute(
                          builder: (context) => MyHomePage(title: "Home Page")));
                    }
                  }

                  // loginbox.put('password',_conPass.text);
                  // loginbox.put('isbiometricset', isBiometricEnable)

                  },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Theme.of(context).colorScheme.primary
                  ),
                  padding: EdgeInsets.symmetric(vertical: 8),
                  width: MediaQuery.of(context).size.width,
                  child: Center(child: Text("Login / Register",style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.white),)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> getBiometric(BuildContext context) async {
   bool isbioAvaliable = await Biometricutility().checkBiometrics();
    if(isbioAvaliable == true){
      showLoginBiometricBottomSheet(context,title: 'Login');
    }
    else{
      Fluttertoast.showToast(msg:"Biometric not available",toastLength: Toast.LENGTH_SHORT,gravity: ToastGravity.BOTTOM,);
    }
  }
}