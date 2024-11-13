abstract class PhotosEvent {}

class LoadPhotos extends PhotosEvent {}

class PickCoverPhoto extends PhotosEvent {}

class PickNewPhoto extends PhotosEvent {}

class DeletePhoto extends PhotosEvent {
  final String photoUrl;

  DeletePhoto(this.photoUrl);
}

class EditPhoto extends PhotosEvent {
  final String photoUrl;

  EditPhoto(this.photoUrl);
}
