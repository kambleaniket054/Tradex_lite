import 'package:equatable/equatable.dart';

abstract class WatchlistEvent extends Equatable {
  const WatchlistEvent();

  @override
  List<Object?> get props => [];
}

class LoadWatchlist extends WatchlistEvent {
  final int tabIndex;
  const LoadWatchlist(this.tabIndex);

  @override
  List<Object?> get props => [tabIndex];
}
 class FilterWatchlist extends WatchlistEvent{
  final String query;
  const FilterWatchlist(this.query);
 }

class UpdateLtp extends WatchlistEvent {
  final String symbol;
  final double ltp;
  final double change;
  final double close;
  const UpdateLtp(this.symbol, this.ltp,this.change,this.close);

  @override
  List<Object?> get props => [symbol, ltp, change,close];
}
