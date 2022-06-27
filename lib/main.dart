import 'dart:io';

import 'package:another_flushbar/flushbar.dart';
import 'package:com_noopeshop_app/config/theme.dart';
import 'package:com_noopeshop_app/models/notification_model.dart';
import 'package:com_noopeshop_app/models/product_model.dart';
import 'package:com_noopeshop_app/screens/home_screen.dart';
import 'package:com_noopeshop_app/screens/product_screen.dart';
import 'package:com_noopeshop_app/services/notifications/notifications_bloc.dart';
import 'package:com_noopeshop_app/services/product/product_bloc.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:com_noopeshop_app/config/bloc_register.dart';
import 'package:com_noopeshop_app/screens/splash_screen.dart';
import 'package:com_noopeshop_app/services/bootstrap/bootstrap_bloc.dart';
import 'package:com_noopeshop_app/services/system/system_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
    ],
  );

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;

  if (kDebugMode) {
    final String host =
        Platform.isAndroid ? "10.0.2.2" : "localhost"; // 192.168.1.13

    await FirebaseAuth.instance.useAuthEmulator(
      host,
      9099,
    );

    FirebaseFirestore.instance.useFirestoreEmulator(
      host,
      8080,
    );

    await FirebaseStorage.instance.useStorageEmulator(
      host,
      9199,
    );
  } else {
    FirebaseAnalytics.instance;
  }

  // FirebaseAuth.instance.signOut();

  await FirebaseFirestore.instance.terminate();
  await FirebaseFirestore.instance.clearPersistence();

  final FirebaseMessaging messaging = FirebaseMessaging.instance;

  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  final NotificationsBloc notification = NotificationsBloc();

  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    notification.initialize();
  }

  await Hive.initFlutter();

  runApp(App(
    firebaseAuth: FirebaseAuth.instance,
    firebaseFirestore: FirebaseFirestore.instance,
    firebaseStorage: FirebaseStorage.instance,
    messaging: FirebaseMessaging.instance,
    notification: notification,
  ));
}

class App extends StatelessWidget {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firebaseFirestore;
  final FirebaseStorage firebaseStorage;
  final FirebaseMessaging messaging;
  final NotificationsBloc notification;

  late Flushbar _flush;

  App({
    Key? key,
    required this.firebaseAuth,
    required this.firebaseFirestore,
    required this.firebaseStorage,
    required this.messaging,
    required this.notification,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocRegister(
      firebaseAuth: firebaseAuth,
      firebaseFirestore: firebaseFirestore,
      firebaseStorage: firebaseStorage,
      messaging: messaging,
      notification: notification,
      child: MaterialApp(
        title: 'NoopEshop',
        debugShowCheckedModeBanner: false,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en', ''),
          Locale('fr', ''),
        ],
        theme: CustomThemeData.themeLight(context),
        darkTheme: CustomThemeData.themeDark(context),
        home: BlocListener<SystemBloc, SystemState>(
          listener: (context, state) {
            if ((state as SystemInitialState).status ==
                SystemStatusEnum.loaded) {
              context.read<BootstrapBloc>().add(OnInitBootstrapEvent());
            }
          },
          child: BlocBuilder<BootstrapBloc, BootstrapState>(
            builder: (context, state) {
              final BootstrapStatusEnum status =
                  (state as BootstrapInitialState).status;

              if (status != BootstrapStatusEnum.onReadyBootstrap) {
                return const SplashScreen();
              }

              return BlocListener<NotificationsBloc, NotificationsState>(
                listener: (context, state) {
                  final NotificationModel notificationModel =
                      (state as NotificationsInitialState).notificationModel;

                  final bool onOpenApp = state.onOpenApp;

                  if (onOpenApp) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            BlocBuilder<ProductBloc, ProductState>(
                                bloc: context.read<ProductBloc>()
                                  ..add(
                                    OnLoadProductEvent(
                                      productId:
                                          notificationModel.data['productId']!,
                                    ),
                                  ),
                                builder: (context, state) {
                                  final ProductModel productModel =
                                      (state as ProductInitialState).product;

                                  if (productModel.id.isEmpty) {
                                    return const SplashScreen();
                                  }

                                  return ProductScreen(
                                    productModel: productModel,
                                  );
                                }),
                      ),
                    );
                    return;
                  }

                  _flush = Flushbar(
                    flushbarPosition: FlushbarPosition.TOP,
                    margin: const EdgeInsets.all(16.0),
                    borderRadius: BorderRadius.circular(16.0),
                    flushbarStyle: FlushbarStyle.FLOATING,
                    title: notificationModel.title,
                    message: notificationModel.body,
                    duration: const Duration(
                      seconds: 3,
                    ),
                    mainButton: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                BlocBuilder<ProductBloc, ProductState>(
                                    bloc: context.read<ProductBloc>()
                                      ..add(
                                        OnLoadProductEvent(
                                          productId: notificationModel
                                              .data['productId']!,
                                        ),
                                      ),
                                    builder: (context, state) {
                                      final ProductModel productModel =
                                          (state as ProductInitialState)
                                              .product;

                                      if (productModel.id.isEmpty) {
                                        return const SplashScreen();
                                      }

                                      return ProductScreen(
                                        productModel: productModel,
                                      );
                                    }),
                          ),
                        );

                        _flush.dismiss(true); // result = true
                      },
                      child: const Text(
                        "Let's go",
                        style: TextStyle(color: Colors.amber),
                      ),
                    ),
                  )..show(context);
                },
                child: const HomeScreen(),
              );
            },
          ),
        ),
      ),
    );
  }
}
