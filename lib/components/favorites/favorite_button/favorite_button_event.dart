part of 'favorite_button_bloc.dart';

abstract class FavoriteButtonEvent extends Equatable {
  const FavoriteButtonEvent();

  @override
  List<Object> get props => [];
}

class OnFavoriteButtonPressed extends FavoriteButtonEvent {}
