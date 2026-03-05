/// Wallet model
class Wallet {
  final String walletId;
  final double balance;
  final String currency;

  Wallet({
    required this.walletId,
    required this.balance,
    required this.currency,
  });

  factory Wallet.fromJson(Map<String, dynamic> json) {
    return Wallet(
      walletId: json['walletId'] ?? '',
      balance: (json['balance'] ?? 0).toDouble(),
      currency: json['currency'] ?? 'TZS',
    );
  }

  String get formattedBalance => '$currency ${balance.toStringAsFixed(2)}';

  // Alias for walletNumber compatibility
  String get walletNumber => walletId;
}

/// Transaction model
class Transaction {
  final String id;
  final String type;
  final String? fromUserId;
  final String? toUserId;
  final double amount;
  final String status;
  final String reference;
  final DateTime? createdAt;

  Transaction({
    required this.id,
    required this.type,
    this.fromUserId,
    this.toUserId,
    required this.amount,
    required this.status,
    required this.reference,
    this.createdAt,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['id'] ?? '',
      type: json['type'] ?? '',
      fromUserId: json['fromUserId'],
      toUserId: json['toUserId'],
      amount: (json['amount'] ?? 0).toDouble(),
      status: json['status'] ?? '',
      reference: json['reference'] ?? '',
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'])
          : null,
    );
  }

  String get typeLabel {
    switch (type) {
      case 'TRANSFER':
        return 'Transfer';
      case 'TOPUP':
        return 'Top-up';
      case 'WITHDRAWAL':
        return 'Withdrawal';
      default:
        return type;
    }
  }

  String get formattedAmount => 'TZS ${amount.toStringAsFixed(2)}';
}

/// Top-up Request model
class TopUpRequest {
  final String id;
  final String userId;
  final double amount;
  final String status;
  final DateTime createdAt;
  final String? reviewedBy;
  final DateTime? reviewedAt;

  TopUpRequest({
    required this.id,
    required this.userId,
    required this.amount,
    required this.status,
    required this.createdAt,
    this.reviewedBy,
    this.reviewedAt,
  });

  factory TopUpRequest.fromJson(Map<String, dynamic> json) {
    return TopUpRequest(
      id: json['id'] ?? '',
      userId: json['userId'] ?? '',
      amount: (json['amount'] ?? 0).toDouble(),
      status: json['status'] ?? 'PENDING',
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
      reviewedBy: json['reviewedBy'],
      reviewedAt: json['reviewedAt'] != null
          ? DateTime.tryParse(json['reviewedAt'])
          : null,
    );
  }

  bool get isPending => status == 'PENDING';
  bool get isApproved => status == 'APPROVED';
  bool get isRejected => status == 'REJECTED';

  String get formattedAmount => 'TZS ${amount.toStringAsFixed(2)}';
}
