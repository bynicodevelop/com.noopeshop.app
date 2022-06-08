part of 'system_bloc.dart';

abstract class SystemEvent extends Equatable {
  const SystemEvent();

  @override
  List<Object> get props => [];
}

class OnInitSystemEvent extends SystemEvent {}

class OnUpdateSystemEvent extends SystemEvent {
  final String key;
  final dynamic value;

  const OnUpdateSystemEvent({
    required this.key,
    required this.value,
  });

  @override
  List<Object> get props => [
        key,
        value,
      ];
}
