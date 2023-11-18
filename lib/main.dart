import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sistem_pelaporan/screens/autentikasi/splash/splash_screen.dart';
import 'package:sistem_pelaporan/values/global_utils.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Sistem Pelaporan',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
          useMaterial3: true,
        ),
        home: const SplashScreen(),
        scaffoldMessengerKey: GlobalContext.messengerKey,
        navigatorKey: GlobalContext.navigatorKey);
  }
}
