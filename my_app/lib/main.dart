import 'package:flutter/material.dart';
import 'pages/login.dart';
import 'pages/dashboard.dart';
import 'pages/order_screen.dart';
import 'pages/Reports.dart';
import 'pages/Test.dart';

void main() {
  runApp(const TrixTechApp());
}

class TrixTechApp extends StatelessWidget {
  const TrixTechApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TrixTech',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginPage(),
        '/Dashboard': (context) => const DashboardPage(),
        '/Orders': (context) => const OrderScreen(), // ✅ properly inside MaterialApp
        '/Reports': (context) => const Reports(),
        '/Test': (context) => const Test(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
