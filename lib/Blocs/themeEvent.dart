import 'package:tradex_lite/Blocs/ThemeState.dart';

abstract class ThemeEvent{}

class onthemeSwitchtoggle extends ThemeEvent{
  final isdark;
  onthemeSwitchtoggle({this.isdark = false});
}

class oncurrencychange extends ThemeEvent{
  final currency;
  oncurrencychange({this.currency = currencystate.INR});
}