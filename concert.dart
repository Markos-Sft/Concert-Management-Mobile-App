import 'dart:async';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

// ══════════════════════════════════════════════════════════════════════════════
//  HOW TO ADD REAL ARTIST PHOTOS
//  ─────────────────────────────────────────────────────────────────────────────
//  In each ConcertEvent below, set:
//    imageAsset: 'assets/img/weeknd.jpg'   ← local file (register in pubspec)
//    imageUrl:   'https://...'             ← OR internet URL
// ══════════════════════════════════════════════════════════════════════════════

// ─────────────────────────────────────────────────────────────────────────────
//  DATA MODELS
// ─────────────────────────────────────────────────────────────────────────────

class ConcertTicket {
  final String name;
  final String badge;
  final Color badgeColor;
  final String description;
  final int price;
  int quantity;
  ConcertTicket({
    required this.name,
    required this.badge,
    required this.badgeColor,
    required this.description,
    required this.price,
    this.quantity = 0,
  });

  ConcertTicket copyWith() => ConcertTicket(
    name: name,
    badge: badge,
    badgeColor: badgeColor,
    description: description,
    price: price,
    quantity: quantity,
  );
}

class ConcertArtist {
  final String name;
  final String role;
  final String? imageAsset;
  final String? imageUrl;
  final Color glowColor;
  const ConcertArtist({
    required this.name,
    required this.role,
    this.imageAsset,
    this.imageUrl,
    required this.glowColor,
  });
}

class ConcertEvent {
  final String id;
  final String tourName;
  final String date; // display string  e.g. '14 Aug, 2025 · 8:00 PM'
  final DateTime dateTime; // ← COUNTDOWN — change this to real date
  final String venueName;
  final String venueAddress;
  final double venueLat;
  final double venueLng;
  final List<ConcertArtist> artists;
  final List<ConcertTicket> Function() ticketsFactory; // fresh list each time

  const ConcertEvent({
    required this.id,
    required this.tourName,
    required this.date,
    required this.dateTime,
    required this.venueName,
    required this.venueAddress,
    required this.venueLat,
    required this.venueLng,
    required this.artists,
    required this.ticketsFactory,
  });
}

