import 'dart:io';

import 'package:com_noopeshop_app/config/theme.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:com_noopeshop_app/config/bloc_register.dart';
import 'package:com_noopeshop_app/screens/home_screen.dart';
import 'package:com_noopeshop_app/screens/splash_screen.dart';
import 'package:com_noopeshop_app/services/bootstrap/bootstrap_bloc.dart';
import 'package:com_noopeshop_app/services/system/system_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
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

  if (kDebugMode) {
    final String host = Platform.isAndroid ? "10.0.2.2" : "localhost";

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
  }

  // await FirebaseAuth.instance.signOut();

  await FirebaseFirestore.instance.terminate();
  await FirebaseFirestore.instance.clearPersistence();

  await Hive.initFlutter();

  runApp(App(
    firebaseAuth: FirebaseAuth.instance,
    firebaseFirestore: FirebaseFirestore.instance,
    firebaseStorage: FirebaseStorage.instance,
  ));
}

class App extends StatelessWidget {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firebaseFirestore;
  final FirebaseStorage firebaseStorage;

  const App({
    Key? key,
    required this.firebaseAuth,
    required this.firebaseFirestore,
    required this.firebaseStorage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocRegister(
      firebaseAuth: firebaseAuth,
      firebaseFirestore: firebaseFirestore,
      firebaseStorage: firebaseStorage,
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

              return const HomeScreen();
            },
          ),
        ),
      ),
    );
  }
}
