import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:savings_app/utils/TokenStorage.dart';
import 'package:savings_app/view/auth/login_page.dart';
import 'package:savings_app/view/auth/register_page.dart';
import 'package:savings_app/view/auth/verify_page.dart';
import 'package:savings_app/view/goals/add_goal.dart';
import 'package:savings_app/view/goals/goals.dart';
import 'package:savings_app/view/home/dashboard.dart';
import 'package:savings_app/view/settings/settings.dart';
import 'package:savings_app/viewmodel/auth/login_viewmodel.dart';
import 'package:savings_app/viewmodel/auth/register_viewmodel.dart';
import 'package:savings_app/viewmodel/auth/verification_viewmodel.dart';

void main() async {
  await dotenv.load();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final tokenStorage = TokenStorage();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => RegisterViewModel(),),
        ChangeNotifierProvider(create: (_) => LoginViewModel()),
        ChangeNotifierProvider(create: (_) => VerificationViewModel())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Login UI',
        theme: ThemeData(useMaterial3: true, colorSchemeSeed: Color.fromRGBO(218, 119, 86, 1)),
        home: FutureBuilder(future: tokenStorage.isLoggedIn(), builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(),);
          }

          return snapshot.data == true ? const DashboardPage() : const LoginPage();
        }),
        routes: {
          '/register': (context) => RegisterPage(),
          '/login': (context) => LoginPage(),
          '/settings': (context) => SettingsPage(),
          '/home': (context) => DashboardPage(),
          '/verify': (context) => VerificationPage(email: ""),
          '/goals': (context) => GoalsPage(),
          '/goals/add': (context) => AddGoalPage()
        },
      ),
    );
  }
}