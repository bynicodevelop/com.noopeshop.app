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
  Future<List<FeedModel>> getFeed() async {
    await Future.delayed(
      const Duration(
        seconds: 1,
      ),
    );

    return products
        .map((product) => FeedModel.fromJson(
              product,
            ))
        .toList();
  }
}
