import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tradex_lite/Blocs/themeEvent.dart';

import 'ThemeState.dart';

class Themebloc extends Bloc<ThemeEvent,ThemeState> {
  Themebloc() : super(currentThemeState(isdark: false)) {
    on<onthemeSwitchtoggle>(onsetnewthemestate);
    on<oncurrencychange>(onsetnewcurrencystate);
  }

  FutureOr<void> onsetnewthemestate(onthemeSwitchtoggle event, Emitter<ThemeState> emit) {
    final current = state as currentThemeState;
  emit(current.copyWith(isdark: event.isdark));
  }

  FutureOr<void> onsetnewcurrencystate(oncurrencychange event, Emitter<ThemeState> emit) {
    final current = state as currentThemeState;
    emit(current.copyWith(currency: event.currency));
  }
}