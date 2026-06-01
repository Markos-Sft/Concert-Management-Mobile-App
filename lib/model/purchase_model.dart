// ─────────────────────────────────────────
//  models/purchase_model.dart
// ─────────────────────────────────────────

import 'concert_model.dart';

class PurchaseOrder {
  final String orderId;
  final Concert concert;
  final TicketTier tier;
  final int quantity;
  final DateTime purchasedAt;

  PurchaseOrder({
    required this.orderId,
    required this.concert,
    required this.tier,
    required this.quantity,
    required this.purchasedAt,
  });

  double get totalPrice => tier.price * quantity;

  /// Payload encoded inside the QR code
  String get qrPayload =>
      'GIGGO|ORDER:$orderId'
      '|CONCERT:${concert.name}'
      '|DATE:${concert.date}'
      '|VENUE:${concert.venue}'
      '|TIER:${tier.type}'
      '|QTY:$quantity'
      '|TOTAL:\$${totalPrice.toStringAsFixed(2)}';
}
