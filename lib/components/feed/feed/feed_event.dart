part of 'feed_bloc.dart';

abstract class FeedEvent extends Equatable {
  const FeedEvent();

  @override
  List<Object> get props => [];
}

class OnLoadFeedEvent extends FeedEvent {
  const OnLoadFeedEvent();
}
