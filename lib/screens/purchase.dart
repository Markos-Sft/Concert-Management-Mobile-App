// ─────────────────────────────────────────
//  screens/purchase.dart  –  Confirmation
//  + QR code ticket screen
// ─────────────────────────────────────────

import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import '../model/purchase_model.dart';

class PurchaseScreen extends StatelessWidget {
  final PurchaseOrder order;
  const PurchaseScreen({super.key, required this.order});

  static const Map<String, Color> _tierColors = {
    'VVIP': Color(0xFFFFD700),
    'VIP': Color(0xFF9B7FFF),
    'Normal': Color(0xFFE8FF47),
  };

  Color get _accentColor =>
      _tierColors[order.tier.type] ?? const Color(0xFFE8FF47);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0F),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0A0A0F),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white,
            size: 20,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Your Ticket',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w800,
            fontSize: 18,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Icon(Icons.download_rounded, color: _accentColor, size: 24),
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 40),
        child: Column(
          children: [
            // ── Success banner ───────────────────────────────────────
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    _accentColor.withValues(alpha: 0.2),
                    _accentColor.withValues(alpha: 0.05),
                  ],
                ),
                borderRadius: BorderRadius.circular(18),
                border: Border.all(
                  color: _accentColor.withValues(alpha: 0.4),
                  width: 1.5,
                ),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: _accentColor.withValues(alpha: 0.2),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.check_circle_rounded,
                      color: _accentColor,
                      size: 28,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Booking Confirmed!',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          'Order #${order.orderId}',
                          style: const TextStyle(
                            color: Color(0xFF8A8A9A),
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // ── Ticket card ──────────────────────────────────────────
            _TicketCard(order: order, accentColor: _accentColor),

            const SizedBox(height: 20),

            // ── QR code ──────────────────────────────────────────────
            _QrSection(order: order, accentColor: _accentColor),

            const SizedBox(height: 20),

            // ── Order details ─────────────────────────────────────────
            _OrderDetailsCard(order: order, accentColor: _accentColor),

            const SizedBox(height: 28),

            // ── Done button ───────────────────────────────────────────
            SizedBox(
              width: double.infinity,
              height: 54,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: _accentColor,
                  foregroundColor: const Color(0xFF0A0A0F),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 0,
                ),
                onPressed: () {
                  // Navigate back to concert list
                  Navigator.popUntil(context, (route) => route.isFirst);
                },
                child: const Text(
                  'BACK TO CONCERTS',
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    letterSpacing: 2,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Ticket card ──────────────────────────────────────────────────────────────

class _TicketCard extends StatelessWidget {
  final PurchaseOrder order;
  final Color accentColor;
  const _TicketCard({required this.order, required this.accentColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF13131E),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: accentColor.withValues(alpha: 0.3),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: accentColor.withValues(alpha: 0.1),
            blurRadius: 30,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          // ── Concert banner ──────────────────────────────────────────
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(22)),
            child: Stack(
              children: [
                Image.network(
                  order.concert.bannerimageAsset,
                  height: 160,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    height: 160,
                    color: const Color(0xFF1E1E2E),
                    child: const Icon(
                      Icons.music_note,
                      color: Color(0xFF3A3A5A),
                      size: 50,
                    ),
                  ),
                ),
                // Overlay
                Positioned.fill(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withValues(alpha: 0.8),
                        ],
                      ),
                    ),
                  ),
                ),
                // Tier badge
                Positioned(
                  top: 14,
                  right: 14,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: accentColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      '${order.tier.emoji} ${order.tier.type}',
                      style: const TextStyle(
                        color: Color(0xFF0A0A0F),
                        fontWeight: FontWeight.w900,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
                // Concert name
                Positioned(
                  bottom: 14,
                  left: 16,
                  right: 16,
                  child: Text(
                    order.concert.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // ── Dashed divider ──────────────────────────────────────────
          _DashedDivider(color: accentColor),

          // ── Concert details ─────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                _DetailRow(
                  icon: Icons.calendar_today_rounded,
                  label: 'Date & Time',
                  value: order.concert.date,
                  accentColor: accentColor,
                ),
                const SizedBox(height: 14),
                _DetailRow(
                  icon: Icons.location_on_rounded,
                  label: 'Venue',
                  value: '${order.concert.venue}\n${order.concert.city}',
                  accentColor: accentColor,
                ),
                const SizedBox(height: 14),
                _DetailRow(
                  icon: Icons.confirmation_number_rounded,
                  label: 'Ticket Type',
                  value: order.tier.type,
                  accentColor: accentColor,
                ),
                const SizedBox(height: 14),
                _DetailRow(
                  icon: Icons.people_rounded,
                  label: 'Quantity',
                  value:
                      '${order.quantity} Ticket${order.quantity > 1 ? 's' : ''}',
                  accentColor: accentColor,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─── QR section ───────────────────────────────────────────────────────────────

class _QrSection extends StatelessWidget {
  final PurchaseOrder order;
  final Color accentColor;
  const _QrSection({required this.order, required this.accentColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF13131E),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: const Color(0xFF252535), width: 1),
      ),
      child: Column(
        children: [
          const Text(
            'Scan to Verify Ticket',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Present this QR code at the entrance',
            style: TextStyle(color: Color(0xFF8A8A9A), fontSize: 12),
          ),
          const SizedBox(height: 20),

          // QR code widget (custom painter – no external package needed)
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: _QrCodePainterWidget(
              data: order.qrPayload,
              size: 200,
              foregroundColor: Colors.black,
            ),
          ),

          const SizedBox(height: 16),
          SelectableText(
            order.orderId,
            style: TextStyle(
              color: accentColor,
              fontSize: 18,
              fontWeight: FontWeight.w900,
              letterSpacing: 4,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Order ID',
            style: TextStyle(color: Color(0xFF8A8A9A), fontSize: 12),
          ),
        ],
      ),
    );
  }
}

// ─── Custom QR Code Painter (no external package) ────────────────────────────
// Implements a simplified QR-style visual from the order payload hash.
// For production, use the `qr_flutter` package instead.

class _QrCodePainterWidget extends StatelessWidget {
  final String data;
  final double size;
  final Color foregroundColor;

  const _QrCodePainterWidget({
    required this.data,
    required this.size,
    required this.foregroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size, size),
      painter: _QrPainter(data: data, fgColor: foregroundColor),
    );
  }
}

