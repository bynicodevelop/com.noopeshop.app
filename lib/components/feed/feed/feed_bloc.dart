// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:com_noopeshop_app/models/feed_model.dart';
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
    on<FeedEvent>((event, emit) async {
      final List<FeedModel> feeds = await feedRepository.getFeed();

      emit(FeedInitialState(
        feeds: feeds,
      ));
    });
  }
}
