class Review {
  String name;
  String comment;
  double rating;
  String date;
  final bool isUserReview;

  Review({
    required this.name,
    required this.comment,
    required this.rating,
    required this.date,
    this.isUserReview = false,
  });
}