class _QrPainter extends CustomPainter {
  final String data;
  final Color fgColor;

  _QrPainter({required this.data, required this.fgColor});

  // Generate a deterministic pseudo-random grid from the data string
  List<List<bool>> _buildGrid(int modules) {
    final grid = List.generate(modules, (_) => List.filled(modules, false));
    // Seed from data bytes
    final bytes = utf8.encode(data);
    int seed = 0;
    for (final b in bytes) {
      seed = (seed * 31 + b) & 0xFFFFFFFF;
    }

    // Fill interior
    for (int r = 0; r < modules; r++) {
      for (int c = 0; c < modules; c++) {
        seed = (seed * 1664525 + 1013904223) & 0xFFFFFFFF;
        grid[r][c] = (seed >> 16) & 1 == 1;
      }
    }

    // Apply fixed-position finders (top-left, top-right, bottom-left)
    _drawFinder(grid, 0, 0, modules);
    _drawFinder(grid, 0, modules - 7, modules);
    _drawFinder(grid, modules - 7, 0, modules);

    // Timing patterns
    for (int i = 8; i < modules - 8; i++) {
      grid[6][i] = i % 2 == 0;
      grid[i][6] = i % 2 == 0;
    }

    return grid;
  }

  void _drawFinder(List<List<bool>> grid, int row, int col, int modules) {
    for (int r = 0; r < 7; r++) {
      for (int c = 0; c < 7; c++) {
        final onBorder = r == 0 || r == 6 || c == 0 || c == 6;
        final onInner = r >= 2 && r <= 4 && c >= 2 && c <= 4;
        if (row + r < modules && col + c < modules) {
          grid[row + r][col + c] = onBorder || onInner;
        }
      }
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    const modules = 25;
    final cellSize = size.width / modules;
    final paint = Paint()..color = fgColor;

    final grid = _buildGrid(modules);

    for (int r = 0; r < modules; r++) {
      for (int c = 0; c < modules; c++) {
        if (grid[r][c]) {
          canvas.drawRect(
            Rect.fromLTWH(c * cellSize, r * cellSize, cellSize, cellSize),
            paint,
          );
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant _QrPainter old) => old.data != data;
}

// ─── Order details card ───────────────────────────────────────────────────────

class _OrderDetailsCard extends StatelessWidget {
  final PurchaseOrder order;
  final Color accentColor;
  const _OrderDetailsCard({required this.order, required this.accentColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF13131E),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFF252535), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Payment Summary',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w800,
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 14),
          _SummaryRow(
            label: '${order.tier.type} Ticket × ${order.quantity}',
            value:
                'ETB ${(order.tier.price * order.quantity).toStringAsFixed(2)}',
            color: Colors.white,
          ),
          const SizedBox(height: 8),
          _SummaryRow(
            label: 'Service fee',
            value: 'ETB ${(order.quantity * 2.5).toStringAsFixed(2)}',
            color: const Color(0xFF8A8A9A),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: Divider(color: Color(0xFF252535)),
          ),
          _SummaryRow(
            label: 'Total Paid',
            value:
                'ETB ${(order.totalPrice + order.quantity * 2.5).toStringAsFixed(2)}',
            color: accentColor,
            isBold: true,
            fontSize: 16,
          ),
        ],
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final String label;
  final String value;
  final Color color;
  final bool isBold;
  final double fontSize;

  const _SummaryRow({
    required this.label,
    required this.value,
    required this.color,
    this.isBold = false,
    this.fontSize = 13,
  });

  @override
  Widget build(BuildContext context) {
    final style = TextStyle(
      color: color,
      fontWeight: isBold ? FontWeight.w900 : FontWeight.w500,
      fontSize: fontSize,
    );
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: style),
        Text(value, style: style),
      ],
    );
  }
}

