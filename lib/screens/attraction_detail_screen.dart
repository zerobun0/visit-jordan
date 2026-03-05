import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/attraction.dart';
import '../models/review.dart';

class AttractionDetailScreen extends StatefulWidget {
  final Attraction attraction;
  const AttractionDetailScreen({super.key, required this.attraction});

  @override
  State<AttractionDetailScreen> createState() => _AttractionDetailScreenState();
}

class _AttractionDetailScreenState extends State<AttractionDetailScreen> {
  int _currentImageIndex = 0;
  final PageController _pageController = PageController();

  // Pre-loaded sample reviews per attraction
  static final Map<String, List<Review>> _sampleReviews = {
    '1': [
      Review(name: 'Sarah M.', rating: 5, date: 'Jan 2026', comment: 'Absolutely breathtaking! The Treasury at sunrise is something I will never forget. A must-visit in a lifetime!'),
      Review(name: 'James T.', rating: 5, date: 'Dec 2025', comment: 'One of the most incredible places on earth. The hike to the Monastery is tough but 100% worth it.'),
      Review(name: 'Layla K.', rating: 4, date: 'Nov 2025', comment: 'Stunning ancient city. Get there early to beat the crowds. Bring lots of water!'),
      Review(name: 'Omar R.', rating: 5, date: 'Oct 2025', comment: 'Petra by Night is magical — thousands of candles lighting the Siq. Book it!'),
    ],
    '2': [
      Review(name: 'Emily W.', rating: 5, date: 'Feb 2026', comment: 'Sleeping under the stars in Wadi Rum was the highlight of my entire trip to Jordan. Pure magic.'),
      Review(name: 'Hassan A.', rating: 5, date: 'Jan 2026', comment: 'The landscape looks like Mars. Jeep tour with a local Bedouin guide was absolutely epic.'),
      Review(name: 'Nina P.', rating: 4, date: 'Dec 2025', comment: 'Hot air balloon ride at sunrise over the red desert — nothing compares to this experience!'),
      Review(name: 'Carlos B.', rating: 5, date: 'Nov 2025', comment: 'Best glamping experience of my life. The silence of the desert at night is incredible.'),
    ],
    '3': [
      Review(name: 'Anna S.', rating: 5, date: 'Feb 2026', comment: 'Floating in the Dead Sea is surreal — you literally cannot sink! The mud is amazing for skin.'),
      Review(name: 'David L.', rating: 4, date: 'Jan 2026', comment: 'Unique experience being at the lowest point on earth. The mineral mud left my skin so smooth!'),
      Review(name: 'Fatima H.', rating: 5, date: 'Dec 2025', comment: 'The views across the water at sunset are spectacular. Stay at a resort for the full experience.'),
      Review(name: 'Tom G.', rating: 4, date: 'Nov 2025', comment: 'Amazing natural wonder. The salt crystals on the shore look like snow. Very photogenic!'),
    ],
    '4': [
      Review(name: 'Maria C.', rating: 5, date: 'Feb 2026', comment: 'Better preserved than Rome! Walking the colonnaded street feels like time travel back 2000 years.'),
      Review(name: 'Khalid N.', rating: 5, date: 'Jan 2026', comment: 'Underrated gem. Far fewer tourists than Petra but equally impressive ancient ruins.'),
      Review(name: 'Sophie R.', rating: 4, date: 'Dec 2025', comment: 'The oval plaza and the theatres are stunning. Hire a local guide — the history is fascinating.'),
      Review(name: 'Ahmed F.', rating: 5, date: 'Nov 2025', comment: 'The Jerash Festival of Culture and Arts here is incredible if you visit in summer!'),
    ],
  };

  late List<Review> _reviews;
  double _userRating = 0;
  final TextEditingController _reviewController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  static const Map<String, List<Color>> _colors = {
    'petra': [Color(0xFF8B4513), Color(0xFFC1440E)],
    'wadi_rum': [Color(0xFFB8860B), Color(0xFFD4A843)],
    'dead_sea': [Color(0xFF1A6B8A), Color(0xFF2EAAD4)],
    'jerash': [Color(0xFF4A6741), Color(0xFF6DAE6A)],
  };

