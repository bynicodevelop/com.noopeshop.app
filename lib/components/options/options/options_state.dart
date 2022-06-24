part of 'options_bloc.dart';

abstract class OptionsState extends Equatable {
  const OptionsState();

  @override
  List<Object> get props => [];
}

class OptionsInitialState extends OptionsState {
  final OptionModel optionModel;

  const OptionsInitialState({
    required this.optionModel,
  });

  @override
  List<Object> get props => [
        optionModel,
      ];
}
