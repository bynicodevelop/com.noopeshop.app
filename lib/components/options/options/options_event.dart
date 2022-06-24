part of 'options_bloc.dart';

abstract class OptionsEvent extends Equatable {
  const OptionsEvent();

  @override
  List<Object> get props => [];
}

class OnChangeOptionsEvent extends OptionsEvent {
  final OptionModel option;

  const OnChangeOptionsEvent({
    required this.option,
  });

  @override
  List<Object> get props => [
        option,
      ];
}
