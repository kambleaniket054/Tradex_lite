import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tradex_lite/Blocs/ThemeBloc.dart';
import 'package:tradex_lite/Utility/varUtility.dart';

import '../Blocs/ThemeState.dart';
import '../Blocs/themeEvent.dart';
import '../Utility/BiometricUtility.dart';
import '../Utility/Dialogutility.dart';
import '../main.dart';

class login extends StatefulWidget{
  createState() => loginState();
}

class loginState extends State<login>{
  TextEditingController _conEmail =  TextEditingController();
  TextEditingController _conPass =  TextEditingController();

  @override
  void initState() {
    if(loginId != '' && isBiometricEnable){
      WidgetsBinding.instance.addPostFrameCallback((v){
         getBiometric();
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: (){
            final state = context.read<Themebloc>().state as currentThemeState;
            context.read<Themebloc>().add(onthemeSwitchtoggle(isdark: !state.isdark));
          }, icon: Icon(Icons.brightness_4_outlined,color: Theme.of(context).iconTheme.color,))
        ],
      ),
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
                  loginbox.put('LoginId',_conEmail.text);
                  loginbox.put('password',_conPass.text);
                  // loginbox.put('isbiometricset', isBiometricEnable)
                  bool isbioAvaliable = await Biometricutility().checkBiometrics();
                  if(isbioAvaliable){
                   return showSetBiometricBottomSheet(context);
                  }
                  else {
                    Navigator.pushReplacement(context, MaterialPageRoute(
                        builder: (context) => MyHomePage(title: "Home Page")));
                  }
                  },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Theme.of(context).colorScheme.primary
                  ),
                  padding: EdgeInsets.symmetric(vertical: 8),
                  width: MediaQuery.of(context).size.width,
                  child: Center(child: Text("Login",style: Theme.of(context).textTheme.headlineLarge?.copyWith(color: Colors.white),)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> getBiometric() async {
   bool isbioAvaliable = await Biometricutility().checkBiometrics();
    if(isbioAvaliable == true){
      showLoginBiometricBottomSheet(context);
    }
    else{
      Fluttertoast.showToast(msg:"Biometric not available",toastLength: Toast.LENGTH_SHORT,gravity: ToastGravity.BOTTOM,);
    }
  }
}