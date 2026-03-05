import 'package:flutter/foundation.dart';
import '../models/wallet_model.dart';
import '../services/api_service.dart';

/// Wallet state provider
class WalletProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();

  Wallet? _wallet;
  List<Transaction> _transactions = [];
  List<TopUpRequest> _topUpRequests = [];
  bool _isLoading = false;
  String? _error;

  Wallet? get wallet => _wallet;
  List<Transaction> get transactions => _transactions;
  List<TopUpRequest> get topUpRequests => _topUpRequests;
  bool get isLoading => _isLoading;
  String? get error => _error;

  /// Set token for API calls
  void setToken(String token) {
    _apiService.setToken(token);
  }

  /// Load wallet balance
  Future<void> loadBalance() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _wallet = await _apiService.getBalance();
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = e.toString().replaceAll('Exception: ', '');
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Transfer funds
  Future<bool> transfer(String recipientId, double amount) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final transaction = await _apiService.transfer(recipientId, amount);
      _transactions.insert(0, transaction);
      await loadBalance(); // Refresh balance
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

  /// Request top-up
  Future<bool> requestTopUp(
      double amount, String paymentMethod, String phoneNumber) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final request =
          await _apiService.requestTopUp(amount, paymentMethod, phoneNumber);
      _topUpRequests.insert(0, request);
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

  /// Load transaction history
  Future<void> loadTransactions({int page = 0, int size = 20}) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _transactions = await _apiService.getTransactions(page: page, size: size);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = e.toString().replaceAll('Exception: ', '');
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Load pending top-up requests (admin)
  Future<void> loadPendingTopUpRequests({int page = 0, int size = 20}) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _topUpRequests =
          await _apiService.getPendingTopUpRequests(page: page, size: size);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = e.toString().replaceAll('Exception: ', '');
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Approve top-up request (admin)
  Future<bool> approveTopUpRequest(String requestId) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      await _apiService.approveTopUpRequest(requestId);
      _topUpRequests.removeWhere((r) => r.id == requestId);
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

  /// Reject top-up request (admin)
  Future<bool> rejectTopUpRequest(String requestId) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      await _apiService.rejectTopUpRequest(requestId);
      _topUpRequests.removeWhere((r) => r.id == requestId);
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

  /// Admin direct top-up
  Future<bool> adminTopUp(String userId, double amount) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      await _apiService.adminTopUp(userId, amount);
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

  /// Clear error
  void clearError() {
    _error = null;
    notifyListeners();
  }

  /// Reset state
  void reset() {
    _wallet = null;
    _transactions = [];
    _topUpRequests = [];
    _error = null;
    notifyListeners();
  }
}
