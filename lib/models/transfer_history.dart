class TransferHistory {
  final String bankName;
  final String accountNumber;
  final String amount;
  final DateTime date;
  final String note;

  TransferHistory({
    required this.bankName,
    required this.accountNumber,
    required this.amount,
    required this.date,
    required this.note,
  });

  factory TransferHistory.fromMap(Map<String, dynamic> map) {
    return TransferHistory(
      bankName: map['bankName'],
      accountNumber: map['accountNumber'],
      amount: map['amount'],
      date: DateTime.parse(map['date']),
      note: map['note'],
    );
  }
} 