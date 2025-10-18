
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';
import 'package:tradex_lite/Blocs/ThemeBloc.dart';
import 'package:tradex_lite/Blocs/ThemeState.dart';
import 'package:tradex_lite/Blocs/Watchlistbloc/watchlist_event.dart';
import 'package:tradex_lite/Blocs/Watchlistbloc/watchlistbloc.dart';
import 'package:tradex_lite/Blocs/biometricbloc/BiometricEvent.dart';
import 'package:tradex_lite/Utility/BiometricUtility.dart';
import 'package:tradex_lite/Utility/Model/AlertsModel.dart';
import 'package:tradex_lite/Utility/Model/script.dart';
import 'package:tradex_lite/Utility/varUtility.dart';
import 'package:tradex_lite/View/watchlist.dart';

import '../Blocs/Watchlistbloc/watchlist_state.dart';
import '../Blocs/biometricbloc/BiometricBloc.dart';
import '../Blocs/biometricbloc/BiometricState.dart';
import '../Blocs/themeEvent.dart';

showCustomInfoBottomSheet(BuildContext mcontext,Script scrip,int index){
  showModalBottomSheet(
      context: mcontext, builder: (context){
        List<double> prevltp = [];
        prevltp = scrip.prevltp;
    return SafeArea(
      top: false,
      bottom: true,
      child: BlocProvider.value(
        value: mcontext.read<WatchlistBloc>(),
        child: BlocBuilder<WatchlistBloc,WatchlistState>(
          builder: (context,state) {
            final currentWatchlist = state.watchlists[state.selectedTab];
            final currentScripts = state.scripts[currentWatchlist] ?? [];
            scrip = currentScripts[index];
            prevltp.add(scrip.ltp);
            var currenytype = '₹';
            currencystate currency = (context.read<Themebloc>().state as currentThemeState).currency != null ? (context.read<Themebloc>().state as currentThemeState).currency : currencystate.INR;
            if(currency == currencystate.INR){
              currenytype = '₹';
            }
            else{
              currenytype = r'$';
            }
            return Container(
                margin: EdgeInsets.symmetric(horizontal: 12,vertical: 8),
                padding: EdgeInsets.symmetric(horizontal: 12,vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Theme.of(context).colorScheme.surface,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(scrip.symbol,style: Theme.of(context).textTheme.bodyLarge,),
                                SizedBox(width: 14,),
                                Text(scrip.exchange,style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.grey),),
                              ],
                            ),
                            Text(scrip.company)
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(currenytype+" "+scrip.ltp.toString(),style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: scrip.ltp > scrip.close ? Colors.green : Colors.red,
                            ),),
                            Text(scrip.change.toString()+" %",style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: scrip.ltp > scrip.close ? Colors.green : Colors.red,
                            ),)
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 12,),
                    Divider(),
                    SizedBox(height: 16,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(children: [
                          Text("Open"),
                          Text(scrip.open.toString()),
                        ],),
                        Column(children: [
                          Text("High"),
                          Text(scrip.high.toString()),
                        ],),
                        Column(children: [
                          Text("Low"),
                          Text(scrip.low.toString()),
                        ],),
                        Column(children: [
                          Text("Close"),
                          Text(scrip.close.toString()),
                        ],),
                      ],
                    ),
                    SizedBox(height: 27,),
                     SfSparkLineChart(
                  color: scrip.ltp > scrip.close ? Colors.green : Colors.red,
                  width: 2,
                  axisLineWidth: 0,
                  data: prevltp.map((e) => e.toDouble()).toList(),),

                    SizedBox(height: 27,),
                    InkWell(
                      onTap: (){
                        showsetAlertBottomSheet(context,scrip);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Theme.of(context).colorScheme.primary
                        ),
                        padding: EdgeInsets.symmetric(vertical: 8),
                        width: MediaQuery.of(context).size.width,
                        child: Center(child: Text("Set Alert",style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.white),)),
                      ),
                    ),                  ],
                )
            );
          }
        ),
      ),
    );
  });
}

