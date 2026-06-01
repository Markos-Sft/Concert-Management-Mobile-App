// ─────────────────────────────────────────
//  models/concert_model.dart
// ─────────────────────────────────────────

class TicketTier {
  final String type;
  final double price;
  final String perks;
  final String emoji;

  TicketTier({
    required this.type,
    required this.price,
    required this.perks,
    required this.emoji,
  });
}

class Artist {
  final String name;
  final String imageAsset;

  final String genre;

  Artist({required this.name, required this.imageAsset, required this.genre});
}

class Concert {
  final String id;
  final String name;
  final String bannerimageAsset;
  final String date;
  final String venue;
  final String city;
  final double latitude;
  final double longitude;
  final DateTime concertDateTime;
  final List<Artist> artists;
  final List<TicketTier> tiers;

  Concert({
    required this.id,
    required this.name,
    required this.bannerimageAsset,
    required this.date,
    required this.venue,
    required this.city,
    required this.latitude,
    required this.longitude,
    required this.artists,
    required this.tiers,
    required this.concertDateTime,
  });
}

final List<Concert> sampleConcerts = [
  Concert(
    id: 'c1',
    name: 'Etorika Concert',
    bannerimageAsset: 'assets/img/banners/concert 1.png',

    date: 'Sat, 13 Jul 2025 · 8:00 PM',
    venue: 'Millennium Hall',
    city: 'Addis Abeba,Ethipia',
    latitude: 8.9806,
    longitude: 38.7578,
    concertDateTime: DateTime(2026, 06, 13, 8, 00),
    artists: [
      Artist(
        name: 'Tedy Afro',
        imageAsset: 'assets/img/tedy 1.jpg',
        genre: 'Reggae & Reggae Fusion',
      ),
    ],
    tiers: [
      TicketTier(
        type: 'VVIP',
        price: 10000,
        perks:
            "Backstage Access • Meet & Greet • Luxury Seating • Exclusive Merch",
        emoji: '👑',
      ),
      TicketTier(
        type: 'VIP',
        price: 5000,
        perks: "Fast Entry • Front Row Access • VIP Lounge • Free Drink",
        emoji: '⭐',
      ),
      TicketTier(
        type: 'Normal',
        price: 2000,
        perks: "General Entry • Standard Viewing ",
        emoji: '🎫',
      ),
    ],
  ),
  Concert(
    id: 'c2',
    name: 'The Unity Wave Concert',
    bannerimageAsset: 'assets/img/banners/concert 2.png',
    date: 'Sun, 20 Jun 2026 · 6:00 PM',
    venue: 'Addis International Convention Center',
    city: 'Addis Abeba',
    latitude: 9.0057,
    longitude: 38.7638,
    concertDateTime: DateTime(2026, 06, 20, 06, 00),
    artists: [
      Artist(
        name: 'Rophnan',
        imageAsset: 'assets/img/Rophnan.jpg',

        genre: 'Electronic music',
      ),
      Artist(
        name: 'Zerubabbel Molla',
        imageAsset: 'assets/img/Zerubabbel.jpg',
        genre: "Blues • Ethiopian Pop • Reggae",
      ),
      Artist(
        name: 'Yohana',
        imageAsset: 'assets/img/Yohana.jpg',
        genre: "Blues • Ethiopian Pop • Reggae",
      ),
    ],
    tiers: [
      TicketTier(
        type: 'VVIP',
        price: 7000,
        perks:
            "Backstage Access • Meet & Greet • Luxury Seating • Exclusive Merch",
        emoji: '👑',
      ),
      TicketTier(
        type: 'VIP',
        price: 4500,
        perks: "Fast Entry • Front Row Access • VIP Lounge • Free Drink",
        emoji: '⭐',
      ),
      TicketTier(
        type: 'Normal',
        price: 1000,
        perks: "General Entry • Standard Viewing ",
        emoji: '🎫',
      ),
    ],
  ),
  Concert(
    id: 'c3',
    name: 'Echoes of Addis',
    bannerimageAsset: 'assets/img/banners/concert 3.png',
    date: 'Sun, 27 Jun 2026 · 9:00 PM',
    venue: 'Adwa Victory Memorial Hall',
    city: 'Addis Abeba',
    latitude: 9.0337,
    longitude: 38.7519,
    concertDateTime: DateTime(2026, 06, 27, 9, 00),
    artists: [
      Artist(
        name: 'Dawit Tsige',
        imageAsset: 'assets/img/Dawit.jpg',
        genre: "Ethiopian Pop • Soul • Jazz Fusion",
      ),
      Artist(
        name: 'Betty G',
        imageAsset: 'assets/img/Betty.jpg',
        genre: "Afro-Pop • Soul • Ethiopian Fusion",
      ),
      Artist(
        name: 'Sami Dan',
        imageAsset: 'assets/img/Sami.jpg',
        genre: "Ethiopian Pop • Afrobeat",
      ),
    ],
    tiers: [
      TicketTier(
        type: 'VVIP',
        price: 9000,
        perks:
            "Backstage Access • Meet & Greet • Luxury Seating • Exclusive Merch",
        emoji: '👑',
      ),
      TicketTier(
        type: 'VIP',
        price: 5000,
        perks: "Fast Entry • Front Row Access • VIP Lounge • Free Drink",
        emoji: '⭐',
      ),
      TicketTier(
        type: 'Normal',
        price: 2000,
        perks: "General Entry • Standard Viewing ",
        emoji: '🎫',
      ),
    ],
  ),
];
