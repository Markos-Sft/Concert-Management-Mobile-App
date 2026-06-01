// ─────────────────────────────────────────
//  screens/concert.dart  –  Concert listing
// ─────────────────────────────────────────
import 'dart:async';
import 'package:flutter/material.dart';
import '../model/concert_model.dart';
import 'ticket_detail.dart';

class ConcertScreen extends StatelessWidget {
  const ConcertScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1023),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // ── App bar ───────────────────────────────────────────────────
          SliverAppBar(
            expandedHeight: 130,
            floating: false,
            pinned: true,
            backgroundColor: const Color(0xFF1A1023),
            elevation: 0,
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_new_rounded,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFF1A1023), Color(0xFF2A1240)],
                  ),
                ),
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFFEE33E1),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: const Text(
                                'GIGGO',
                                style: TextStyle(
                                  color: Color(0xFF0A0A0F),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w900,
                                  letterSpacing: 2,
                                ),
                              ),
                            ),
                            const Spacer(),
                            const Icon(
                              Icons.notifications_none_rounded,
                              color: Color(0xFFD8B4FF),
                            ),
                          ],
                        ),
                        const SizedBox(height: 14),
                        const Text(
                          'Upcoming\nConcerts 🎵',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 26,
                            fontWeight: FontWeight.w900,
                            height: 1.2,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),

          // ── Concert cards ─────────────────────────────────────────────
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 40),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => _ConcertCard(
                  concert: sampleConcerts[index],
                  concertNumber: index + 1,
                ),
                childCount: sampleConcerts.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Single concert card ──────────────────────────────────────────────────────

class _ConcertCard extends StatelessWidget {
  final Concert concert;
  final int concertNumber;

  const _ConcertCard({required this.concert, required this.concertNumber});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      decoration: BoxDecoration(
        color: const Color(0xFF241235),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: const Color(0xFF4B256B), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.4),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Concert number + label ─────────────────────────────────
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 8),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFFEE33E1), Color(0xFF9C27B0)],
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'CONCERT $concertNumber',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1.5,
                    ),
                  ),
                ),
                const Spacer(),
                Text(
                  'From ETB ${concert.tiers.last.price.toStringAsFixed(0)}',
                  style: const TextStyle(
                    color: Color(0xFFEE33E1),
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),

          // ── Banner image ───────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: _ArtistImageSlider(concert: concert),
              ),
            ),
          ),

          // ── Date / venue info ──────────────────────────────────────
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _InfoRow(
                  icon: Icons.calendar_today_rounded,
                  text: concert.date,
                ),
                const SizedBox(height: 6),
                _InfoRow(
                  icon: Icons.location_on_rounded,
                  text: '${concert.venue} · ${concert.city}',
                ),
                const SizedBox(height: 6),
                _InfoRow(
                  icon: Icons.people_rounded,
                  text:
                      '${concert.artists.length} Artist${concert.artists.length > 1 ? 's' : ''} Performing',
                ),
              ],
            ),
          ),

          // ── GET TICKET button ──────────────────────────────────────
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 16, 14, 14),
            child: SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFEE33E1),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  elevation: 0,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => TicketDetailScreen(concert: concert),
                    ),
                  );
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.confirmation_number_rounded, size: 20),
                    SizedBox(width: 10),
                    Text(
                      'GET TICKET',
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        letterSpacing: 2.5,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String text;
  const _InfoRow({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 14, color: const Color(0xFFE8FF47)),
        const SizedBox(width: 7),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(color: Color(0xFFB0B0C0), fontSize: 13),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

class _ArtistImageSlider extends StatefulWidget {
  final Concert concert;

  const _ArtistImageSlider({required this.concert});

  @override
  State<_ArtistImageSlider> createState() => _ArtistImageSliderState();
}

class _ArtistImageSliderState extends State<_ArtistImageSlider> {
  late final PageController _controller;
  int currentPage = 0;
  Timer? timer;

  @override
  void initState() {
    super.initState();

    _controller = PageController();

    timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (!mounted) return;

      currentPage++;

      if (currentPage >= widget.concert.artists.length) {
        currentPage = 0;
      }

      _controller.animateToPage(
        currentPage,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PageView.builder(
          controller: _controller,
          itemCount: widget.concert.artists.length,
          itemBuilder: (context, index) {
            final artist = widget.concert.artists[index];

            return Stack(
              fit: StackFit.expand,
              children: [
                Image.asset(artist.imageAsset, fit: BoxFit.cover),

                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        const Color(0xFF1A1023).withValues(alpha: 0.85),
                      ],
                    ),
                  ),
                ),

                Positioned(
                  bottom: 14,
                  left: 14,
                  child: Text(
                    artist.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}
