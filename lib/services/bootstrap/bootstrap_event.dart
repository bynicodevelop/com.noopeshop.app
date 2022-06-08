part of 'bootstrap_bloc.dart';

abstract class BootstrapEvent extends Equatable {
  const BootstrapEvent();

  @override
  List<Object> get props => [];
}

class OnInitBootstrapEvent extends BootstrapEvent {}

class OnLoginBootstrapEvent extends BootstrapEvent {}

class OnReadyBootstrapEvent extends BootstrapEvent {
  final UserModel userModel;

  const OnReadyBootstrapEvent({
    required this.userModel,
  });

  @override
  List<Object> get props => [
        userModel,
      ];
}