// ─── Detail row ───────────────────────────────────────────────────────────────

class _DetailRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color accentColor;

  const _DetailRow({
    required this.icon,
    required this.label,
    required this.value,
    required this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: accentColor.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: accentColor, size: 16),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(color: Color(0xFF8A8A9A), fontSize: 11),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ─── Dashed divider ───────────────────────────────────────────────────────────

class _DashedDivider extends StatelessWidget {
  final Color color;
  const _DashedDivider({required this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: CustomPaint(
        size: const Size(double.infinity, 20),
        painter: _DashPainter(color: color),
      ),
    );
  }
}

class _DashPainter extends CustomPainter {
  final Color color;
  _DashPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color.withValues(alpha: 0.3)
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    // Left notch
    canvas.drawArc(
      Rect.fromCircle(center: Offset(0, size.height / 2), radius: 10),
      -1.57,
      3.14,
      false,
      Paint()
        ..color = const Color(0xFF0A0A0F)
        ..style = PaintingStyle.fill,
    );
    // Right notch
    canvas.drawArc(
      Rect.fromCircle(center: Offset(size.width, size.height / 2), radius: 10),
      1.57,
      3.14,
      false,
      Paint()
        ..color = const Color(0xFF0A0A0F)
        ..style = PaintingStyle.fill,
    );

    // Dashed line
    double x = 16;
    while (x < size.width - 16) {
      canvas.drawLine(
        Offset(x, size.height / 2),
        Offset(x + 8, size.height / 2),
        paint,
      );
      x += 14;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter old) => false;
}
