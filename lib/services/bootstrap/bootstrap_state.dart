part of 'bootstrap_bloc.dart';

enum BootstrapStatusEnum {
  onInitBootstrap,
  onReadyBootstrap,
}

abstract class BootstrapState extends Equatable {
  const BootstrapState();

  @override
  List<Object> get props => [];
}

class BootstrapInitialState extends BootstrapState {
  final BootstrapStatusEnum status;
  final UserModel userModel;

  const BootstrapInitialState({
    required this.status,
    required this.userModel,
  });

  @override
  List<Object> get props => [
        status,
        userModel,
      ];
}