// ══════════════════════════════════════════════════════════════════════════════
//  ★  ALL CONCERTS — EDIT THIS LIST TO ADD / CHANGE CONCERTS  ★
// ══════════════════════════════════════════════════════════════════════════════
final List<ConcertEvent> allConcerts = [
  // ── CONCERT 1 ──────────────────────────────────────────────────────────────
  ConcertEvent(
    id: 'c1',
    tourName: 'Ethorika Concert',
    date: '7 jul , 2026 · 8:00 PM',
    dateTime: DateTime(2026, 7, 7, 15, 53, 0),
    venueName: 'Millennium Hall', // ← changed
    venueAddress: 'Airport Road, Addis Ababa, Ethiopia', // ← changed
    venueLat: 8.99064, // ← changed
    venueLng: 38.7889,
    artists: const [
      ConcertArtist(
        name: 'Tedy Afro',
        role: 'Headliner',
        //imageAsset: 'assets/img/tedy.jpg',
        glowColor: Color(0xFF9D4EDD),
      ),
      ConcertArtist(
        name: 'Tedy Afro',
        role: 'Performer',
        // imageAsset: 'assets/img/drake.jpg',
        imageUrl: 'https://i.pravatar.cc/400?img=68',
        glowColor: Color(0xFF3B82F6),
      ),
    ],
    ticketsFactory: () => [
      ConcertTicket(
        name: 'VVIP Pass',
        badge: '👑 VVIP',
        badgeColor: const Color(0xFFE879F9),
        description: 'Front row · Backstage pass · Meet & greet · Lounge',
        price: 4500,
      ),
      ConcertTicket(
        name: 'VIP Pass',
        badge: '⭐ VIP',
        badgeColor: const Color(0xFFFBBF24),
        description: 'Reserved seating · Fast entry · Gift pack',
        price: 2200,
      ),
      ConcertTicket(
        name: 'Normal',
        badge: '🎟 NORMAL',
        badgeColor: const Color(0xFFA5B4FC),
        description: 'General admission · Standing area',
        price: 800,
      ),
    ],
  ),

  // ── CONCERT 2 ──────────────────────────────────────────────────────────────
  ConcertEvent(
    id: 'c2',
    tourName: 'Hagere Concert',
    date: '14 jul, 2026 · 9:00 PM',
    dateTime: DateTime(2026, 9, 14, 21, 0), // ← CHANGE countdown date here
    venueName: 'Millennium Hall',
    venueAddress: 'Airport Road, Addis Ababa, Ethiopia', // ← changed
    venueLat: 8.99064, // ← changed (was 9.0054)
    venueLng: 38.7889,
    artists: const [
      ConcertArtist(
        name: 'Aster Aweke',
        role: 'Headliner',
        // imageAsset: 'assets/img/post_malone.jpg',
        imageUrl: 'https://i.pravatar.cc/400?img=53',
        glowColor: Color(0xFFF59E0B),
      ),
      ConcertArtist(
        name: 'Mohammud Ahmed',
        role: 'Opening Act',
        // imageAsset: 'assets/img/mia.jpg',
        imageUrl: 'https://i.pravatar.cc/400?img=20',
        glowColor: Color(0xFFF472B6),
      ),
    ],
    ticketsFactory: () => [
      ConcertTicket(
        name: 'VVIP Pass',
        badge: '👑 VVIP',
        badgeColor: const Color(0xFFE879F9),
        description: 'VIP Lounge · Soundcheck access · Gift box',
        price: 6000,
      ),
      ConcertTicket(
        name: 'VIP Pass',
        badge: '⭐ VIP',
        badgeColor: const Color(0xFFFBBF24),
        description: 'Reserved seats · Fast lane entry',
        price: 3000,
      ),
      ConcertTicket(
        name: 'Normal',
        badge: '🎟 NORMAL',
        badgeColor: const Color(0xFFA5B4FC),
        description: 'General standing · Regular entry',
        price: 1200,
      ),
    ],
  ),

  // ── CONCERT 3 ──────────────────────────────────────────────────────────────
  ConcertEvent(
    id: 'c3',
    tourName: 'Fiker Concert',
    date: '21 jun, 2026 · 7:00 PM',
    dateTime: DateTime(2026, 10, 21, 19, 0), // ← CHANGE countdown date here
    venueName: 'Millennium Hall', // ← changed
    venueAddress: 'Airport Road, Addis Ababa, Ethiopia', // ← changed
    venueLat: 8.99064, // ← changed (was 9.0179)
    venueLng: 38.7889,
    artists: const [
      ConcertArtist(
        name: 'Michael belayneh',
        role: 'Headliner',
        // imageAsset: 'assets/img/luna.jpg',
        imageUrl: 'https://i.pravatar.cc/400?img=47',
        glowColor: Color(0xFF34D399),
      ),
      ConcertArtist(
        name: 'Gossaye Tesfaye',
        role: 'Co-Headliner',
        // imageAsset: 'assets/img/ares.jpg',
        imageUrl: 'https://i.pravatar.cc/400?img=32',
        glowColor: Color(0xFF818CF8),
      ),
      ConcertArtist(
        name: 'Lij Michael',
        role: 'Special Guest',
        // imageAsset: 'assets/img/zara.jpg',
        imageUrl: 'https://i.pravatar.cc/400?img=25',
        glowColor: Color(0xFFFBBF24),
      ),
    ],
    ticketsFactory: () => [
      ConcertTicket(
        name: 'VVIP Pass',
        badge: '👑 VVIP',
        badgeColor: const Color(0xFFE879F9),
        description: 'Artist meet · Premium zone · Backstage tour',
        price: 5500,
      ),
      ConcertTicket(
        name: 'VIP Pass',
        badge: '⭐ VIP',
        badgeColor: const Color(0xFFFBBF24),
        description: 'Seated section · Priority access',
        price: 2800,
      ),
      ConcertTicket(
        name: 'Normal',
        badge: '🎟 NORMAL',
        badgeColor: const Color(0xFFA5B4FC),
        description: 'Open grounds · Standard entry',
        price: 950,
      ),
    ],
  ),
];

// ─────────────────────────────────────────────────────────────────────────────
//  PALETTE
// ─────────────────────────────────────────────────────────────────────────────
const _bg = Color(0xFF0A0A0F);
const _surface = Color(0xFF13101E);
const _purple = Color(0xFF7C3AED);
const _purpleMid = Color(0xFFA78BFA);
const _purplePale = Color(0xFFC4B5FD);
const _textPri = Color(0xFFF0EEFF);
const _textSec = Color(0x99B4A0F0);
const _card = Color(0x0DFFFFFF);
const _div = Color(0x12FFFFFF);

