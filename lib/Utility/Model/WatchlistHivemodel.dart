import 'package:hive/hive.dart';

import '../script.dart';
part 'WatchlistHivemodel.g.dart';
@HiveType(typeId: 2)
class WatchlistHiveModel extends HiveObject {
  @HiveField(0)
  final Map<String, List<Script>> watchlists;

  WatchlistHiveModel(this.watchlists);
}