import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tradex_lite/Blocs/ThemeBloc.dart';
import 'package:tradex_lite/Blocs/ThemeState.dart';
import 'package:tradex_lite/Blocs/themeEvent.dart';
import 'package:tradex_lite/Utility/Dialogutility.dart';

import '../Blocs/Watchlistbloc/watchlist_event.dart';
import '../Blocs/Watchlistbloc/watchlist_state.dart';
import '../Blocs/Watchlistbloc/watchlistbloc.dart';
import '../Utility/Model/script.dart';
import '../Utility/websocket.dart';

class watchlist extends StatefulWidget{
  createState() => watchlistState();
}

class watchlistState extends State<watchlist>{
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocProvider<WatchlistBloc>(
      create: (context) => WatchlistBloc(WebSocketService()),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text("Watchlist"),
          actions: [
            IconButton(onPressed: (){
              ShowSettingbottomsheet(context);
              // final state = context.read<Themebloc>().state as currentThemeState;
              // context.read<Themebloc>().add(onthemeSwitchtoggle(isdark: !state.isdark));
            }, icon: Icon(Icons.brightness_4_outlined,color: Theme.of(context).iconTheme.color,))
          ],
        ),
        body: BlocBuilder<WatchlistBloc, WatchlistState>(
          //bloc: WatchlistBloc(WebSocketService()),
          builder: (context, state) {
           var currenytype = '₹';
            currencystate currency = (context.read<Themebloc>().state as currentThemeState).currency != null ? (context.read<Themebloc>().state as currentThemeState).currency : currencystate.INR;
            if(currency == currencystate.INR){
              currenytype = '₹';
            }
            else{
              currenytype = r'$';
            }
            List<Script> finalliststate= [];
            final currentWatchlist = state.watchlists[state.selectedTab];
            final currentScripts = state.scripts[currentWatchlist] ?? [];
            if(state.searchquary !='' ){
               currentScripts.forEach((e){
                 if(e.symbol.toLowerCase().contains(state.searchquary.toLowerCase())){
                   finalliststate.add(e);
                 }
               });
            }
            else{
              finalliststate = currentScripts;
            }

            return Column(
              children: [
                // Horizontal Tabs
                SizedBox(
                  height: 50,
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    scrollDirection: Axis.horizontal,
                    itemCount: state.watchlists.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 10),
                    itemBuilder: (context, index) {
                      final isSelected = state.selectedTab == index;
                      return ChoiceChip(
                        label: Text(state.watchlists[index]),
                        selected: isSelected,
                        onSelected: (_) {
                          context.read<WatchlistBloc>().add(LoadWatchlist(index));
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                  child: Row(
                    children: [
                      Flexible(
                        child: Container(
                          child: TextFormField(
                            decoration: InputDecoration(
                              hintText: "Search",
                              prefixIcon: Icon(Icons.search),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(18)
                              ),
                            ),
                            onChanged: (val){
                              context.read<WatchlistBloc>().add(FilterWatchlist(val));
                            },
                          ),
                        ),
                      ),
                      IconButton(onPressed: (){}, icon: Icon(Icons.filter_alt_rounded,size: 24,))
                    ],
                  ),
                ),
                // Script list
                Expanded(
                  child: ListView.builder(
                    itemCount: finalliststate.length,
                    itemBuilder: (context, index) {
                      final Script script = finalliststate[index];
                      return InkWell(
                        onTap: (){
                         showCustomInfoBottomSheet(context,script,index);
                        },
                        child: Card(
                          color: Theme.of(context).cardColor,
                          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ListTile(
                            title: Text("${script.symbol} (${script.exchange})"),
                            subtitle: Text(script.company),
                            trailing: Text(
                              "${currenytype} ${script.ltp.toStringAsFixed(2)}",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: script.ltp > script.close ? Colors.green : Colors.red,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    // WebSocketService().dispose();
    super.dispose();
  }
}