// ══════════════════════════════════════════════════════════════════════════════
//  CONCERT LIST PAGE  (entry point — shown after login)
// ══════════════════════════════════════════════════════════════════════════════
class ConcertDetailsPage extends StatelessWidget {
  const ConcertDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      body: CustomScrollView(
        slivers: [
          // ── App bar ───────────────────────────────────────────────────────
          SliverAppBar(
            pinned: true,
            backgroundColor: _bg,
            expandedHeight: 130,
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_new,
                color: Colors.white70,
                size: 18,
              ),
              onPressed: () => Navigator.maybePop(context),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFF1A0533), _bg],
                  ),
                ),
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [_purple, Color(0xFFDB2777)],
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Text(
                            'LIVE',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 2,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Upcoming Concerts',
                          style: TextStyle(
                            color: _textPri,
                            fontSize: 24,
                            fontWeight: FontWeight.w900,
                            letterSpacing: -0.5,
                          ),
                        ),
                        const SizedBox(height: 14),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),

          // ── Concert cards ─────────────────────────────────────────────────
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, i) => _ConcertCard(concert: allConcerts[i]),
                childCount: allConcerts.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
//  CONCERT CARD (on the list page)
// ─────────────────────────────────────────────────────────────────────────────
class _ConcertCard extends StatelessWidget {
  final ConcertEvent concert;
  const _ConcertCard({required this.concert});

