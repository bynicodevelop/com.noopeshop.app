import 'package:com_noopeshop_app/repositories/abstracts/authentication_repository_abstract.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class MediaRepositoryAbstract extends AuthenticationRepositoryAbstract {
  final FirebaseStorage firebaseStorage;

  MediaRepositoryAbstract({
    required this.firebaseStorage,
    required FirebaseAuth firebaseAuth,
  }) : super(
          firebaseAuth: firebaseAuth,
        );

  Future<String> getMediaUrlFromStorage(String mediaId) async {
    return await firebaseStorage.ref().child(mediaId).getDownloadURL();
  }
}
