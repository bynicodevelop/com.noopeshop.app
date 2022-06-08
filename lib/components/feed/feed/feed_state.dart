part of 'feed_bloc.dart';

abstract class FeedState extends Equatable {
  const FeedState();

  @override
  List<Object> get props => [];
}

class FeedInitialState extends FeedState {
  final List<FeedModel> feeds;

  const FeedInitialState({
    required this.feeds,
  });

  @override
  List<Object> get props => [
        feeds,
      ];
}
