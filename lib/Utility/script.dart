import 'package:equatable/equatable.dart';

class Script extends Equatable {
  final String symbol;
  final String exchange;
  final String company;
  final double ltp;
  final double change;
  final double close;

  const Script({
    required this.symbol,
    required this.exchange,
    required this.company,
    required this.ltp,
    required this.change,
    required this.close,
  });

  Script copyWith({double? ltp,double? change,double? close}) {
    return Script(
      symbol: symbol,
      exchange: exchange,
      company: company,
      ltp: ltp ?? this.ltp,
      change: change ?? this.change,
      close: close ?? this.close,
    );
  }

  @override
  List<Object?> get props => [symbol, exchange, company, ltp, change, close];
}
