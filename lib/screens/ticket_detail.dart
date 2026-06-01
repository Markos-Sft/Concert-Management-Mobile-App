// ─────────────────────────────────────────
//  screens/ticket_detail.dart
//  Shown when user taps "GET TICKET"
// ─────────────────────────────────────────
import 'dart:async';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'dart:math';
import 'package:flutter/material.dart';
import '../model/concert_model.dart';
import '../model/purchase_model.dart';
import 'purchase.dart';

class TicketDetailScreen extends StatefulWidget {
  final Concert concert;
  const TicketDetailScreen({super.key, required this.concert});

  @override
  State<TicketDetailScreen> createState() => _TicketDetailScreenState();
}

class _TicketDetailScreenState extends State<TicketDetailScreen> {
  int _selectedTierIndex = 2; // default: Normal
  int _quantity = 1;

  TicketTier get _selectedTier => widget.concert.tiers[_selectedTierIndex];

  double get _total => _selectedTier.price * _quantity;

  // Tier accent colours
  static const Map<String, Color> _tierColors = {
    'VVIP': Color(0xFFFFD700),
    'VIP': Color(0xFF9B7FFF),
    'Normal': Color(0xFFEE33E1),
  };

  Color get _accentColor =>
      _tierColors[_selectedTier.type] ?? const Color(0xFFEE33E1);

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
        title: Text(
          widget.concert.name,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w800,
            fontSize: 16,
          ),
          overflow: TextOverflow.ellipsis,
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── 1. Artists lineup ──────────────────────────────────────
            const _SectionHeader(title: '🎤 Artists Performing'),
            SizedBox(
              height: 140,
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                scrollDirection: Axis.horizontal,
                itemCount: widget.concert.artists.length,
                itemBuilder: (_, i) =>
                    _ArtistCard(artist: widget.concert.artists[i]),
              ),
            ),

            const SizedBox(height: 24),

            // ── 2. Ticket tier selection ───────────────────────────────
            const _SectionHeader(title: '🎫 Select Ticket Type'),
            ...List.generate(
              widget.concert.tiers.length,
              (i) => _TierCard(
                tier: widget.concert.tiers[i],
                isSelected: _selectedTierIndex == i,
                onTap: () => setState(() => _selectedTierIndex = i),
              ),
            ),

            const SizedBox(height: 24),

            // ── 3. Quantity selector ───────────────────────────────────
            const _SectionHeader(title: '🎟️ Number of Tickets'),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFF13131E),
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(
                    color: _accentColor.withValues(alpha: 0.3),
                    width: 1.5,
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Tickets',
                            style: TextStyle(
                              color: Color(0xFF8A8A9A),
                              fontSize: 13,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'ETB ${_selectedTier.price.toStringAsFixed(0)} each',
                            style: TextStyle(
                              color: _accentColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Minus button
                    _QtyButton(
                      icon: Icons.remove,
                      onTap: () {
                        if (_quantity > 1) {
                          setState(() => _quantity--);
                        }
                      },
                      accentColor: _accentColor,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        '$_quantity',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                    // Plus button
                    _QtyButton(
                      icon: Icons.add,
                      onTap: () => setState(() => _quantity++),
                      accentColor: _accentColor,
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // ── 4. Map / Location ──────────────────────────────────────
            const _SectionHeader(title: '📍 Concert Location'),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: _MapCard(concert: widget.concert),
            ),

            const SizedBox(height: 24),

            // ── 5. Total + Purchase button ─────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 36),
              child: Column(
                children: [
                  // Total row
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 16,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF13131E),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: const Color(0xFF252535),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Total Amount',
                              style: TextStyle(
                                color: Color(0xFF8A8A9A),
                                fontSize: 13,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              '$_quantity × ETB ${_selectedTier.price.toStringAsFixed(0)}',
                              style: const TextStyle(
                                color: Color(0xFF8A8A9A),
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          'ETB ${_total.toStringAsFixed(2)}',
                          style: TextStyle(
                            color: _accentColor,
                            fontSize: 26,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 18),

                  ConcertCountdown(concertDate: widget.concert.concertDateTime),

                  const SizedBox(height: 14),

                  // Purchase button
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _accentColor,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 0,
                      ),
                      onPressed: _onPurchase,
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.shopping_bag_rounded, size: 22),
                          SizedBox(width: 10),
                          Text(
                            'PURCHASE TICKET',
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              letterSpacing: 2,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onPurchase() {
    final order = PurchaseOrder(
      orderId: _generateOrderId(),
      concert: widget.concert,
      tier: _selectedTier,
      quantity: _quantity,
      purchasedAt: DateTime.now(),
    );
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => PurchaseScreen(order: order)),
    );
  }

  String _generateOrderId() {
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final rng = Random();
    return List.generate(10, (_) => chars[rng.nextInt(chars.length)]).join();
  }
}

// ─── Artist card ──────────────────────────────────────────────────────────────

class _ArtistCard extends StatelessWidget {
  final Artist artist;
  const _ArtistCard({required this.artist});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      margin: const EdgeInsets.only(right: 12),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Image.network(
              artist.imageAsset,
              width: 80,
              height: 80,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                width: 80,
                height: 80,
                decoration: const BoxDecoration(
                  color: Color(0xFF1E1E2E),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.person,
                  color: Color(0xFF3A3A5A),
                  size: 36,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            artist.name,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 2),
          Text(
            artist.genre,
            style: const TextStyle(color: Color(0xFF8A8A9A), fontSize: 10),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

// ─── Tier card ────────────────────────────────────────────────────────────────

class _TierCard extends StatelessWidget {
  final TicketTier tier;
  final bool isSelected;
  final VoidCallback onTap;

  static const Map<String, Color> _colors = {
    'VVIP': Color(0xFFFFD700),
    'VIP': Color(0xFF9B7FFF),
    'Normal': Color(0xFFE8FF47),
  };

  const _TierCard({
    required this.tier,
    required this.isSelected,
    required this.onTap,
  });

  Color get color => _colors[tier.type] ?? const Color(0xFFE8FF47);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.fromLTRB(16, 0, 16, 10),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFFEE33E1).withValues(alpha: 0.15)
              : const Color(0xFF13131E),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? color : const Color(0xFF252535),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            // Emoji + type
            Text(tier.emoji, style: const TextStyle(fontSize: 26)),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tier.type,
                    style: TextStyle(
                      color: isSelected ? color : Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    tier.perks,
                    style: const TextStyle(
                      color: Color(0xFF8A8A9A),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            // Price
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'ETB ${tier.price.toStringAsFixed(0)}',
                  style: TextStyle(
                    color: isSelected ? color : Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const Text(
                  'per ticket',
                  style: TextStyle(color: Color(0xFF8A8A9A), fontSize: 10),
                ),
              ],
            ),
            const SizedBox(width: 10),
            // Radio indicator
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? color : const Color(0xFF3A3A5A),
                  width: 2,
                ),
                color: isSelected ? color : Colors.transparent,
              ),
              child: isSelected
                  ? const Icon(Icons.check, size: 14, color: Color(0xFF1A1023))
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Map card (static map via OpenStreetMap tiles) ───────────────────────────

class _MapCard extends StatelessWidget {
  final Concert concert;

  const _MapCard({required this.concert});

  @override
  Widget build(BuildContext context) {
    final location = LatLng(concert.latitude, concert.longitude);

    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF4B256B),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFF252535), width: 1),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(18)),

            child: SizedBox(
              height: 220,

              child: FlutterMap(
                options: MapOptions(initialCenter: location, initialZoom: 13),

                children: [
                  TileLayer(
                    urlTemplate:
                        'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    userAgentPackageName: 'com.example.app',
                  ),

                  MarkerLayer(
                    markers: [
                      Marker(
                        point: location,
                        width: 80,
                        height: 80,

                        child: const Icon(
                          Icons.location_on,
                          color: Colors.red,
                          size: 40,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(14),

            child: Row(
              children: [
                const Icon(Icons.location_on_rounded, color: Color(0xFFEE33E1)),

                const SizedBox(width: 8),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      Text(
                        concert.venue,

                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      Text(
                        concert.city,

                        style: const TextStyle(color: Color(0xFFD0B3FF)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
// ─── Quantity button ──────────────────────────────────────────────────────────

class _QtyButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final Color accentColor;

  const _QtyButton({
    required this.icon,
    required this.onTap,
    required this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 42,
        height: 42,
        decoration: BoxDecoration(
          color: accentColor.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: accentColor.withValues(alpha: 0.4)),
        ),
        child: Icon(icon, color: accentColor, size: 20),
      ),
    );
  }
}

// ─── Section header ───────────────────────────────────────────────────────────

class _SectionHeader extends StatelessWidget {
  final String title;

  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF13131E),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: const Color(0xFF252535)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(children: []),

            Padding(
              padding: const EdgeInsets.all(12),
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ConcertCountdown extends StatefulWidget {
  final DateTime concertDate;

  const ConcertCountdown({super.key, required this.concertDate});

  @override
  State<ConcertCountdown> createState() => _ConcertCountdownState();
}

class _ConcertCountdownState extends State<ConcertCountdown> {
  late Timer timer;
  Duration remaining = Duration.zero;

  @override
  void initState() {
    super.initState();

    updateCountdown();

    timer = Timer.periodic(
      const Duration(seconds: 1),
      (_) => updateCountdown(),
    );
  }

  void updateCountdown() {
    final difference = widget.concertDate.difference(DateTime.now());

    setState(() {
      remaining = difference.isNegative ? Duration.zero : difference;
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  String twoDigits(int n) => n.toString().padLeft(2, '0');

  @override
  Widget build(BuildContext context) {
    final days = remaining.inDays;
    final hours = remaining.inHours.remainder(24);
    final minutes = remaining.inMinutes.remainder(60);
    final seconds = remaining.inSeconds.remainder(60);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
      decoration: BoxDecoration(
        color: const Color(0xFF13131E),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFF252535)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.timer_outlined, color: Color(0xFFEE33E1), size: 18),
              SizedBox(width: 8),
              Text(
                'Concert Starts In',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _TimeBox(value: '$days', label: 'DAYS'),
              _TimeBox(value: twoDigits(hours), label: 'HRS'),
              _TimeBox(value: twoDigits(minutes), label: 'MIN'),
              _TimeBox(value: twoDigits(seconds), label: 'SEC'),
            ],
          ),
        ],
      ),
    );
  }
}

class _TimeBox extends StatelessWidget {
  final String value;
  final String label;

  const _TimeBox({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        color: const Color(0xFF2B1740),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(
              color: Color(0xFFEE33E1),
              fontSize: 24,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(
              color: Color(0xFF9A9AA8),
              fontSize: 11,
              fontWeight: FontWeight.w700,
              letterSpacing: 1,
            ),
          ),
        ],
      ),
    );
  }
}
