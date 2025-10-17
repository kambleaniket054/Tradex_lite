import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part "script.g.dart";

@HiveType(typeId: 0)
class Script extends HiveObject with EquatableMixin {
  @HiveField(0)
  final String symbol;

  @HiveField(1)
  final String exchange;

  @HiveField(2)
  final String company;

  @HiveField(3)
  final double ltp;

  @HiveField(4)
  final double change;

  @HiveField(5)
  final double close;

   Script({
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
