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
  const currentThemeState({this.isdark = false,this.currency = currencystate.INR});

  currentThemeState copyWith({
    bool? isdark,
    currencystate? currency,
  }) {
    return currentThemeState(
      isdark: isdark ?? this.isdark,
        currency: currency ?? this.currency,
    );
  }
  @override
  List<Object?> get props => [isdark,currency];
}