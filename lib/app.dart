import 'package:flutter/material.dart';
import 'config/theme.dart';
import 'routes/app_routes.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IA Développement Durable',
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      initialRoute: AppRoutes.intro,
      routes: AppRoutes.routes,
    );
  }
}
