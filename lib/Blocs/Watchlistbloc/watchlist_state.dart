import 'package:equatable/equatable.dart';
import '../../Utility/Model/script.dart';


class WatchlistState extends Equatable {
  final int selectedTab;
  final List<String> watchlists;
  final String searchquary;
  final String sort;
  final Map<String, List<Script>> scripts;

  const WatchlistState({
    this.selectedTab = 0,
    this.watchlists = const ["Tech", "Banking", "Energy"],
    this.searchquary = '',
    this.sort = '',
    this.scripts = const {},
  });

  WatchlistState copyWith({
    String? searchquary,
    String? sort,
    int? selectedTab,
    Map<String, List<Script>>? scripts,
  }) {
    return WatchlistState(
      selectedTab: selectedTab ?? this.selectedTab,
      watchlists: watchlists,
      searchquary: searchquary ?? this.searchquary,
      sort: sort ?? this.sort,
      scripts: scripts ?? this.scripts,
    );
  }

  @override
  List<Object?> get props => [selectedTab, watchlists, scripts,searchquary,sort];
}