showsetAlertBottomSheet(BuildContext context,Script scrip){
  TextEditingController _contragetprice = TextEditingController();
  showModalBottomSheet(context: context,
      backgroundColor: Colors.transparent,
      builder: (context){
    return SafeArea(
      top: false,
      bottom: true,
      child: Container(
          margin: EdgeInsets.symmetric(horizontal: 12,vertical: 8),
          padding: EdgeInsets.symmetric(horizontal: 12,vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Theme.of(context).colorScheme.surface,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Set Alert",style: Theme.of(context).textTheme.headlineLarge,),
              SizedBox(height: 16,),
              Text("Enter Target Price",style: Theme.of(context).textTheme.bodyMedium,),
              SizedBox(height: 16,),
              TextFormField(
                controller: _contragetprice,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: "Target price",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18)
                  ),
                ),
                onChanged: (val){
                },
              ),
              SizedBox(height: 27,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: InkWell(
                      onTap: (){
                        Navigator.of(context).pop();
                        if(_contragetprice.text != ''){
                          final alertm = alertsModel(Scriptname: scrip.symbol, traget_price: double.parse(_contragetprice.text.toString()));
                        alerts.add(alertm);
                        Fluttertoast.showToast(msg: "Alert set Successfully");
                        }
                        // showLoginBiometricBottomSheet(context);
                        // }
                        // else{
                        //   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> watchlist()));
                        // }
                      },
                      child: Container(
                        padding:EdgeInsets.only(top: 12,bottom: 12),
                        width: double.maxFinite,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        child: Center(child: Text("Set",style: Theme.of(context).textTheme.labelMedium?.copyWith(color: Colors.white),)),
                      ),
                    ),
                  ),
                  SizedBox(width: 16,),
                  Flexible(
                    child: InkWell(
                      onTap: (){
                        Navigator.pop(context);

                      },
                      child: Container(
                        padding:EdgeInsets.only(top: 12,bottom: 12),
                        width: double.maxFinite,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Theme.of(context).colorScheme.inverseSurface.withAlpha(12),
                        ),
                        child: Center(child: Text("Cancle",style: Theme.of(context).textTheme.labelMedium,)),
                      ),
                    ),
                  )
                ],
              )
            ],
          )
      ),
    );});
}


showSetBiometricBottomSheet(BuildContext context){
  showModalBottomSheet(context: context,
     backgroundColor: Colors.transparent,
      builder: (context){
    return SafeArea(
      top: false,
      bottom: true,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 12,vertical: 8),
        padding: EdgeInsets.symmetric(horizontal: 12,vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).colorScheme.surface,
        ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
          children: [
            Text("Set Biometric",style: Theme.of(context).textTheme.headlineLarge,),
            SizedBox(height: 16,),
            Text("Set Biometric For Swift login",style: Theme.of(context).textTheme.bodyMedium,),
            SizedBox(height: 27,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: InkWell(
                    onTap: (){
                      Navigator.of(context).pop();
                        showLoginBiometricBottomSheet(context);
                      // }
                      // else{
                      //   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> watchlist()));
                      // }
                    },
                    child: Container(
                      padding:EdgeInsets.only(top: 12,bottom: 12),
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      child: Center(child: Text("Set",style: Theme.of(context).textTheme.labelMedium?.copyWith(color: Colors.white),)),
                    ),
                  ),
                ),
                SizedBox(width: 16,),
                Flexible(
                  child: InkWell(
                    onTap: (){
                      Navigator.pop(context);
                      Future.delayed(Duration(microseconds: 2), () {
                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>watchlist()), (route) => false);
                      });
                    },
                    child: Container(
                      padding:EdgeInsets.only(top: 12,bottom: 12),
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Theme.of(context).colorScheme.inverseSurface.withAlpha(12),
                      ),
                      child: Center(child: Text("Skip",style: Theme.of(context).textTheme.labelMedium,)),
                    ),
                  ),
                )
              ],
            )
          ],
        )
      ),
    );
  });
}

