// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:com_noopeshop_app/models/option_model.dart';
import 'package:equatable/equatable.dart';

part 'options_event.dart';
part 'options_state.dart';

class OptionsBloc extends Bloc<OptionsEvent, OptionsState> {
  OptionsBloc()
      : super(OptionsInitialState(
          optionModel: OptionModel.empty(),
        )) {
    on<OnChangeOptionsEvent>((event, emit) {
      emit(OptionsInitialState(
        optionModel: event.option,
      ));
    });
  }
}
