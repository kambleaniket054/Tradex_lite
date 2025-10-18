import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part "script.g.dart";

@HiveType(typeId: 1)
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

  @HiveField(6)
  final double high;

  @HiveField(7)
  final double low;

  @HiveField(8)
  final double open;

  @HiveField(9)
   List<double> prevltp = [];

   Script({
    required this.symbol,
    required this.exchange,
    required this.company,
    required this.ltp,
    required this.change,
    required this.close,
    required this.open,
    required this.high,
    required this.low,
    required this.prevltp,
  });

  Script copyWith({double? ltp,double? change,double? close,List<double>? prevltp}) {
    return Script(
      symbol: symbol,
      exchange: exchange,
      company: company,
      ltp: ltp ?? this.ltp,
      change: change ?? this.change,
      close:  close ?? this.close,
      open:  open,
      high:  high,
      low: low,
      prevltp: prevltp ?? this.prevltp,
    );
  }

  @override
  List<Object?> get props => [symbol, exchange, company, ltp, change, close,prevltp];
}
