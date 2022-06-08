part of 'system_bloc.dart';

enum SystemStatusEnum {
  initial,
  loaded,
}

abstract class SystemState extends Equatable {
  const SystemState();

  @override
  List<Object> get props => [];
}

class SystemInitialState extends SystemState {
  final SystemModel system;
  final SystemStatusEnum status;

  const SystemInitialState({
    required this.system,
    this.status = SystemStatusEnum.initial,
  });

  @override
  List<Object> get props => [
        system,
        status,
      ];
}