  @override
  Widget build(BuildContext context) {
    final lead = concert.artists.first;

    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => _ConcertDetailPage(concert: concert)),
      ),
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: _surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white.withOpacity(0.08)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Artist photo strip
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(20),
              ),
              child: SizedBox(
                height: 180,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    // photo
                    lead.imageAsset != null
                        ? Image.asset(lead.imageAsset!, fit: BoxFit.cover)
                        : lead.imageUrl != null
                        ? Image.network(
                            lead.imageUrl!,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => _fallback(lead),
                          )
                        : _fallback(lead),
                    // gradient
                    Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.transparent, Colors.black87],
                          stops: [0.3, 1.0],
                        ),
                      ),
                    ),
                    // artist count badge
                    if (concert.artists.length > 1)
                      Positioned(
                        top: 12,
                        right: 12,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.black54,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: _purpleMid.withOpacity(0.5),
                            ),
                          ),
                          child: Text(
                            '+${concert.artists.length - 1} more artists',
                            style: const TextStyle(
                              color: _purpleMid,
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    // bottom info
                    Positioned(
                      left: 14,
                      bottom: 12,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            lead.name,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          Text(
                            concert.tourName,
                            style: const TextStyle(
                              color: Color(0xCCC8B4FF),
                              fontSize: 11,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Details row
            Padding(
              padding: const EdgeInsets.all(14),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _chip(Icons.calendar_today_outlined, concert.date),
                        const SizedBox(height: 4),
                        _chip(Icons.location_on_outlined, concert.venueName),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text(
                        'FROM',
                        style: TextStyle(
                          color: _textSec,
                          fontSize: 9,
                          letterSpacing: 1,
                        ),
                      ),
                      Text(
                        'ETB ${concert.ticketsFactory().last.price}',
                        style: const TextStyle(
                          color: _purpleMid,
                          fontSize: 18,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Get tickets button
            Padding(
              padding: const EdgeInsets.fromLTRB(14, 0, 14, 14),
              child: GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => _ConcertDetailPage(concert: concert),
                  ),
                ),
                child: Container(
                  width: double.infinity,
                  height: 44,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [_purple, Color(0xFFA855F7)],
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Center(
                    child: Text(
                      'Get Tickets →',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _fallback(ConcertArtist a) => Container(
    decoration: BoxDecoration(
      gradient: LinearGradient(colors: [a.glowColor.withOpacity(0.3), _bg]),
    ),
    child: Icon(Icons.person_rounded, color: a.glowColor, size: 60),
  );

  Widget _chip(IconData icon, String label) => Row(
    children: [
      Icon(icon, size: 11, color: _textSec),
      const SizedBox(width: 4),
      Text(label, style: const TextStyle(color: _textSec, fontSize: 11)),
    ],
  );
}

// ══════════════════════════════════════════════════════════════════════════════
//  CONCERT DETAIL PAGE  (one per concert, receives data from list)
// ══════════════════════════════════════════════════════════════════════════════
class _ConcertDetailPage extends StatefulWidget {
  final ConcertEvent concert;
  const _ConcertDetailPage({required this.concert});
  @override
  State<_ConcertDetailPage> createState() => _ConcertDetailPageState();
}

class _ConcertDetailPageState extends State<_ConcertDetailPage>
    with TickerProviderStateMixin {
  // Each detail page gets its OWN fresh ticket list
  late final List<ConcertTicket> _tickets;

  // Selected ticket index (null = none selected)
  int? _selectedTierIndex;
  int _quantity = 1; // number of tickets to purchase

  late PageController _pageCtrl;
  int _currentArtist = 0;
  Timer? _carouselTimer;
  late Timer _countdownTimer;
  Duration _remaining = Duration.zero;
  bool _isFavorited = false;

  int get _unitPrice =>
      _selectedTierIndex != null ? _tickets[_selectedTierIndex!].price : 0;
  int get _selectedPrice => _unitPrice * _quantity;

  @override
  void initState() {
    super.initState();
    _tickets = widget.concert.ticketsFactory();
    _pageCtrl = PageController(viewportFraction: 0.82, initialPage: 1000);
    _carouselTimer = Timer.periodic(const Duration(seconds: 3), (_) {
      _pageCtrl.nextPage(
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOutCubic,
      );
    });
    _updateCountdown();
    _countdownTimer = Timer.periodic(
      const Duration(seconds: 1),
      (_) => _updateCountdown(),
    );
  }

  void _updateCountdown() {
    final now = DateTime.now();
    setState(() {
      _remaining = widget.concert.dateTime.isAfter(now)
          ? widget.concert.dateTime.difference(now)
          : Duration.zero;
    });
  }

  @override
  void dispose() {
    _carouselTimer?.cancel();
    _countdownTimer.cancel();
    _pageCtrl.dispose();
    super.dispose();
  }

  String _pad(int n) => n.toString().padLeft(2, '0');

  Future<void> _openMap() async {
    final uri = Uri.parse(
      'https://www.google.com/maps/search/?api=1&query=${widget.concert.venueLat},${widget.concert.venueLng}',
    );
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      if (mounted)
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Could not open Maps')));
    }
  }

  void _onSecureSeat() {
    if (_selectedTierIndex == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Please select a ticket type first'),
          backgroundColor: Colors.red.shade700,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      );
      return;
    }
    _showOrderSheet();
  }

  void _showOrderSheet() {
    final t = _tickets[_selectedTierIndex!];
    final total = t.price * _quantity;
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF13101E),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      isScrollControlled: true,
      builder: (_) => Padding(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 40),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Order Summary',
              style: TextStyle(
                color: _textPri,
                fontSize: 20,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              widget.concert.tourName,
              style: const TextStyle(color: _textSec, fontSize: 12),
            ),
            const SizedBox(height: 16),
            // Ticket type card
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.05),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: t.badgeColor.withOpacity(0.3)),
              ),
              child: Row(
                children: [
                  Text(
                    t.badge.split(' ').first,
                    style: const TextStyle(fontSize: 28),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          t.name,
                          style: const TextStyle(
                            color: _textPri,
                            fontWeight: FontWeight.w800,
                            fontSize: 15,
                          ),
                        ),
                        Text(
                          t.description,
                          style: const TextStyle(color: _textSec, fontSize: 11),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    'ETB ${t.price}',
                    style: TextStyle(
                      color: t.badgeColor,
                      fontWeight: FontWeight.w900,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            // Quantity breakdown
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.04),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Quantity',
                    style: TextStyle(color: _textSec, fontSize: 13),
                  ),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: _purple.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: _purpleMid.withOpacity(0.4),
                          ),
                        ),
                        child: Text(
                          '$_quantity ticket${_quantity > 1 ? 's' : ''}',
                          style: const TextStyle(
                            color: _purpleMid,
                            fontWeight: FontWeight.w700,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            // Price breakdown
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.04),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '$_quantity × ETB ${t.price}',
                        style: const TextStyle(color: _textSec, fontSize: 13),
                      ),
                      Text(
                        'ETB $total',
                        style: const TextStyle(color: _textPri, fontSize: 13),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Service fee',
                        style: TextStyle(color: _textSec, fontSize: 13),
                      ),
                      const Text(
                        'Free',
                        style: TextStyle(
                          color: Color(0xFF34D399),
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            const Divider(color: Colors.white12),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total',
                  style: TextStyle(
                    color: _textPri,
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
                Text(
                  'ETB $total',
                  style: const TextStyle(
                    color: _purpleMid,
                    fontWeight: FontWeight.w900,
                    fontSize: 24,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 52,
              child: _gradBtn(
                'Confirm & Pay  ETB $total',
                onTap: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        '🎉 $_quantity × ${t.name} confirmed! ETB $total',
                      ),
                      backgroundColor: _purple,
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              _buildHero(),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildBookRow(),
                      _divider(),
                      _buildTicketsSection(),
                      _divider(),
                      _buildVenueSection(),
                      _divider(),
                      _buildCountdown(),
                      const SizedBox(height: 110),
                    ],
                  ),
                ),
              ),
            ],
          ),
          _buildStickyCTA(),
        ],
      ),
    );
  }

  // ── HERO CAROUSEL ──────────────────────────────────────────────────────────
  Widget _buildHero() {
    final artists = widget.concert.artists;
    return SliverAppBar(
      expandedHeight: 420,
      pinned: true,
      backgroundColor: _bg,
      leading: const SizedBox.shrink(),
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF1A0533),
                    Color(0xFF0D1A3A),
                    Color(0xFF0A1520),
                  ],
                ),
              ),
            ),
            Column(
              children: [
                Expanded(
                  child: PageView.builder(
                    controller: _pageCtrl,
                    onPageChanged: (i) =>
                        setState(() => _currentArtist = i % artists.length),
                    itemBuilder: (_, index) {
                      final a = artists[index % artists.length];
                      final active = index % artists.length == _currentArtist;
                      return AnimatedScale(
                        scale: active ? 1.0 : 0.88,
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.easeOutCubic,
                        child: _artistCard(a, active),
                      );
                    },
                  ),
                ),
                // dots
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(artists.length, (i) {
                      final active = i == _currentArtist;
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.symmetric(horizontal: 3),
                        width: active ? 20 : 6,
                        height: 6,
                        decoration: BoxDecoration(
                          color: active ? _purpleMid : Colors.white24,
                          borderRadius: BorderRadius.circular(3),
                        ),
                      );
                    }),
                  ),
                ),
              ],
            ),
            // top bar
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _iconBtn(
                      Icons.arrow_back_ios_new,
                      () => Navigator.pop(context),
                    ),
                    Row(
                      children: [
                        _iconBtn(
                          _isFavorited ? Icons.favorite : Icons.favorite_border,
                          () => setState(() => _isFavorited = !_isFavorited),
                          color: _isFavorited
                              ? Colors.pinkAccent
                              : Colors.white,
                        ),
                        const SizedBox(width: 8),
                        _iconBtn(Icons.ios_share, () {}),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            // bottom overlay
            Positioned(
              bottom: 30,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.fromLTRB(16, 40, 16, 10),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [Color(0xF20A0A0F), Colors.transparent],
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.concert.tourName,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xCCC8B4FF),
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        _chip(
                          Icons.calendar_today_outlined,
                          widget.concert.date,
                        ),
                        const SizedBox(width: 14),
                        _chip(
                          Icons.location_on_outlined,
                          widget.concert.venueName,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _artistCard(ConcertArtist a, bool isActive) {
    Widget photo = a.imageAsset != null
        ? Image.asset(a.imageAsset!, fit: BoxFit.cover)
        : a.imageUrl != null
        ? Image.network(
            a.imageUrl!,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => _fallback(a),
          )
        : _fallback(a);

    return Container(
      margin: const EdgeInsets.fromLTRB(8, 60, 8, 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: isActive
            ? [
                BoxShadow(
                  color: a.glowColor.withOpacity(0.5),
                  blurRadius: 30,
                  spreadRadius: 4,
                ),
              ]
            : [],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          fit: StackFit.expand,
          children: [
            photo,
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Color(0xDD000000)],
                  stops: [0.4, 1.0],
                ),
              ),
            ),
            Positioned(
              left: 14,
              right: 14,
              bottom: 14,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 3,
                    ),
                    decoration: BoxDecoration(
                      color: a.glowColor.withOpacity(0.25),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: a.glowColor.withOpacity(0.5)),
                    ),
                    child: Text(
                      a.role,
                      style: TextStyle(
                        color: a.glowColor,
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    a.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),
            ),
            if (isActive)
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: a.glowColor.withOpacity(0.5),
                    width: 2,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _fallback(ConcertArtist a) => Container(
    decoration: BoxDecoration(
      gradient: LinearGradient(colors: [a.glowColor.withOpacity(0.3), _bg]),
    ),
    child: Icon(Icons.person_rounded, color: a.glowColor, size: 80),
  );

  // ── BOOK ROW ───────────────────────────────────────────────────────────────
  Widget _buildBookRow() => Padding(
    padding: const EdgeInsets.symmetric(vertical: 14),
    child: Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'STARTING FROM',
                style: TextStyle(
                  fontSize: 10,
                  color: _textSec,
                  letterSpacing: 0.8,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                'ETB ${_tickets.last.price}',
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: _purpleMid,
                ),
              ),
            ],
          ),
        ),
        _gradBtn('Book Now', onTap: _onSecureSeat, width: 160, height: 46),
      ],
    ),
  );

  // ── TICKETS — tap to select + quantity stepper ────────────────────────────
  Widget _buildTicketsSection() => Padding(
    padding: const EdgeInsets.symmetric(vertical: 16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _secHeader('🎟  Choose Your Ticket'),
        const SizedBox(height: 12),
        ..._tickets.asMap().entries.map((e) => _ticketCard(e.value, e.key)),
        // ── Quantity stepper — appears once a tier is selected ──────────────
        if (_selectedTierIndex != null) ...[
          const SizedBox(height: 4),
          _buildQuantityStepper(),
        ],
      ],
    ),
  );

  Widget _ticketCard(ConcertTicket t, int index) {
    final isSelected = _selectedTierIndex == index;
    return GestureDetector(
      onTap: () => setState(() {
        _selectedTierIndex = index;
        _quantity = 1; // reset quantity when switching tier
      }),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: isSelected ? _purple.withOpacity(0.15) : _card,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? t.badgeColor : Colors.white.withOpacity(0.1),
            width: isSelected ? 1.8 : 1,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: t.badgeColor.withOpacity(0.2),
                    blurRadius: 16,
                  ),
                ]
              : [],
        ),
        child: Row(
          children: [
            // Selection indicator circle
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected ? t.badgeColor : Colors.transparent,
                border: Border.all(
                  color: isSelected ? t.badgeColor : Colors.white30,
                  width: 2,
                ),
              ),
              child: isSelected
                  ? const Icon(
                      Icons.check_rounded,
                      color: Colors.black,
                      size: 14,
                    )
                  : null,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        t.name,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: isSelected
                              ? _textPri
                              : _textPri.withOpacity(0.8),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 7,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: t.badgeColor.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          t.badge,
                          style: TextStyle(
                            fontSize: 9,
                            fontWeight: FontWeight.w700,
                            color: t.badgeColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 3),
                  Text(
                    t.description,
                    style: const TextStyle(fontSize: 11, color: _textSec),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            Text(
              'ETB ${t.price}',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w900,
                color: isSelected ? t.badgeColor : _textPri,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuantityStepper() {
    final t = _tickets[_selectedTierIndex!];
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: t.badgeColor.withOpacity(0.08),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: t.badgeColor.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'How many tickets?',
                    style: TextStyle(
                      color: _textPri,
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Max 10 per order',
                    style: TextStyle(color: _textSec, fontSize: 11),
                  ),
                ],
              ),
              // ── Stepper buttons ──────────────────────
              Row(
                children: [
                  // Minus
                  GestureDetector(
                    onTap: () {
                      if (_quantity > 1) setState(() => _quantity--);
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 150),
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _quantity > 1
                            ? t.badgeColor.withOpacity(0.2)
                            : Colors.white.withOpacity(0.05),
                        border: Border.all(
                          color: _quantity > 1
                              ? t.badgeColor.withOpacity(0.6)
                              : Colors.white12,
                        ),
                      ),
                      child: Icon(
                        Icons.remove_rounded,
                        color: _quantity > 1 ? t.badgeColor : Colors.white24,
                        size: 18,
                      ),
                    ),
                  ),
                  // Count display
                  Container(
                    width: 52,
                    child: Text(
                      '$_quantity',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: _textPri,
                        fontSize: 22,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  // Plus
                  GestureDetector(
                    onTap: () {
                      if (_quantity < 10) setState(() => _quantity++);
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 150),
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _quantity < 10
                            ? t.badgeColor.withOpacity(0.2)
                            : Colors.white.withOpacity(0.05),
                        border: Border.all(
                          color: _quantity < 10
                              ? t.badgeColor.withOpacity(0.6)
                              : Colors.white12,
                        ),
                      ),
                      child: Icon(
                        Icons.add_rounded,
                        color: _quantity < 10 ? t.badgeColor : Colors.white24,
                        size: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Subtotal row
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.black26,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '$_quantity × ETB ${t.price}',
                  style: const TextStyle(color: _textSec, fontSize: 13),
                ),
                Text(
                  'ETB $_selectedPrice',
                  style: TextStyle(
                    color: t.badgeColor,
                    fontSize: 17,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ── VENUE ──────────────────────────────────────────────────────────────────
  Widget _buildVenueSection() => Padding(
    padding: const EdgeInsets.symmetric(vertical: 16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _secHeader('📍  Venue & Location'),
        const SizedBox(height: 12),
        GestureDetector(
          onTap: _openMap,
          child: Container(
            height: 130,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              gradient: const LinearGradient(
                colors: [Color(0xFF0F1F3A), Color(0xFF0A1520)],
              ),
              border: Border.all(color: Colors.white.withOpacity(0.08)),
            ),
            child: Stack(
              children: [
                CustomPaint(painter: _MapGridPainter(), size: Size.infinite),
                const Center(child: _MapPin()),
                Positioned(
                  top: 10,
                  right: 10,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: _purpleMid.withOpacity(0.4)),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.open_in_new_rounded,
                          color: _purpleMid,
                          size: 12,
                        ),
                        SizedBox(width: 4),
                        Text(
                          'Tap to open Maps',
                          style: TextStyle(
                            color: _purpleMid,
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.concert.venueName,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFFE0D8FF),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    widget.concert.venueAddress,
                    style: const TextStyle(fontSize: 11, color: _textSec),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            GestureDetector(
              onTap: _openMap,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 7,
                ),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [_purple, Color(0xFFA855F7)],
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.map_outlined, color: Colors.white, size: 13),
                    SizedBox(width: 5),
                    Text(
                      'View Map',
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );

  // ── COUNTDOWN ──────────────────────────────────────────────────────────────
  // ════════════════════════════════════════════════════════════════
  //  TO CHANGE THE COUNTDOWN DATE:
  //  Go to allConcerts list at the top of this file.
  //  Find the concert you want and change its `dateTime:` field.
  //  Example:
  //    dateTime: DateTime(2025, 12, 31, 20, 0),  // Dec 31 2025 at 8PM
  // ════════════════════════════════════════════════════════════════
  Widget _buildCountdown() {
    final days = _remaining.inDays;
    final hours = _remaining.inHours.remainder(24);
    final mins = _remaining.inMinutes.remainder(60);
    final secs = _remaining.inSeconds.remainder(60);
    final ended = _remaining == Duration.zero;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _secHeader('⏳  Concert Starts In'),
          const SizedBox(height: 12),
          if (ended)
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: _purple.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: _purpleMid.withOpacity(0.3)),
              ),
              child: const Center(
                child: Text(
                  '🎉 The show has started!',
                  style: TextStyle(
                    color: _purpleMid,
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
              ),
            )
          else
            Row(
              children: [
                _countBlock(_pad(days), 'DAYS'),
                const SizedBox(width: 6),
                Text(
                  ':',
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w900,
                    color: _purpleMid,
                  ),
                ),
                const SizedBox(width: 6),
                _countBlock(_pad(hours), 'HRS'),
                const SizedBox(width: 6),
                Text(
                  ':',
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w900,
                    color: _purpleMid,
                  ),
                ),
                const SizedBox(width: 6),
                _countBlock(_pad(mins), 'MIN'),
                const SizedBox(width: 6),
                Text(
                  ':',
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w900,
                    color: _purpleMid,
                  ),
                ),
                const SizedBox(width: 6),
                _countBlock(_pad(secs), 'SEC'),
              ],
            ),
        ],
      ),
    );
  }

  Widget _countBlock(String value, String label) => Expanded(
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: _purple.withOpacity(0.15),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _purpleMid.withOpacity(0.25)),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w900,
              color: _purplePale,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(
              fontSize: 9,
              color: _textSec,
              letterSpacing: 1,
            ),
          ),
        ],
      ),
    ),
  );

  // ── STICKY CTA ─────────────────────────────────────────────────────────────
  Widget _buildStickyCTA() => Positioned(
    bottom: 0,
    left: 0,
    right: 0,
    child: Container(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [Color(0xFF0A0A0F), Colors.transparent],
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (_selectedTierIndex != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: _purple.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: _purpleMid.withOpacity(0.3)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          _tickets[_selectedTierIndex!].badge.split(' ').first,
                          style: const TextStyle(fontSize: 16),
                        ),
                        const SizedBox(width: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _tickets[_selectedTierIndex!].name,
                              style: const TextStyle(
                                color: _textPri,
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              '$_quantity ticket${_quantity > 1 ? 's' : ''}',
                              style: const TextStyle(
                                color: _textSec,
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Text(
                      'ETB $_selectedPrice',
                      style: const TextStyle(
                        color: _purpleMid,
                        fontWeight: FontWeight.w900,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          _gradBtn('🎟  Secure Your Seat', onTap: _onSecureSeat),
          const SizedBox(height: 6),
          const Text(
            'Fast checkout · Instant e-ticket delivery',
            style: TextStyle(fontSize: 11, color: Color(0x80B4A0F0)),
          ),
        ],
      ),
    ),
  );

  // ── HELPERS ────────────────────────────────────────────────────────────────
  Widget _gradBtn(
    String label, {
    required VoidCallback onTap,
    double width = double.infinity,
    double height = 52,
  }) => GestureDetector(
    onTap: onTap,
    child: Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [_purple, Color(0xFFA855F7)]),
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: _purple.withOpacity(0.4),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Center(
        child: Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
    ),
  );

  Widget _iconBtn(
    IconData icon,
    VoidCallback onTap, {
    Color color = Colors.white,
  }) => GestureDetector(
    onTap: onTap,
    child: Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white.withOpacity(0.12),
      ),
      child: Icon(icon, color: color, size: 17),
    ),
  );

  Widget _chip(IconData icon, String label) => Row(
    children: [
      Icon(icon, size: 12, color: const Color(0xBFC8B4FF)),
      const SizedBox(width: 4),
      Text(
        label,
        style: const TextStyle(fontSize: 12, color: Color(0xBFC8B4FF)),
      ),
    ],
  );

  Widget _secHeader(String title) => Text(
    title,
    style: const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w700,
      color: _textPri,
    ),
  );

  Widget _divider() => const Divider(color: _div, thickness: 0.5, height: 0);
}

