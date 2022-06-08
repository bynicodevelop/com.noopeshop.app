part of 'feed_bloc.dart';

abstract class FeedState extends Equatable {
  const FeedState();

  @override
  List<Object> get props => [];
}

class FeedInitialState extends FeedState {
  final int refresh;
  final List<FeedModel> feeds;

  const FeedInitialState({
    required this.feeds,
    this.refresh = 0,
  });

  @override
  List<Object> get props => [
        feeds,
        refresh,
      ];
}
