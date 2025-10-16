import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tradex_lite/Blocs/Watchlistbloc/watchlist_event.dart';
import 'package:tradex_lite/Blocs/Watchlistbloc/watchlist_state.dart';


import '../../Utility/script.dart';
import '../../Utility/websocket.dart';



class WatchlistBloc extends Bloc<WatchlistEvent, WatchlistState> {
  Timer? _timer;
  final WebSocketService _webSocketService;
  StreamSubscription? _socketSubscription;

  WatchlistBloc(this._webSocketService) : super(const WatchlistState()) {
    // Initialize with some fake scripts
    final Map<String, List<Script>> initialScripts = {
      "Tech": [
        const Script(symbol: "INFY", exchange: "NSE", company: "Infosys", ltp: 1550.0,change: 0.0,close: 0.0),
        const Script(symbol: "TCS", exchange: "BSE", company: "Tata Consultancy", ltp: 3800.0,change: 0.0,close: 0.0),
      ],
      "Banking": [
        const Script(symbol: "HDFCBANK", exchange: "NSE", company: "HDFC Bank", ltp: 1520.0,change: 0.0,close: 0.0),
        const Script(symbol: "ICICIBANK", exchange: "BSE", company: "ICICI Bank", ltp: 980.0,change: 0.0,close: 0.0),
      ],
      "Energy": [
        const Script(symbol: "RELIANCE", exchange: "NSE", company: "Reliance Industries", ltp: 2460.0,change: 0.0,close: 0.0),
      ],
    };

    on<LoadWatchlist>(_onLoadWatchlist);
    on<FilterWatchlist>(_onFilterWatchlist);
    on<UpdateLtp>(_onUpdateLtp);

    emit(state.copyWith(scripts: initialScripts));

    _timer = Timer.periodic(const Duration(seconds: 2), (_) {
      final random = Random();
      for (var wl in state.scripts.keys) {
        for (var s in state.scripts[wl]!) {
          final newLtp = s.ltp + (random.nextBool() ? 5 : -5);
          final change = (newLtp - s.ltp)/100;
          final close = s.ltp;
          final fakeUpdate = {
            "symbol":s.symbol,
            "ltp": newLtp,
            "change":change,
            "close":close
          };
          _webSocketService.sendMessage(jsonEncode(fakeUpdate));

        }
      }
    });

    _socketSubscription = _webSocketService.stream.listen((data) {
      final symbol = data["symbol"];
      final ltp = (data["ltp"] as num).toDouble();
      final change = data["change"] != null ? (data["change"] as num).toDouble() : 0.0;
      final close =data["close"] != null ? (data["close"] as num).toDouble() : 0.0;
      add(UpdateLtp(symbol, ltp, change,close));
    });
  }

  void _onLoadWatchlist(LoadWatchlist event, Emitter<WatchlistState> emit) {
    emit(state.copyWith(selectedTab: event.tabIndex));
  }

  void _onUpdateLtp(UpdateLtp event, Emitter<WatchlistState> emit) {
    final updatedScripts = Map<String, List<Script>>.from(state.scripts);

    updatedScripts.forEach((wl, list) {
      updatedScripts[wl] = list.map((script) {
        if (script.symbol == event.symbol) {
          return script.copyWith(ltp: event.ltp,change: event.change,close: event.close);
        }
        return script;
      }).toList();
    });

    emit(state.copyWith(scripts: updatedScripts));
  }

  @override
  Future<void> close() {
    _socketSubscription?.cancel();
    _webSocketService.dispose();
    _timer?.cancel();
    return super.close();
  }

  FutureOr<void> _onFilterWatchlist(FilterWatchlist event, Emitter<WatchlistState> emit) {
    emit(state.copyWith(searchquary: event.query));
  }
}
