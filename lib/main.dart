import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:savings_app/view/auth/login_page.dart';
import 'package:savings_app/view/auth/register_page.dart';
import 'package:savings_app/view/home/dashboard.dart';
import 'package:savings_app/viewmodel/auth/login_viewmodel.dart';
import 'package:savings_app/viewmodel/auth/register_viewmodel.dart';

void main() async {
  await dotenv.load();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => RegisterViewModel(),),
        ChangeNotifierProvider(create: (_) => LoginViewModel())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Login UI',
        theme: ThemeData(useMaterial3: true, colorSchemeSeed: Color.fromRGBO(218, 119, 86, 1)),
        home: const LoginPage(),
        initialRoute: '/login',
        routes: {
          '/register': (context) => RegisterPage(),
          '/login': (context) => LoginPage(),
          '/home': (context) => DashboardPage()
        },
      ),
    );
  }
}