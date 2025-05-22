import 'package:flutter_test/flutter_test.dart';
import 'package:hendra_software_testing_midterm/models/auth_service.dart';
import 'package:hendra_software_testing_midterm/viewmodels/auth_view_model.dart';

class MockAuthService implements AuthService {
  Function(String, String)? _loginHandler;
  Function()? _logoutHandler;

  @override
  Future<Map<String, dynamic>> login(String username, String password) {
    if (_loginHandler != null) {
      return _loginHandler!(username, password);
    }
    throw UnimplementedError('login not stubbed');
  }

  void stubLogin(
      Future<Map<String, dynamic>> Function(String, String) handler) {
    _loginHandler = handler;
  }

  bool logoutCalled = false;

  @override
  Future<void> logout() async {
    logoutCalled = true;
    if (_logoutHandler != null) {
      return _logoutHandler!();
    }
  }

  void stubLogout(Future<void> Function() handler) {
    _logoutHandler = handler;
  }
}

void main() {
  late AuthViewModel authViewModel;
  late MockAuthService mockAuthService;

  setUp(() {
    mockAuthService = MockAuthService();
    authViewModel = AuthViewModel(mockAuthService);
  });

  group('AuthViewModel Tests', () {
    test('TC_AUTH_VM_001: Validate Empty Username', () {
      final result = authViewModel.validateUsername('');
      expect(result, 'Username cannot be empty.');
    });

    test('TC_AUTH_VM_002: Validate Short Password', () {
      final result = authViewModel.validatePassword('123');
      expect(result, 'Password must be at least 6 characters long.');
    });

    test('TC_AUTH_VM_003: Successful Login', () async {
      mockAuthService.stubLogin((username, password) async => {
            'username': 'testuser',
            'token': 'abc123',
          });

      final result = await authViewModel.login('testuser', 'password123');
      expect(result, null);
      expect(authViewModel.user?.username, 'testuser');
    });

    test('TC_AUTH_VM_004: Login with Invalid Credentials', () async {
      mockAuthService.stubLogin((username, password) async {
        throw Exception('Invalid username or password.');
      });

      final result = await authViewModel.login('invaliduser', 'wrongpassword');
      expect(result, contains('Invalid username or password.'));
    });

    test('TC_AUTH_VM_005: Logout Functionality', () async {
      mockAuthService.stubLogin((username, password) async => {
            'username': 'loggedUser',
            'token': 'xyz456',
          });
      await authViewModel.login('loggedUser', 'password123');

      expect(authViewModel.user?.username, 'loggedUser');
      expect(authViewModel.isLoggedIn, true);

      mockAuthService.stubLogout(() async => null);
      await authViewModel.logout();

      expect(mockAuthService.logoutCalled, true);
      expect(authViewModel.user, null);
      expect(authViewModel.isLoggedIn, false);
    });

    test('TC_AUTH_VM_006: Username Length Boundary Values', () {
      final shortUsername = 'ab';
      final longUsername = 'a' * 21;
      final validUsername = 'validUser';

      expect(authViewModel.validateUsername(shortUsername),
          'Username must be between 3 and 20 characters.');
      expect(authViewModel.validateUsername(longUsername),
          'Username must be between 3 and 20 characters.');
      expect(authViewModel.validateUsername(validUsername), null);
    });

    test('TC_AUTH_VM_007: Password Length Boundary Values', () {
      final shortPassword = '12345';
      final validPassword = '123456';

      expect(authViewModel.validatePassword(shortPassword),
          'Password must be at least 6 characters long.');
      expect(authViewModel.validatePassword(validPassword), null);
    });

    test('TC_AUTH_VM_008: Login with Special Characters in Username', () {
      final result = authViewModel.validateUsername('user@name');
      expect(result, 'Username contains invalid characters.');
    });

    test('TC_AUTH_VM_009: Login with SQL Injection Attempt', () async {
      mockAuthService.stubLogin((username, password) async {
        throw Exception('Invalid username or password.');
      });

      final result =
          await authViewModel.login("'; DROP TABLE users; --", 'password123');
      expect(result, contains('Invalid username or password.'));
    });

    test('TC_AUTH_VM_010: Login with Empty Fields', () {
      final usernameResult = authViewModel.validateUsername('');
      final passwordResult = authViewModel.validatePassword('');

      expect(usernameResult, 'Username cannot be empty.');
      expect(passwordResult, 'Password cannot be empty.');
    });
  });
}
