enum PhotoSorting {
  allPhotos("All Photos"),
  photosByOwner("Photos by owner"),
  photosByOthers("Photos by others");
  // Define a constructor and a field to store the title
  const PhotoSorting(this.title);

  final String title;

  @override
  String toString() => title;
}
