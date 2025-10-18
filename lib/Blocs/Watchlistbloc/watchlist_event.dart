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
 class SearchWatchlistscrip extends WatchlistEvent{
  final String query;
  const SearchWatchlistscrip(this.query);
 }

 class filtterWatchlistscript extends WatchlistEvent{
  final String sort;
  const filtterWatchlistscript({this.sort = ''});
 }

class UpdateLtp extends WatchlistEvent {
  final String symbol;
  final double ltp;
  final double change;
  final List? prevlist;
  const UpdateLtp(this.symbol, this.ltp,this.change,this.prevlist);

  @override
  List<Object?> get props => [symbol, ltp, change,prevlist];
}
