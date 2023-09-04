import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mobileapp/provider/address_provider.dart';
import 'package:mobileapp/provider/auth_provider.dart';
import 'package:mobileapp/provider/book_provider.dart';
import 'package:mobileapp/provider/order_provider.dart';
import 'package:mobileapp/view/auth/FormLogin.dart';

import 'package:mobileapp/view/components/bottombar.dart';
import 'package:mobileapp/view/home/splash_screen.dart';

import 'package:provider/provider.dart';

Future<void> main() async {
  // WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  WidgetsFlutterBinding();
  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Hive.initFlutter();

  // await Hive.deleteBoxFromDisk('shopping_box');
  await Hive.openBox('user');
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => BookProvider()),
        ChangeNotifierProvider(create: (_) => AddressProvider()),
        ChangeNotifierProvider(create: (_) => OrderProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