  @override
  void initState() {
    super.initState();
    _reviews = List<Review>.from(
      _sampleReviews[widget.attraction.id] ?? [],
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    _reviewController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _openInGoogleMaps(double lat, double lng, String name) async {
    final googleMapsApp = Uri.parse('geo:$lat,$lng?q=$lat,$lng($name)');
    final googleMapsBrowser = Uri.parse('https://www.google.com/maps/search/?api=1&query=$lat,$lng');
    if (await canLaunchUrl(googleMapsApp)) {
      await launchUrl(googleMapsApp);
    } else {
      await launchUrl(googleMapsBrowser, mode: LaunchMode.externalApplication);
    }
  }

  double get _averageRating {
    if (_reviews.isEmpty) return 0;
    return _reviews.map((r) => r.rating).reduce((a, b) => a + b) / _reviews.length;
  }

  void _submitReview() {
    if (_userRating == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please select a star rating!', style: GoogleFonts.poppins()),
          backgroundColor: Colors.red[400],
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );
      return;
    }
    if (_reviewController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please write a review!', style: GoogleFonts.poppins()),
          backgroundColor: Colors.red[400],
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );
      return;
    }
    final name = _nameController.text.trim().isEmpty ? 'Anonymous' : _nameController.text.trim();
    setState(() {
      _reviews.insert(
        0,
        Review(
          name: name,
          rating: _userRating,
          comment: _reviewController.text.trim(),
          date: 'Just now',
          isUserReview: true,
        ),
      );
      _userRating = 0;
      _reviewController.clear();
      _nameController.clear();
    });
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Review added! Thank you 🙏', style: GoogleFonts.poppins()),
        backgroundColor: const Color(0xFF1A6B3C),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  // ── Edit & Delete ────────────────────────────────────────────────────

  void _deleteReview(Review review, List<Color> colors) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text('Delete Review', style: GoogleFonts.poppins(fontWeight: FontWeight.bold, color: colors[0])),
        content: Text('Are you sure you want to delete your review?',
            style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey[700])),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel', style: GoogleFonts.poppins(color: Colors.grey[600])),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() => _reviews.remove(review));
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Review deleted.', style: GoogleFonts.poppins()),
                  backgroundColor: Colors.red[400],
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red[400],
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
            child: Text('Delete', style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }

