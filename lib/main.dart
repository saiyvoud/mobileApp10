import 'package:flutter/material.dart';
import 'package:mobileapp/provider/auth_provider.dart';
import 'package:mobileapp/view/auth/FormLogin.dart';
import 'package:mobileapp/view/components/imagePicker.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  // WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
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
      home: FormLogin(),
    );
  }
}
