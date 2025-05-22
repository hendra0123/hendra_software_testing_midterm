import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/auth_service.dart';
import 'viewmodels/auth_view_model.dart';
import 'views/login_view.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => AuthViewModel(AuthService()),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login App',
      home: const LoginView(),
    );
  }
}
