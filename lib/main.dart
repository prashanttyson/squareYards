
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:prashantmishrasquareyards/Utils/AppRoute.dart';
import 'package:prashantmishrasquareyards/Utils/Constants.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(new MyApp());
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData( fontFamily: 'CooperHewitt'
        //fontFamily: DefaultTextStyle.of(context).style.fontFamily
      ),
      darkTheme: ThemeData(

          textTheme: Theme.of(context)
              .textTheme
              .apply( fontFamily: 'CooperHewitt'
            //fontFamily: DefaultTextStyle.of(context).style.fontFamily,
          )),
      initialRoute: '/',
      routes: getAppRoute(),
      navigatorKey: Constants.navigatorKey,
    );
  }
}
