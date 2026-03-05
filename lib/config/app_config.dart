/// App configuration constants
class AppConfig {
  // API Base URL - Change this to your backend URL
  // For emulator: use 10.0.2.2 for Android emulator to reach localhost
  // For physical device: use your computer's local IP address
  static const String apiBaseUrl = 'http://10.0.2.2:8080/api/v1';

  // API Endpoints
  static const String authLogin = '/auth/login';
  static const String authRegister = '/auth/register';
  static const String walletBalance = '/wallet/balance';
  static const String walletTransfer = '/wallet/transfer';
  static const String walletTopUpRequest = '/wallet/topup-request';
  static const String walletTransactions = '/wallet/transactions';
  static const String adminTopUpRequests = '/admin/topup-requests';
  static const String adminWalletTopUp = '/admin/wallet/topup';

  // Storage Keys
  static const String tokenKey = 'auth_token';
  static const String userRoleKey = 'user_role';
  static const String userEmailKey = 'user_email';

  // User Roles
  static const String roleAdmin = 'ADMIN';
  static const String roleUser = 'USER';
}
