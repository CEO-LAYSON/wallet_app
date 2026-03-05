import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../config/app_config.dart';
import '../models/user_model.dart';
import '../services/api_service.dart';

/// Authentication state provider
class AuthProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();

  User? _currentUser;
  bool _isLoading = false;
  String? _error;
  bool _isInitialized = false;

  User? get currentUser => _currentUser;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get isLoggedIn => _currentUser != null;
  bool get isAdmin => _currentUser?.isAdmin ?? false;
  bool get isInitialized => _isInitialized;
  String get token => _apiService.getToken() ?? '';

  /// Initialize auth state from storage
  Future<void> initialize() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(AppConfig.tokenKey);
    final role = prefs.getString(AppConfig.userRoleKey);
    final email = prefs.getString(AppConfig.userEmailKey);

    if (token != null && role != null && email != null) {
      _apiService.setToken(token);
      _currentUser = User(
        email: email,
        fullName: '',
        role: role,
      );
    }
    _isInitialized = true;
    notifyListeners();
  }

  /// Login user
  Future<bool> login(String email, String password) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final response = await _apiService.login(email, password);
      _currentUser = response.toUser();

      // Save to storage
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(AppConfig.tokenKey, response.token);
      await prefs.setString(AppConfig.userRoleKey, response.role);
      await prefs.setString(AppConfig.userEmailKey, response.email);

      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _error = e.toString().replaceAll('Exception: ', '');
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  /// Register new user
  Future<bool> register(String fullName, String email, String password) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final response = await _apiService.register(fullName, email, password);
      _currentUser = response.toUser();

      // Save to storage
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(AppConfig.tokenKey, response.token);
      await prefs.setString(AppConfig.userRoleKey, response.role);
      await prefs.setString(AppConfig.userEmailKey, response.email);

      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _error = e.toString().replaceAll('Exception: ', '');
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  /// Logout user
  Future<void> logout() async {
    _currentUser = null;
    _apiService.setToken(null);

    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(AppConfig.tokenKey);
    await prefs.remove(AppConfig.userRoleKey);
    await prefs.remove(AppConfig.userEmailKey);

    notifyListeners();
  }

  /// Clear error
  void clearError() {
    _error = null;
    notifyListeners();
  }
}
