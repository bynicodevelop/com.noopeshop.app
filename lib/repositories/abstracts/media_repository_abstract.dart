import 'package:firebase_storage/firebase_storage.dart';

class MediaRepositoryAbstract {
  final FirebaseStorage firebaseStorage;

  MediaRepositoryAbstract({
    required this.firebaseStorage,
  });

  Future<String> getMediaUrlFromStorage(String mediaId) async {
    return await firebaseStorage.ref().child(mediaId).getDownloadURL();
  }
}
