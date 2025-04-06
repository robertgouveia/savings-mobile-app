import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:savings_app/view/auth/login_page.dart';
import 'package:savings_app/viewmodel/auth/login_viewmodel.dart';
import 'package:savings_app/viewmodel/auth/register_viewmodel.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginViewModel()),
        ChangeNotifierProvider(create: (_) => RegisterViewModel())
      ],
      child: const MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Login UI',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Color.fromRGBO(218, 119, 86, 100)),
      home: const LoginPage(),
    );
  }
}