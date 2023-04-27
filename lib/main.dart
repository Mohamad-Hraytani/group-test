
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'AuthScreen.dart';


import 'package:provider/provider.dart';

import 'ProviderAuth.dart';
import 'ProvidernNum.dart';

import 'groupApp.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences pr1 = await SharedPreferences.getInstance();

  var se = pr1.getBool('se');
  Widget scre;
  if (se == null || se == false) {
    scre = MyApp();
  } else {
    scre = MyApp();
  }

  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      debugShowMaterialGrid: false,
      home: scre));
}



class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: product()),
        ChangeNotifierProvider.value(value: ProviderAuth()),
        ChangeNotifierProxyProvider<ProviderAuth, ProviderNum>(
            create: (_) => ProviderNum(),
            update: (context, value, pp) => pp
              ..getdata(value.t, value.usId)),
      ],
      child: Consumer<ProviderAuth>(
        builder: (ctx, value, child) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          debugShowMaterialGrid: false,
          home: value.Auth
              ? groupApp()
              : FutureBuilder(
                  future: value.tryautlogin(),
                  builder: (ctx, snapshot) {
                    return snapshot.connectionState == ConnectionState.waiting
                        ? SplashScreen()
                        : AuthScreen();
                  }),
        ),
      ),
    );
  
  }
}

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(child: CircularProgressIndicator());
  }
}