showRegisterBottomSheet(BuildContext context, {Function? onTap}){
  showModalBottomSheet(context: context,
      backgroundColor: Colors.transparent,
      builder: (context){
        return SafeArea(
          top: false,
          bottom: true,
          child: Container(
              margin: EdgeInsets.symmetric(horizontal: 12,vertical: 8),
              padding: EdgeInsets.symmetric(horizontal: 12,vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Theme.of(context).colorScheme.surface,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("Register",style: Theme.of(context).textTheme.headlineLarge,),
                  SizedBox(height: 16,),
                  Text("Do You want to Register Username",style: Theme.of(context).textTheme.bodyMedium,),
                  SizedBox(height: 27,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        child: InkWell(
                          onTap: (){
                            Navigator.of(context).pop();
                            // showLoginBiometricBottomSheet(context);
                            // }
                            // else{
                            //   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> watchlist()));
                            // }
                            if (onTap != null) {
                              onTap();
                            }
                          },
                          child: Container(
                            padding:EdgeInsets.only(top: 12,bottom: 12),
                            width: double.maxFinite,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            child: Center(child: Text("Yes",style: Theme.of(context).textTheme.labelMedium?.copyWith(color: Colors.white),)),
                          ),
                        ),
                      ),
                      SizedBox(width: 16,),
                      Flexible(
                        child: InkWell(
                          onTap: (){
                            Navigator.pop(context);
                          },
                          child: Container(
                            padding:EdgeInsets.only(top: 12,bottom: 12),
                            width: double.maxFinite,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Theme.of(context).colorScheme.inverseSurface.withAlpha(12),
                            ),
                            child: Center(child: Text("No",style: Theme.of(context).textTheme.labelMedium,)),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              )
          ),
        );
      });
}

showLoginBiometricBottomSheet(BuildContext context,{String title = "Set Biometric"}){
  showModalBottomSheet(context: context,
      backgroundColor: Colors.transparent,
      builder: (context){
        return SafeArea(
          top: false,
          bottom: true,
          child: BlocProvider(
            create:(context) => Biometricbloc(Biometricutility().getLocalAuthinstance()),
            child: BlocBuilder<Biometricbloc,BiometricState>(
              builder: (context,state) {
                final currentstate = state as currentauthState;
                if(currentstate.authState == AuthState.authIdeal){
                  context.read<Biometricbloc>().add(onAuthenticate());
                }
                else if (currentstate.authState == AuthState.authFailed){
                   Future.delayed(Duration(microseconds: 2), () {
                    Navigator.of(context).pop();
                  });
                    }
                else if (currentstate.authState == AuthState.autSucces){
                  Future.delayed(Duration(microseconds: 2), () {
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>watchlist()), (route) => false);
                  });
                }
                else if (currentstate.authState == AuthState.authCancle){
                  Future.delayed(Duration(microseconds: 2), () {
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>watchlist()), (route) => false);
                  });
                }
                return Container(
                    margin: EdgeInsets.symmetric(horizontal: 12,vertical: 8),
                    padding: EdgeInsets.symmetric(horizontal: 12,vertical: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Theme.of(context).colorScheme.surface,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(title,style: Theme.of(context).textTheme.headlineLarge,),
                        SizedBox(height: 16,),
                       if(currentstate.authState == AuthState.authIdeal)
                         Icon(Icons.fingerprint_rounded,size: 100,color: Theme.of(context).colorScheme.inverseSurface.withAlpha(40),),
                       if (currentstate.authState == AuthState.authFailed)
                          Icon(Icons.cancel_outlined,size: 100,color: Colors.red,),
                        if (currentstate.authState == AuthState.autSucces)
                          Icon(Icons.check_circle_outline_rounded,size: 100,color: Colors.green,),
                        SizedBox(height: 16,),
                        Text("Set Biometric For Swift login",style: Theme.of(context).textTheme.bodyMedium,),
                        SizedBox(height: 27,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              padding:EdgeInsets.only(top: 12,bottom: 12,left: 24,right: 24),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Theme.of(context).colorScheme.inverseSurface.withAlpha(12),
                              ),
                              child: Text("Skip",style: Theme.of(context).textTheme.labelMedium,),
                            )
                          ],
                        )
                      ],
                    )
                );
              }
            ),
          ),
        );
      });
}

  ShowSettingbottomsheet(BuildContext mcontext){
  showModalBottomSheet(context: mcontext,
      backgroundColor: Colors.transparent,
      builder: (context){
        return SafeArea(
          top: false,
          bottom: true,
          child: BlocProvider.value(
            value: context.read<Themebloc>(),
            child: BlocBuilder<Themebloc,ThemeState>(
                builder: (context,state) {
                  final states = state as currentThemeState;

                  final sta = (state as currentThemeState).isdark;
                  final currencysta = (state as currentThemeState).currency;
                  final textStye = Theme.of(context).textTheme.bodyLarge;
                  return Container(
                      margin: EdgeInsets.symmetric(horizontal: 12,vertical: 8),
                      padding: EdgeInsets.symmetric(horizontal: 12,vertical: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Theme.of(context).colorScheme.surface,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                         Row(
                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                           children: [
                             Text("Dark Mode",style: Theme.of(context).textTheme.bodyLarge,),
                             Switch(value: sta, onChanged: (val){
                               context.read<Themebloc>().add(onthemeSwitchtoggle(isdark: val));
                             })
                           ],
                         ),
                          SizedBox(height: 12,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Currency Display",style: Theme.of(context).textTheme.bodyLarge,),
                              Row(
                                children: [
                                  InkWell(
                                    onTap: (){
                                      context.read<Themebloc>().add(oncurrencychange(currency: currencystate.INR));
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: currencysta == currencystate.INR ? Theme.of(context).colorScheme.primary : Colors.transparent,
                                      ),
                                      padding: EdgeInsets.only(left: 16,right: 16,top: 8,bottom: 8),
                                        child: Text("INR",style:sta == true ? textStye : Theme.of(context).textTheme.bodyMedium!.copyWith(color:currencysta == currencystate.INR ? Colors.white : Colors.black),)),
                                  ),
                                  SizedBox(width: 16),
                                  InkWell(
                                    onTap: (){
                                      context.read<Themebloc>().add(oncurrencychange(currency: currencystate.USD));
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: currencysta == currencystate.USD ? Theme.of(context).colorScheme.primary : Colors.transparent,
                                      ),
                                        padding: EdgeInsets.only(left: 16,right: 16,top: 8,bottom: 8),
                                        child: Text("USD",style: sta == true ? textStye : Theme.of(context).textTheme.bodyMedium!.copyWith(color:currencysta == currencystate.USD ? Colors.white : Colors.black),),),
                                  ),
                                ],
                              )
                            ],
                          ),
                          SizedBox(height: 12,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Refresh Interverl",style: Theme.of(context).textTheme.bodyLarge,),
                              Row(
                                children: [
                                  InkWell(
                                    onTap: (){
                                      context.read<Themebloc>().add(onrefreshratechange(refreshrate: 5));
                                    },
                                    child: Container(
                                        decoration: BoxDecoration(
                                          color: states.refreshsec == 5 ? Theme.of(context).colorScheme.primary : Colors.transparent,
                                        ),
                                        padding: EdgeInsets.only(left: 16,right: 16,top: 8,bottom: 8),
                                        child: Text("5s",style:sta == true ? textStye : Theme.of(context).textTheme.bodyMedium!.copyWith(color:states.refreshsec == 5 ? Colors.white : Colors.black),)),
                                  ),
                                  SizedBox(width: 16),
                                  InkWell(
                                    onTap: (){
                                      context.read<Themebloc>().add(onrefreshratechange(refreshrate: 10));
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: states.refreshsec == 10 ? Theme.of(context).colorScheme.primary : Colors.transparent,
                                      ),
                                      padding: EdgeInsets.only(left: 16,right: 16,top: 8,bottom: 8),
                                      child: Text("10s",style: sta == true ? textStye : Theme.of(context).textTheme.bodyMedium!.copyWith(color:states.refreshsec == 10 ? Colors.white : Colors.black),),),
                                  ),
                                  SizedBox(width: 16),
                                  InkWell(
                                    onTap: (){
                                      context.read<Themebloc>().add(onrefreshratechange(refreshrate: 30));
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: states.refreshsec == 30 ? Theme.of(context).colorScheme.primary : Colors.transparent,
                                      ),
                                      padding: EdgeInsets.only(left: 16,right: 16,top: 8,bottom: 8),
                                      child: Text("30s",style: sta == true ? textStye : Theme.of(context).textTheme.bodyMedium!.copyWith(color:states.refreshsec == 30 ? Colors.white : Colors.black),),),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ],
                      )
                  );
                }
            ),
          ),
        );
      });
}
 showSortbottomsheet(BuildContext context, WatchlistBloc inheritbloc) {
   // scaffoldkey.currentState?.showBottomSheet((context) {
   //   return SafeArea(
   //     top: false,
   //     bottom: true,
   //     child: BlocProvider.value(
   //       value: context.read<Themebloc>(),
   //       child: BlocBuilder<Themebloc,ThemeState>(
   //           builder: (context,state) {
   //             final states = state as currentThemeState;
   //
   //             final sta = (state as currentThemeState).isdark;
   //             final currencysta = (state as currentThemeState).currency;
   //             final textStye = Theme.of(context).textTheme.bodyLarge;
   //             return Container(
   //                 margin: EdgeInsets.symmetric(horizontal: 12,vertical: 8),
   //                 padding: EdgeInsets.symmetric(horizontal: 12,vertical: 10),
   //                 decoration: BoxDecoration(
   //                   borderRadius: BorderRadius.circular(10),
   //                   color: Theme.of(context).colorScheme.surface,
   //                 ),
   //                 child: Column(
   //                   mainAxisSize: MainAxisSize.min,
   //                   children: [
   //                     // Row(
   //                     //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
   //                     //   children: [
   //                     //     Text("Dark Mode",style: Theme.of(context).textTheme.bodyLarge,),
   //                     //     Switch(value: sta, onChanged: (val){
   //                     //       context.read<Themebloc>().add(onthemeSwitchtoggle(isdark: val));
   //                     //     })
   //                     //   ],
   //                     // ),
   //                     //  SizedBox(height: 12,),
   //                     //  Row(
   //                     //    mainAxisAlignment: MainAxisAlignment.spaceBetween,
   //                     //    children: [
   //                     //      Text("Currency Display",style: Theme.of(context).textTheme.bodyLarge,),
   //                     //      Row(
   //                     //        children: [
   //                     //          InkWell(
   //                     //            onTap: (){
   //                     //              context.read<Themebloc>().add(oncurrencychange(currency: currencystate.INR));
   //                     //            },
   //                     //            child: Container(
   //                     //              decoration: BoxDecoration(
   //                     //                color: currencysta == currencystate.INR ? Theme.of(context).colorScheme.primary : Colors.transparent,
   //                     //              ),
   //                     //              padding: EdgeInsets.only(left: 16,right: 16,top: 8,bottom: 8),
   //                     //                child: Text("INR",style:sta == true ? textStye : Theme.of(context).textTheme.bodyMedium!.copyWith(color:currencysta == currencystate.INR ? Colors.white : Colors.black),)),
   //                     //          ),
   //                     //          SizedBox(width: 16),
   //                     //          InkWell(
   //                     //            onTap: (){
   //                     //              context.read<Themebloc>().add(oncurrencychange(currency: currencystate.USD));
   //                     //            },
   //                     //            child: Container(
   //                     //              decoration: BoxDecoration(
   //                     //                color: currencysta == currencystate.USD ? Theme.of(context).colorScheme.primary : Colors.transparent,
   //                     //              ),
   //                     //                padding: EdgeInsets.only(left: 16,right: 16,top: 8,bottom: 8),
   //                     //                child: Text("USD",style: sta == true ? textStye : Theme.of(context).textTheme.bodyMedium!.copyWith(color:currencysta == currencystate.USD ? Colors.white : Colors.black),),),
   //                     //          ),
   //                     //        ],
   //                     //      )
   //                     //    ],
   //                     //  ),
   //                     //  SizedBox(height: 12,),
   //                     Row(
   //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
   //                       children: [
   //                         Text("Sort",style: Theme.of(context).textTheme.bodyLarge,),
   //                         Row(
   //                           children: [
   //                             InkWell(
   //                               onTap: (){
   //                                 context.read<WatchlistBloc>().add(filtterWatchlistscript(sort: 'Ascending'));
   //                               },
   //                               child: Container(
   //                                   decoration: BoxDecoration(
   //                                     color: states.refreshsec == 5 ? Theme.of(context).colorScheme.primary : Colors.transparent,
   //                                   ),
   //                                   padding: EdgeInsets.only(left: 16,right: 16,top: 8,bottom: 8),
   //                                   child: Text("Ascending",style:sta == true ? textStye : Theme.of(context).textTheme.bodyMedium!.copyWith(color:states.refreshsec == 5 ? Colors.white : Colors.black),)),
   //                             ),
   //                             SizedBox(width: 16),
   //                             InkWell(
   //                               onTap: (){
   //                                 context.read<WatchlistBloc>().add(filtterWatchlistscript(sort: 'Descending'));
   //                               },
   //                               child: Container(
   //                                 decoration: BoxDecoration(
   //                                   color: states.refreshsec == 10 ? Theme.of(context).colorScheme.primary : Colors.transparent,
   //                                 ),
   //                                 padding: EdgeInsets.only(left: 16,right: 16,top: 8,bottom: 8),
   //                                 child: Text("Descending",style: sta == true ? textStye : Theme.of(context).textTheme.bodyMedium!.copyWith(color:states.refreshsec == 10 ? Colors.white : Colors.black),),),
   //                             ),
   //                           ],
   //                         )
   //                       ],
   //                     ),
   //                   ],
   //                 )
   //             );
   //           }
   //       ),
   //     ),
   //   );
   // },
   // );

  showModalBottomSheet(context: context,
      backgroundColor: Colors.transparent,
      useRootNavigator: false,
      builder: (context){
        return SafeArea(
          top: false,
          bottom: true,
          child: BlocProvider.value(
            value: inheritbloc,
            child: BlocBuilder<WatchlistBloc,WatchlistState>(
                builder: (sheetcontext,state) {
                  final themestates = sheetcontext.read<Themebloc>().state as currentThemeState;

                  final sta = themestates.isdark;
                  final currencysta = themestates.currency;
                  final textStye = Theme.of(context).textTheme.bodyLarge;
                  return Container(
                      margin: EdgeInsets.symmetric(horizontal: 12,vertical: 8),
                      padding: EdgeInsets.symmetric(horizontal: 12,vertical: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Theme.of(context).colorScheme.surface,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                         // Row(
                         //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         //   children: [
                         //     Text("Dark Mode",style: Theme.of(context).textTheme.bodyLarge,),
                         //     Switch(value: sta, onChanged: (val){
                         //       context.read<Themebloc>().add(onthemeSwitchtoggle(isdark: val));
                         //     })
                         //   ],
                         // ),
                         //  SizedBox(height: 12,),
                         //  Row(
                         //    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         //    children: [
                         //      Text("Currency Display",style: Theme.of(context).textTheme.bodyLarge,),
                         //      Row(
                         //        children: [
                         //          InkWell(
                         //            onTap: (){
                         //              context.read<Themebloc>().add(oncurrencychange(currency: currencystate.INR));
                         //            },
                         //            child: Container(
                         //              decoration: BoxDecoration(
                         //                color: currencysta == currencystate.INR ? Theme.of(context).colorScheme.primary : Colors.transparent,
                         //              ),
                         //              padding: EdgeInsets.only(left: 16,right: 16,top: 8,bottom: 8),
                         //                child: Text("INR",style:sta == true ? textStye : Theme.of(context).textTheme.bodyMedium!.copyWith(color:currencysta == currencystate.INR ? Colors.white : Colors.black),)),
                         //          ),
                         //          SizedBox(width: 16),
                         //          InkWell(
                         //            onTap: (){
                         //              context.read<Themebloc>().add(oncurrencychange(currency: currencystate.USD));
                         //            },
                         //            child: Container(
                         //              decoration: BoxDecoration(
                         //                color: currencysta == currencystate.USD ? Theme.of(context).colorScheme.primary : Colors.transparent,
                         //              ),
                         //                padding: EdgeInsets.only(left: 16,right: 16,top: 8,bottom: 8),
                         //                child: Text("USD",style: sta == true ? textStye : Theme.of(context).textTheme.bodyMedium!.copyWith(color:currencysta == currencystate.USD ? Colors.white : Colors.black),),),
                         //          ),
                         //        ],
                         //      )
                         //    ],
                         //  ),
                         //  SizedBox(height: 12,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Sort",style: Theme.of(context).textTheme.bodyLarge,),
                              Row(
                                children: [
                                  InkWell(
                                    onTap: (){
                                      sheetcontext.read<WatchlistBloc>().add(filtterWatchlistscript(sort: 'Ascending'));
                                    },
                                    child: Container(
                                        decoration: BoxDecoration(
                                          color: state.sort == 'Ascending' ? Theme.of(context).colorScheme.primary : Colors.transparent,
                                        ),
                                        padding: EdgeInsets.only(left: 16,right: 16,top: 8,bottom: 8),
                                        child: Text("Ascending",style:sta == true ? textStye : Theme.of(context).textTheme.bodyMedium!.copyWith(color:state.sort == 'Ascending' ? Colors.white : Colors.black),)),
                                  ),
                                  SizedBox(width: 16),
                                  InkWell(
                                    onTap: (){
                                      sheetcontext.read<WatchlistBloc>().add(filtterWatchlistscript(sort: 'Descending'));
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: state.sort == 'Descending' ? Theme.of(context).colorScheme.primary : Colors.transparent,
                                      ),
                                      padding: EdgeInsets.only(left: 16,right: 16,top: 8,bottom: 8),
                                      child: Text("Descending",style: sta == true ? textStye : Theme.of(context).textTheme.bodyMedium!.copyWith(color:state.sort == 'Descending' ? Colors.white : Colors.black),),),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ],
                      )
                  );
                }
            ),
          ),
        );
      });
}