// lib/views/logout_view.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/auth_view_model.dart';
import 'login_view.dart';

class LogoutView extends StatelessWidget {
  const LogoutView({super.key});

  void _logout(BuildContext context) async {
    final viewModel = Provider.of<AuthViewModel>(context, listen: false);
    await viewModel.logout();

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const LoginView()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Welcome')),
      body: Center(
        child: ElevatedButton(
          onPressed: () => _logout(context),
          child: const Text('Logout'),
        ),
      ),
    );
  }
}
