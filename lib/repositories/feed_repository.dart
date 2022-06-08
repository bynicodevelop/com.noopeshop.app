import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:com_noopeshop_app/models/feed_model.dart';

const List<Map<String, dynamic>> products = [
  {
    "id": "1",
    "title": "Body Lotion - Fitness extreme",
    "description": "This is a product description",
    "media": "assets/samples/1.png",
    "mediaType": "MediaTypeEnum.image",
  },
  {
    "id": "1",
    "title": "Product 2",
    "description": "This is a product description",
    "media": "assets/samples/2.png",
    "mediaType": "MediaTypeEnum.image",
  },
  {
    "id": "1",
    "title": "Product 3",
    "description": "This is a product description",
    "media": "assets/samples/3.png",
    "mediaType": "MediaTypeEnum.image",
  },
  {
    "id": "1",
    "title": "Product 3",
    "description": "This is a product description",
    "media": "assets/samples/4.mp4",
    "mediaType": "MediaTypeEnum.video",
  },
];

class FeedRepository {
  final FirebaseFirestore firebaseFirestore;

  final int _limit = 2;

  QueryDocumentSnapshot<Map<String, dynamic>>? _lastVisible;

  final List<FeedModel> _feeds = [];

  FeedRepository({
    required this.firebaseFirestore,
  });

  Future<List<FeedModel>> getFeed(int index) async {
    if (index != 0 && (index + 1) < _feeds.length) {
      return _feeds;
    }

    late QuerySnapshot<Map<String, dynamic>> querySnapshot;

    Query<Map<String, dynamic>> query =
        firebaseFirestore.collection('products').orderBy(
              'createdAt',
              descending: true,
            );

    if (_lastVisible != null) {
      query = query.startAfterDocument(_lastVisible!);
    }

    querySnapshot = await query.limit(_limit).get();

    if (querySnapshot.docs.isEmpty) {
      return _feeds;
    }

    _lastVisible = querySnapshot.docs.last;

    _feeds.addAll(
      querySnapshot.docs.map(
        (doc) => FeedModel.fromJson({
          "id": doc.id,
          ...doc.data(),
        }),
      ),
    );

    return _feeds;
  }
}
