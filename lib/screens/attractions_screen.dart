import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../data/attractions_data.dart';
import '../models/attraction.dart';
import 'attraction_detail_screen.dart';

class AttractionsScreen extends StatelessWidget {
  const AttractionsScreen({super.key});

  static const Map<String, String> _emojis = {
    'petra': '🏛️',
    'wadi_rum': '🏜️',
    'dead_sea': '🌊',
    'jerash': '🏟️',
  };

  static const Map<String, List<Color>> _colors = {
    'petra': [Color(0xFF8B4513), Color(0xFFC1440E)],
    'wadi_rum': [Color(0xFFB8860B), Color(0xFFD4A843)],
    'dead_sea': [Color(0xFF1A6B8A), Color(0xFF2EAAD4)],
    'jerash': [Color(0xFF4A6741), Color(0xFF6DAE6A)],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF8F0),
      appBar: AppBar(
        title: Text('Tourist Attractions', style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFF8B4513),
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: attractionsData.length,
        itemBuilder: (context, index) {
          final attraction = attractionsData[index];
          return _AttractionCard(
            attraction: attraction,
            emoji: _emojis[attraction.imageUrl] ?? '📍',
            colors: _colors[attraction.imageUrl] ?? [Colors.brown, Colors.orange],
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => AttractionDetailScreen(attraction: attraction),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _AttractionCard extends StatelessWidget {
  final Attraction attraction;
  final String emoji;
  final List<Color> colors;
  final VoidCallback onTap;

  const _AttractionCard({
    required this.attraction,
    required this.emoji,
    required this.colors,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header banner
            Container(
              height: 130,
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: colors),
                borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: Center(
                child: Text(emoji, style: const TextStyle(fontSize: 64)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    attraction.name,
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF8B4513),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.location_on, size: 14, color: Colors.grey),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          attraction.location,
                          style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    attraction.description,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(fontSize: 13, color: Colors.grey[700], height: 1.5),
                  ),
                  const SizedBox(height: 12),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(colors: colors),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        'Explore →',
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                        ),
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
}
