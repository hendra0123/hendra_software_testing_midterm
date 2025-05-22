// lib/views/login_view.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/auth_view_model.dart';
import 'logout_view.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  String? _errorMessage;
  bool _isLoading = false;

  void _login() async {
    final viewModel = Provider.of<AuthViewModel>(context, listen: false);
    final username = _usernameController.text;
    final password = _passwordController.text;

    setState(() {
      _errorMessage = null;
      _isLoading = true;
    });

    final usernameError = viewModel.validateUsername(username);
    final passwordError = viewModel.validatePassword(password);

    if (usernameError != null || passwordError != null) {
      setState(() {
        _errorMessage = usernameError ?? passwordError;
        _isLoading = false;
      });
      return;
    }

    final result = await viewModel.login(username, password);
    setState(() {
      _errorMessage = result;
      _isLoading = false;
    });

    if (result == null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LogoutView()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(labelText: 'Username'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Password'),
            ),
            const SizedBox(height: 24),
            if (_errorMessage != null)
              Text(
                _errorMessage ?? '',
                style: const TextStyle(color: Colors.red),
              ),
            if (_isLoading)
              const CircularProgressIndicator()
            else
              ElevatedButton(
                onPressed: _login,
                child: const Text('Login'),
              ),
          ],
        ),
      ),
    );
  }
}
