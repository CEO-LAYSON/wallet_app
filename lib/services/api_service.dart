import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/app_config.dart';
import '../models/user_model.dart';
import '../models/wallet_model.dart';

/// API Service for making HTTP requests to the backend
class ApiService {
  final String baseUrl;
  String? _token;

  ApiService({String? baseUrl}) : baseUrl = baseUrl ?? AppConfig.apiBaseUrl;

  /// Set the authentication token
  void setToken(String? token) {
    _token = token;
  }

  /// Get the authentication token
  String? getToken() => _token;

  /// Get headers with authentication
  Map<String, String> get _headers {
    final headers = <String, String>{
      'Content-Type': 'application/json',
    };
    if (_token != null) {
      headers['Authorization'] = 'Bearer $_token';
    }
    return headers;
  }

  /// Handle API response
  dynamic _handleResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      if (response.body.isEmpty) return null;
      return json.decode(response.body);
    } else {
      final body = response.body.isNotEmpty ? json.decode(response.body) : {};
      final message = body['message'] ?? 'An error occurred';
      throw Exception(message);
    }
  }

  // ==================== AUTH ====================

  /// Login user
  Future<AuthResponse> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl${AppConfig.authLogin}'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'email': email, 'password': password}),
    );

    final data = _handleResponse(response);
    final authResponse = AuthResponse.fromJson(data['data']);
    _token = authResponse.token;
    return authResponse;
  }

  /// Register new user
  Future<AuthResponse> register(
      String fullName, String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl${AppConfig.authRegister}'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'fullName': fullName,
        'email': email,
        'password': password,
      }),
    );

    final data = _handleResponse(response);
    final authResponse = AuthResponse.fromJson(data['data']);
    _token = authResponse.token;
    return authResponse;
  }

  // ==================== WALLET ====================

  /// Get wallet balance
  Future<Wallet> getBalance() async {
    final response = await http.get(
      Uri.parse('$baseUrl${AppConfig.walletBalance}'),
      headers: _headers,
    );

    final data = _handleResponse(response);
    return Wallet.fromJson(data['data']);
  }

  /// Transfer funds
  Future<Transaction> transfer(String recipientId, double amount) async {
    final response = await http.post(
      Uri.parse('$baseUrl${AppConfig.walletTransfer}'),
      headers: _headers,
      body: json.encode({
        'recipientId': recipientId,
        'amount': amount,
      }),
    );

    final data = _handleResponse(response);
    return Transaction.fromJson(data['data']);
  }

  /// Request top-up
  Future<TopUpRequest> requestTopUp(
      double amount, String paymentMethod, String phoneNumber) async {
    final response = await http.post(
      Uri.parse('$baseUrl${AppConfig.walletTopUpRequest}'),
      headers: _headers,
      body: json.encode({
        'amount': amount,
        'paymentMethod': paymentMethod,
        'phoneNumber': phoneNumber,
      }),
    );

    final data = _handleResponse(response);
    return TopUpRequest.fromJson(data['data']);
  }

  /// Get transaction history
  Future<List<Transaction>> getTransactions(
      {int page = 0, int size = 20}) async {
    final response = await http.get(
      Uri.parse(
          '$baseUrl${AppConfig.walletTransactions}?page=$page&size=$size'),
      headers: _headers,
    );

    final data = _handleResponse(response);
    final content = data['data']['content'] as List;
    return content.map((e) => Transaction.fromJson(e)).toList();
  }

  // ==================== ADMIN ====================

  /// Get pending top-up requests
  Future<List<TopUpRequest>> getPendingTopUpRequests(
      {int page = 0, int size = 20}) async {
    final response = await http.get(
      Uri.parse(
          '$baseUrl${AppConfig.adminTopUpRequests}?page=$page&size=$size'),
      headers: _headers,
    );

    final data = _handleResponse(response);
    final content = data['data']['content'] as List;
    return content.map((e) => TopUpRequest.fromJson(e)).toList();
  }

  /// Approve top-up request
  Future<void> approveTopUpRequest(String requestId) async {
    final response = await http.post(
      Uri.parse('$baseUrl${AppConfig.adminTopUpRequests}/$requestId/approve'),
      headers: _headers,
    );

    _handleResponse(response);
  }

  /// Reject top-up request
  Future<void> rejectTopUpRequest(String requestId) async {
    final response = await http.post(
      Uri.parse('$baseUrl${AppConfig.adminTopUpRequests}/$requestId/reject'),
      headers: _headers,
    );

    _handleResponse(response);
  }

  /// Admin direct top-up
  Future<Transaction> adminTopUp(String userId, double amount) async {
    final response = await http.post(
      Uri.parse('$baseUrl${AppConfig.adminWalletTopUp}'),
      headers: _headers,
      body: json.encode({
        'userId': userId,
        'amount': amount,
      }),
    );

    final data = _handleResponse(response);
    return Transaction.fromJson(data['data']);
  }
}
