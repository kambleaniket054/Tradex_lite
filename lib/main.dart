import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tradex_lite/Blocs/ThemeBloc.dart';
import 'package:tradex_lite/Blocs/ThemeState.dart';
import 'package:tradex_lite/Utility/apptheme.dart';
import 'package:tradex_lite/Utility/varUtility.dart';
import 'package:tradex_lite/View/watchlist.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Blocs/themeEvent.dart';
import 'Utility/Services/Notificationservices.dart';
import 'Utility/Sharedutility.dart';
import 'View/Login.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await initSharepref();
  await initHive();
  await NotificationService().init();


  runApp( MyApp());
}

class MyApp extends StatelessWidget {
   MyApp({super.key});
  bool isdark = false;
  currencystate currency = currencystate.INR;
  int refreshrate = 5;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    if(preferdTheme.get('isdark') != null){
      isdark = preferdTheme.get('isdark');
    }
    if(preferdTheme.get('currency') != null){
      currency = preferdTheme.get('currency');
    }
    if(preferdTheme.get('refreshrate') != null){
      refreshrate = preferdTheme.get('refreshrate');
    }
    return BlocProvider<Themebloc>(
      child:  BlocBuilder<Themebloc,ThemeState>(
        builder: (context,state) {
          final isdark = state as currentThemeState;
          return MaterialApp(
              title: 'Flutter Demo',
              theme: AppTheme.getTheme(isdark.isdark),
              home: login(),
            );
        }
      ),
      create: (BuildContext context) => Themebloc(isdark: isdark,currency: currency,refreshrate: refreshrate),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  //
  // void _incrementCounter() {
  //   setState(() {
  //     // This call to setState tells the Flutter framework that something has
  //     // changed in this State, which causes it to rerun the build method below
  //     // so that the display can reflect the updated values. If we changed
  //     // _counter without calling setState(), then the build method would not be
  //     // called again, and so nothing would appear to happen.
  //     _counter++;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('You have pushed the button this many times:'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>watchlist()));
                },
                child: Text("Redirect")),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
         final state = context.read<Themebloc>().state as currentThemeState;
          context.read<Themebloc>().add(onthemeSwitchtoggle(isdark:!state.isdark));
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
