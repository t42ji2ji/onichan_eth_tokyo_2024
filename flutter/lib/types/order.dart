class Order {
  final BigInt id;
  final String from;
  final String token;
  final String symbol;
  final BigInt amount;
  final BigInt conditionHash;

  Order({
    required this.id,
    required this.from,
    required this.token,
    required this.symbol,
    required this.amount,
    required this.conditionHash,
  });
}
