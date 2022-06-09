// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:com_noopeshop_app/models/product_model.dart';
import 'package:com_noopeshop_app/repositories/feed_repository.dart';
import 'package:equatable/equatable.dart';

part 'feed_event.dart';
part 'feed_state.dart';

class FeedBloc extends Bloc<FeedEvent, FeedState> {
  final FeedRepository feedRepository;

  FeedBloc({
    required this.feedRepository,
  }) : super(const FeedInitialState(
          feeds: [],
        )) {
    on<OnLoadFeedEvent>((event, emit) async {
      final List<ProductModel> feeds = await feedRepository.getFeed(
        event.index,
      );

      emit(FeedInitialState(
        refresh: DateTime.now().microsecondsSinceEpoch,
        feeds: feeds,
      ));
    });
  }
}
