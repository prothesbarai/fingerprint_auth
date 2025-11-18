import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'fingerprint_and_pin_auth/fingerprint_and_pin_auth.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  // Edge-to-Edge UI + Portrait Mode parallelly
  await Future.wait([
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge),
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown,]),
  ]);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Colors.transparent, systemNavigationBarColor: Colors.transparent, systemNavigationBarDividerColor: Colors.transparent, statusBarIconBrightness: Brightness.light, systemNavigationBarIconBrightness: Brightness.light,),);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: false,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: FingerprintAndPinAuth(),
    );
  }
}
