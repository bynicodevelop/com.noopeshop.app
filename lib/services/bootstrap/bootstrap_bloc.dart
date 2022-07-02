import 'dart:developer';

// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:com_noopeshop_app/models/user_model.dart';
import 'package:com_noopeshop_app/repositories/authentication_repository.dart';
import 'package:equatable/equatable.dart';

part 'bootstrap_event.dart';
part 'bootstrap_state.dart';

class BootstrapBloc extends Bloc<BootstrapEvent, BootstrapState> {
  final AuthenticationRepository authenticationRepository;

  BootstrapBloc({
    required this.authenticationRepository,
  }) : super(BootstrapInitialState(
          status: BootstrapStatusEnum.onInitBootstrap,
          userModel: UserModel.empty(),
        )) {
    on<OnInitBootstrapEvent>((event, emit) async {
      log("BootstrapBloc: OnInitBootstrapEvent");

      authenticationRepository.user.listen((UserModel userModel) {
        if (userModel.isEmpty) {
          add(OnLoginBootstrapEvent());
        } else {
          add(OnReadyBootstrapEvent(
            userModel: userModel,
          ));
        }
      });
    });

    on<OnLoginBootstrapEvent>((event, emit) async {
      log("BootstrapBloc: OnLoginBootstrapEvent");

      final UserModel userModel =
          await authenticationRepository.authenticateAnonymously();

      add(OnReadyBootstrapEvent(
        userModel: userModel,
      ));
    });

    on<OnReadyBootstrapEvent>((event, emit) async {
      log("BootstrapBloc: OnReadyBootstrapEvent");

      await authenticationRepository.updateNotificationToken();

      await Future.delayed(
        const Duration(
          milliseconds: 500,
        ),
      );

      emit(BootstrapInitialState(
        status: BootstrapStatusEnum.onReadyBootstrap,
        userModel: event.userModel,
      ));
    });
  }
}
