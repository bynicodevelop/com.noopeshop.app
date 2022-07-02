// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:com_noopeshop_app/models/notification_model.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

part 'notifications_event.dart';
part 'notifications_state.dart';

class NotificationsBloc extends Bloc<NotificationsEvent, NotificationsState> {
  NotificationsBloc()
      : super(NotificationsInitialState(
          notificationModel: NotificationModel.empty(),
        )) {
    on<OnMessageNotificationEvent>((event, emit) {
      emit(NotificationsInitialState(
        notificationModel: NotificationModel.fromJson({
          "title": event.title,
          "body": event.body,
          "data": event.data,
        }),
        onOpenApp: event.onOpenApp,
      ));
    });
  }

  void initialize() async {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      if (message.notification!.title != null &&
          message.notification!.body != null) {
        add(OnMessageNotificationEvent(
          title: message.notification!.title!,
          body: message.notification!.body!,
          data: message.data,
          onOpenApp: true,
        ));
      }
    });

    FirebaseMessaging.onMessage.listen((message) {
      if (message.notification!.title != null &&
          message.notification!.body != null) {
        add(OnMessageNotificationEvent(
          title: message.notification!.title!,
          body: message.notification!.body!,
          data: message.data,
        ));
      }
    });
  }
}
