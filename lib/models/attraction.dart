class Attraction {
  final String id;
  final String name;
  final String description;
  final String history;
  final String location;
  final String imageUrl;
  final double latitude;
  final double longitude;
  final List<String> highlights;
  final List<String> images;

  const Attraction({
    required this.id,
    required this.name,
    required this.description,
    required this.history,
    required this.location,
    required this.imageUrl,
    required this.latitude,
    required this.longitude,
    required this.highlights,
    required this.images,
  });
}
