import 'package:equatable/equatable.dart';
enum currencystate{
  INR,
  USD,
  EUR,
  GBP,
}

abstract class ThemeState extends Equatable{
  const ThemeState();

  @override
  List<Object?> get props => [];
}

class currentThemeState extends ThemeState{
 final bool isdark;
 final currencystate currency;
 final int refreshsec;
  const currentThemeState({this.isdark = false,this.currency = currencystate.INR,this.refreshsec = 5});

  currentThemeState copyWith({
    bool? isdark,
    currencystate? currency,
    int? refreshsec,
  }) {
    return currentThemeState(
      isdark: isdark ?? this.isdark,
        currency: currency ?? this.currency,
      refreshsec: refreshsec ?? this.refreshsec,
    );
  }
  @override
  List<Object?> get props => [isdark,currency,refreshsec];
}