  void _showEditReviewSheet(Review review, List<Color> colors) {
    // Pre-fill controllers with existing values
    _nameController.text = review.name;
    _reviewController.text = review.comment;
    _userRating = review.rating;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => StatefulBuilder(
        builder: (ctx, setSheetState) => Container(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom + 20,
            top: 20,
            left: 20,
            right: 20,
          ),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40, height: 4,
                  decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(2)),
                ),
              ),
              const SizedBox(height: 16),
              Text('Edit Your Review',
                  style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold, color: colors[0])),
              const SizedBox(height: 16),
              // Name field
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  hintText: 'Your name (optional)',
                  hintStyle: GoogleFonts.poppins(color: Colors.grey[400], fontSize: 13),
                  filled: true,
                  fillColor: const Color(0xFFF0F4F8),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
                style: GoogleFonts.poppins(fontSize: 14),
              ),
              const SizedBox(height: 12),
              // Star rating
              Text('Your Rating',
                  style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.grey[700])),
              const SizedBox(height: 8),
              Row(
                children: List.generate(5, (i) => GestureDetector(
                  onTap: () => setSheetState(() => _userRating = i + 1.0),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 6),
                    child: Icon(
                      i < _userRating ? Icons.star_rounded : Icons.star_outline_rounded,
                      color: Colors.amber,
                      size: 36,
                    ),
                  ),
                )),
              ),
              const SizedBox(height: 12),
              // Review text
              TextField(
                controller: _reviewController,
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: 'Share your experience...',
                  hintStyle: GoogleFonts.poppins(color: Colors.grey[400], fontSize: 13),
                  filled: true,
                  fillColor: const Color(0xFFF0F4F8),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                  contentPadding: const EdgeInsets.all(16),
                ),
                style: GoogleFonts.poppins(fontSize: 14),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_userRating == 0) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Please select a star rating!', style: GoogleFonts.poppins()),
                        backgroundColor: Colors.red[400],
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ));
                      return;
                    }
                    if (_reviewController.text.trim().isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Please write a review!', style: GoogleFonts.poppins()),
                        backgroundColor: Colors.red[400],
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ));
                      return;
                    }
                    setState(() {
                      review.name = _nameController.text.trim().isEmpty ? 'Anonymous' : _nameController.text.trim();
                      review.comment = _reviewController.text.trim();
                      review.rating = _userRating;
                      review.date = 'Edited';
                      _userRating = 0;
                      _reviewController.clear();
                      _nameController.clear();
                    });
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Review updated! ✅', style: GoogleFonts.poppins()),
                      backgroundColor: const Color(0xFF1A6B3C),
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colors[0],
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                  child: Text('Save Changes',
                      style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 15)),
                ),
              ),
            ],
          ),
        ),
      ),
    ).whenComplete(() {
      // Clear controllers if sheet dismissed without saving
      _userRating = 0;
      _nameController.clear();
      _reviewController.clear();
    });
  }

  void _showAddReviewSheet(List<Color> colors) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => StatefulBuilder(
        builder: (ctx, setSheetState) => Container(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom + 20,
            top: 20,
            left: 20,
            right: 20,
          ),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40, height: 4,
                  decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(2)),
                ),
              ),
              const SizedBox(height: 16),
              Text('Write a Review', style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold, color: colors[0])),
              const SizedBox(height: 16),
              // Name field
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  hintText: 'Your name (optional)',
                  hintStyle: GoogleFonts.poppins(color: Colors.grey[400], fontSize: 13),
                  filled: true,
                  fillColor: const Color(0xFFF0F4F8),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
                style: GoogleFonts.poppins(fontSize: 14),
              ),
              const SizedBox(height: 12),
              // Star rating
              Text('Your Rating', style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.grey[700])),
              const SizedBox(height: 8),
              Row(
                children: List.generate(5, (i) => GestureDetector(
                  onTap: () => setSheetState(() => _userRating = i + 1.0),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 6),
                    child: Icon(
                      i < _userRating ? Icons.star_rounded : Icons.star_outline_rounded,
                      color: Colors.amber,
                      size: 36,
                    ),
                  ),
                )),
              ),
              const SizedBox(height: 12),
              // Review text
              TextField(
                controller: _reviewController,
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: 'Share your experience...',
                  hintStyle: GoogleFonts.poppins(color: Colors.grey[400], fontSize: 13),
                  filled: true,
                  fillColor: const Color(0xFFF0F4F8),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                  contentPadding: const EdgeInsets.all(16),
                ),
                style: GoogleFonts.poppins(fontSize: 14),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _submitReview,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colors[0],
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                  child: Text('Submit Review', style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 15)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final attraction = widget.attraction;
    final colors = _colors[attraction.imageUrl] ?? [Colors.brown, Colors.orange];

    return Scaffold(
      backgroundColor: const Color(0xFFFFF8F0),
      body: CustomScrollView(
        slivers: [
          // ── Photo Gallery App Bar ──────────────────────────────────────
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            backgroundColor: colors[0],
            foregroundColor: Colors.white,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                children: [
                  // PageView of real photos
                  PageView.builder(
                    controller: _pageController,
                    itemCount: attraction.images.length,
                    onPageChanged: (i) => setState(() => _currentImageIndex = i),
                    itemBuilder: (_, i) => Image.asset(
                      attraction.images[i],
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        color: colors[0],
                        child: Center(child: Icon(Icons.image_not_supported, color: Colors.white54, size: 60)),
                      ),
                    ),
                  ),
                  // Dark gradient at bottom for title readability
                  Positioned(
                    bottom: 0, left: 0, right: 0,
                    child: Container(
                      height: 100,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [Colors.black.withOpacity(0.65), Colors.transparent],
                        ),
                      ),
                    ),
                  ),
                  // Dot indicators
                  Positioned(
                    bottom: 12, left: 0, right: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(attraction.images.length, (i) => AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        margin: const EdgeInsets.symmetric(horizontal: 3),
                        width: _currentImageIndex == i ? 20 : 7,
                        height: 7,
                        decoration: BoxDecoration(
                          color: _currentImageIndex == i ? Colors.white : Colors.white54,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      )),
                    ),
                  ),
                  // Photo counter
                  Positioned(
                    top: 12, right: 16,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.black45,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        '${_currentImageIndex + 1} / ${attraction.images.length}',
                        style: GoogleFonts.poppins(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ],
              ),
              title: Text(
                attraction.name,
                style: GoogleFonts.poppins(fontWeight: FontWeight.bold, color: Colors.white,
                    shadows: [const Shadow(color: Colors.black54, blurRadius: 8)]),
              ),
              titlePadding: const EdgeInsets.only(left: 56, bottom: 38),
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Location row + rating
                  Row(
                    children: [
                      Icon(Icons.location_on, color: colors[0], size: 18),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(attraction.location,
                            style: GoogleFonts.poppins(fontSize: 13, color: colors[0], fontWeight: FontWeight.w500)),
                      ),
                      Icon(Icons.star_rounded, color: Colors.amber, size: 18),
                      const SizedBox(width: 4),
                      Text(
                        _averageRating.toStringAsFixed(1),
                        style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.grey[700]),
                      ),
                      Text(' (${_reviews.length})',
                          style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey[500])),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Google Maps button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () => _openInGoogleMaps(attraction.latitude, attraction.longitude, attraction.name),
                      icon: const Text('🗺️', style: TextStyle(fontSize: 18)),
                      label: Text('Open in Google Maps',
                          style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 15)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colors[0],
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                        elevation: 2,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // About
                  _buildSectionHeader('About', Icons.info_outline, colors[0]),
                  const SizedBox(height: 10),
                  _buildCard(child: Text(attraction.description,
                      style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey[800], height: 1.7))),
                  const SizedBox(height: 20),

                  // History
                  _buildSectionHeader('Historical Background', Icons.history_edu, colors[0]),
                  const SizedBox(height: 10),
                  _buildCard(child: Text(attraction.history,
                      style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey[800], height: 1.7))),
                  const SizedBox(height: 20),

                  // Highlights
                  _buildSectionHeader('Highlights', Icons.star_outline, colors[0]),
                  const SizedBox(height: 10),
                  _buildCard(
                    child: Column(
                      children: attraction.highlights.map((h) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        child: Row(
                          children: [
                            Container(width: 8, height: 8,
                                decoration: BoxDecoration(color: colors[0], shape: BoxShape.circle)),
                            const SizedBox(width: 12),
                            Expanded(child: Text(h,
                                style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey[800]))),
                          ],
                        ),
                      )).toList(),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Location Info
                  _buildSectionHeader('Location Info', Icons.map_outlined, colors[0]),
                  const SizedBox(height: 10),
                  _buildCard(
                    child: Column(
                      children: [
                        _buildLocationRow('📍 Region', attraction.location, colors[0]),
                        const Divider(height: 20),
                        _buildLocationRow('🌐 Coordinates',
                            '${attraction.latitude.toStringAsFixed(4)}° N, ${attraction.longitude.toStringAsFixed(4)}° E',
                            colors[0]),
                        const Divider(height: 20),
                        _buildLocationRow('🇯🇴 Country', 'Jordan, Middle East', colors[0]),
                        const Divider(height: 20),
                        GestureDetector(
                          onTap: () => _openInGoogleMaps(attraction.latitude, attraction.longitude, attraction.name),
                          child: Row(
                            children: [
                              Icon(Icons.open_in_new, color: colors[0], size: 16),
                              const SizedBox(width: 8),
                              Text('View on Google Maps',
                                  style: GoogleFonts.poppins(fontSize: 13, color: colors[0],
                                      fontWeight: FontWeight.w600, decoration: TextDecoration.underline)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // ── Reviews Section ─────────────────────────────────────
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildSectionHeader('Reviews', Icons.rate_review_outlined, colors[0]),
                      GestureDetector(
                        onTap: () => _showAddReviewSheet(colors),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
                          decoration: BoxDecoration(
                            color: colors[0],
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text('+ Add Review',
                              style: GoogleFonts.poppins(fontSize: 12, color: Colors.white, fontWeight: FontWeight.w600)),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),

                  // Rating summary card
                  _buildCard(
                    child: Row(
                      children: [
                        Column(
                          children: [
                            Text(_averageRating.toStringAsFixed(1),
                                style: GoogleFonts.poppins(fontSize: 42, fontWeight: FontWeight.bold, color: colors[0])),
                            Row(
                              children: List.generate(5, (i) => Icon(
                                i < _averageRating.round() ? Icons.star_rounded : Icons.star_outline_rounded,
                                color: Colors.amber, size: 18,
                              )),
                            ),
                            Text('${_reviews.length} reviews',
                                style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey[500])),
                          ],
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: Column(
                            children: List.generate(5, (i) {
                              final star = 5 - i;
                              final count = _reviews.where((r) => r.rating.round() == star).length;
                              final pct = _reviews.isEmpty ? 0.0 : count / _reviews.length;
                              return Padding(
                                padding: const EdgeInsets.symmetric(vertical: 2),
                                child: Row(
                                  children: [
                                    Text('$star', style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey[600])),
                                    const SizedBox(width: 4),
                                    const Icon(Icons.star_rounded, color: Colors.amber, size: 12),
                                    const SizedBox(width: 6),
                                    Expanded(
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(4),
                                        child: LinearProgressIndicator(
                                          value: pct,
                                          backgroundColor: Colors.grey[200],
                                          valueColor: AlwaysStoppedAnimation<Color>(colors[0]),
                                          minHeight: 6,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 6),
                                    Text('$count', style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey[500])),
                                  ],
                                ),
                              );
                            }),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Individual reviews
                  ..._reviews.map((r) => _buildReviewCard(r, colors)),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewCard(Review review, List<Color> colors) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: review.isUserReview ? colors[0].withOpacity(0.05) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: review.isUserReview ? Border.all(color: colors[0].withOpacity(0.3), width: 1.5) : null,
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8, offset: const Offset(0, 2)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 18,
                backgroundColor: colors[0].withOpacity(0.15),
                child: Text(review.name[0].toUpperCase(),
                    style: GoogleFonts.poppins(fontWeight: FontWeight.bold, color: colors[0], fontSize: 14)),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(review.name, style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 14)),
                        if (review.isUserReview) ...[
                          const SizedBox(width: 6),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(color: colors[0], borderRadius: BorderRadius.circular(8)),
                            child: Text('You', style: GoogleFonts.poppins(fontSize: 10, color: Colors.white, fontWeight: FontWeight.w600)),
                          ),
                        ],
                      ],
                    ),
                    Text(review.date, style: GoogleFonts.poppins(fontSize: 11, color: Colors.grey[500])),
                  ],
                ),
              ),
              Row(
                children: List.generate(5, (i) => Icon(
                  i < review.rating ? Icons.star_rounded : Icons.star_outline_rounded,
                  color: Colors.amber, size: 16,
                )),
              ),
              // ⋮ menu — only on user reviews
              if (review.isUserReview) ...[
                const SizedBox(width: 4),
                PopupMenuButton<String>(
                  icon: Icon(Icons.more_vert, color: Colors.grey[400], size: 20),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  onSelected: (value) {
                    if (value == 'edit') _showEditReviewSheet(review, colors);
                    if (value == 'delete') _deleteReview(review, colors);
                  },
                  itemBuilder: (_) => [
                    PopupMenuItem(
                      value: 'edit',
                      child: Row(
                        children: [
                          Icon(Icons.edit_outlined, size: 18, color: colors[0]),
                          const SizedBox(width: 10),
                          Text('Edit', style: GoogleFonts.poppins(fontSize: 14)),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      value: 'delete',
                      child: Row(
                        children: [
                          Icon(Icons.delete_outline, size: 18, color: Colors.red[400]),
                          const SizedBox(width: 10),
                          Text('Delete', style: GoogleFonts.poppins(fontSize: 14, color: Colors.red[400])),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
          const SizedBox(height: 10),
          Text(review.comment, style: GoogleFonts.poppins(fontSize: 13, color: Colors.grey[700], height: 1.5)),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, IconData icon, Color color) {
    return Row(
      children: [
        Icon(icon, color: color, size: 20),
        const SizedBox(width: 8),
        Text(title, style: GoogleFonts.poppins(fontSize: 17, fontWeight: FontWeight.bold, color: color)),
      ],
    );
  }

  Widget _buildCard({required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 10, offset: const Offset(0, 3)),
        ],
      ),
      child: child,
    );
  }

  Widget _buildLocationRow(String label, String value, Color color) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(width: 130,
            child: Text(label, style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w600, color: color))),
        Expanded(child: Text(value, style: GoogleFonts.poppins(fontSize: 13, color: Colors.grey[700]))),
      ],
    );
  }
}
