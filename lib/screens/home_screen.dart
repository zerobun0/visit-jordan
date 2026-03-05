import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../services/gemini_service.dart';
import 'attractions_screen.dart';
import 'ai_assistant_screen.dart';
import 'api_key_screen.dart';
import 'quiz_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _openAiAssistant(BuildContext context) {
    if (geminiService.isInitialised) {
      Navigator.push(context, MaterialPageRoute(builder: (_) => const AiAssistantScreen()));
    } else {
      Navigator.push(context, MaterialPageRoute(builder: (_) => const ApiKeyScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF8F0),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 280,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                'Visit Jordan 🇯🇴',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  color: Colors.white,
                  shadows: [const Shadow(color: Colors.black45, blurRadius: 8)],
                ),
              ),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color(0xFF8B4513),
                          Color(0xFFD4A843),
                          Color(0xFFC1440E),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 50,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Text(
                        '🏛️  🏜️  🌊  🌿',
                        style: TextStyle(fontSize: 40),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome to Jordan',
                    style: GoogleFonts.poppins(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF8B4513),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Discover the wonders of the Hashemite Kingdom — '
                    'from ancient cities carved in rock to vast desert landscapes '
                    'and the lowest point on Earth.',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Colors.grey[700],
                      height: 1.6,
                    ),
                  ),
                  const SizedBox(height: 28),
                  _buildSectionTitle('Explore'),
                  const SizedBox(height: 14),
                  _buildMainCard(
                    context,
                    icon: '🏛️',
                    title: 'Tourist Attractions',
                    subtitle: 'Petra, Wadi Rum, Dead Sea & more',
                    gradient: const LinearGradient(
                      colors: [Color(0xFF8B4513), Color(0xFFC1440E)],
                    ),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const AttractionsScreen()),
                    ),
                  ),
                  const SizedBox(height: 14),
                  _buildMainCard(
                    context,
                    icon: '🤖',
                    title: 'AI Travel Assistant',
                    subtitle: 'Get personalised recommendations',
                    gradient: const LinearGradient(
                      colors: [Color(0xFF1A6B3C), Color(0xFF2EAD6B)],
                    ),
                    onTap: () => _openAiAssistant(context),
                  ),
                  const SizedBox(height: 14),
                  _buildMainCard(
                    context,
                    icon: '🧠',
                    title: 'Jordan Quiz',
                    subtitle: 'Test your knowledge about Jordan',
                    gradient: const LinearGradient(
                      colors: [Color(0xFF1A3A6B), Color(0xFF2E6EAD)],
                    ),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const QuizScreen()),
                    ),
                  ),
                  const SizedBox(height: 28),
                  _buildSectionTitle('Quick Facts'),
                  const SizedBox(height: 14),
                  _buildFactsGrid(),
                  const SizedBox(height: 28),
                  _buildSectionTitle('Why Visit Jordan?'),
                  const SizedBox(height: 14),
                  _buildWhyVisitList(),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: GoogleFonts.poppins(
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: const Color(0xFF8B4513),
      ),
    );
  }

  Widget _buildMainCard(
    BuildContext context, {
    required String icon,
    required String title,
    required String subtitle,
    required Gradient gradient,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(22),
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 12,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          children: [
            Text(icon, style: const TextStyle(fontSize: 40)),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios, color: Colors.white70, size: 18),
          ],
        ),
      ),
    );
  }

  Widget _buildFactsGrid() {
    final facts = [
      {'emoji': '🌍', 'label': 'Capital', 'value': 'Amman'},
      {'emoji': '👥', 'label': 'Population', 'value': '10M+'},
      {'emoji': '🗣️', 'label': 'Language', 'value': 'Arabic'},
      {'emoji': '💰', 'label': 'Currency', 'value': 'Dinar (JOD)'},
      {'emoji': '📍', 'label': 'Wonders', 'value': 'Petra'},
      {'emoji': '🌡️', 'label': 'Climate', 'value': 'Mediterranean'},
    ];

    return GridView.count(
      crossAxisCount: 3,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      childAspectRatio: 1.1,
      children: facts
          .map(
            (f) => Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.07),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(f['emoji']!, style: const TextStyle(fontSize: 24)),
                  const SizedBox(height: 4),
                  Text(
                    f['value']!,
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF8B4513),
                    ),
                  ),
                  Text(
                    f['label']!,
                    style: GoogleFonts.poppins(
                      fontSize: 10,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          )
          .toList(),
    );
  }

  Widget _buildWhyVisitList() {
    final reasons = [
      {'icon': '🏆', 'text': 'Home to a New Wonder of the World — Petra'},
      {'icon': '🌊', 'text': 'Float on the Dead Sea, the lowest point on Earth'},
      {'icon': '🏜️', 'text': 'Experience a breathtaking desert in Wadi Rum'},
      {'icon': '🏛️', 'text': 'Walk through one of the best-preserved Roman cities'},
      {'icon': '🍽️', 'text': 'Enjoy delicious Jordanian cuisine and hospitality'},
      {'icon': '✅', 'text': 'Safe, welcoming, and easy to travel around'},
    ];

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.07),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: reasons
            .map(
              (r) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: Row(
                  children: [
                    Text(r['icon']!, style: const TextStyle(fontSize: 20)),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        r['text']!,
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          color: Colors.grey[800],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
