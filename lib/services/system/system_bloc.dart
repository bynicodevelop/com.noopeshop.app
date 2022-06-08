import 'package:bloc/bloc.dart';
import 'package:com_noopeshop_app/models/system_model.dart';
import 'package:com_noopeshop_app/repositories/system_repository.dart';
import 'package:equatable/equatable.dart';

part 'system_event.dart';
part 'system_state.dart';

class SystemBloc extends Bloc<SystemEvent, SystemState> {
  final SystemRepository systemRepository;

  SystemBloc({
    required this.systemRepository,
  }) : super(SystemInitialState(
          system: SystemModel.empty(),
        )) {
    on<OnInitSystemEvent>((event, emit) async {
      final SystemModel systemModel = await systemRepository.init();

      // await systemRepository.reset();

      emit(SystemInitialState(
        system: systemModel,
        status: SystemStatusEnum.loaded,
      ));
    });

    on<OnUpdateSystemEvent>((event, emit) async {
      late SystemModel systemModel;

      if (event.key == 'swipe') {
        systemModel = await systemRepository.updateSwipe(event.value);
      }

      if (event.key == 'favorite') {
        systemModel = await systemRepository.updateFavorite(event.value);
      }

      emit(SystemInitialState(
        system: systemModel,
        status: SystemStatusEnum.loaded,
      ));
    });
  }
}