// ─────────────────────────────────────────────────────────────────────────────
//  MAP HELPERS
// ─────────────────────────────────────────────────────────────────────────────
class _MapGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final g = Paint()
      ..color = const Color(0x146478C8)
      ..strokeWidth = 1;
    for (double x = 0; x < size.width; x += 24)
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), g);
    for (double y = 0; y < size.height; y += 24)
      canvas.drawLine(Offset(0, y), Offset(size.width, y), g);
    final r = Paint()
      ..color = const Color(0x222A3070)
      ..strokeWidth = 8;
    canvas.drawLine(
      Offset(0, size.height / 2),
      Offset(size.width, size.height / 2),
      r,
    );
    canvas.drawLine(
      Offset(size.width / 2, 0),
      Offset(size.width / 2, size.height),
      r,
    );
  }

  @override
  bool shouldRepaint(_) => false;
}

class _MapPin extends StatelessWidget {
  const _MapPin();
  @override
  Widget build(BuildContext context) => Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: _purple,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: _purple.withOpacity(0.5),
              blurRadius: 12,
              spreadRadius: 4,
            ),
          ],
        ),
        child: const Icon(
          Icons.location_on_rounded,
          color: Colors.white,
          size: 18,
        ),
      ),
      Container(width: 2, height: 10, color: _purple),
      Container(
        width: 10,
        height: 4,
        decoration: BoxDecoration(
          color: _purple.withOpacity(0.3),
          borderRadius: BorderRadius.circular(4),
        ),
      ),
    ],
  );
}
