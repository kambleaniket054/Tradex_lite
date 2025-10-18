import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tradex_lite/Blocs/themeEvent.dart';

import '../Utility/varUtility.dart';
import 'ThemeState.dart';

class Themebloc extends Bloc<ThemeEvent,ThemeState> {
  bool isdark;
  currencystate currency;
  int refreshrate;
  Themebloc({this.isdark = false,this.currency = currencystate.INR,this.refreshrate = 5}) : super(currentThemeState(isdark: isdark,currency: currency,refreshsec: refreshrate)) {
    on<onthemeSwitchtoggle>(onsetnewthemestate);
    on<oncurrencychange>(onsetnewcurrencystate);
    on<onrefreshratechange>(onsetnewrefreshstate);
  }

  FutureOr<void> onsetnewthemestate(onthemeSwitchtoggle event, Emitter<ThemeState> emit) {
    final current = state as currentThemeState;
    preferdTheme.put('isdark',event.isdark);
    Fluttertoast.showToast(msg: "Theme Mode Changed Saved");
    emit(current.copyWith(isdark: event.isdark));
  }

  FutureOr<void> onsetnewcurrencystate(oncurrencychange event, Emitter<ThemeState> emit) {
    final current = state as currentThemeState;
    preferdTheme.put('currency',event.currency);
    Fluttertoast.showToast(msg: "Currency Changed Saved");
    emit(current.copyWith(currency: event.currency));
  }

  FutureOr<void> onsetnewrefreshstate(onrefreshratechange event, Emitter<ThemeState> emit) {
    final current = state as currentThemeState;
    preferdTheme.put('refreshrate',event.refreshrate);
    Fluttertoast.showToast(msg: "Refresh Interval Changed Saved");
    emit(current.copyWith(refreshsec: event.refreshrate));
  }
}