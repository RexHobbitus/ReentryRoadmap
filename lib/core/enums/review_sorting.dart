enum ReviewSorting {
  newestFirst("Newest First"),
  oldestFirst("Oldest First"),
  highestRating("Highest Rating"),
  lowestRating("Lowest Rating");

  // Define a constructor and a field to store the title
  const ReviewSorting(this.title);

  final String title;

  @override
  String toString() => title;
}
