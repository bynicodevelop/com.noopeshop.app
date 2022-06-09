import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:com_noopeshop_app/components/favorites/favorite_button/favorite_button_bloc.dart';
import 'package:com_noopeshop_app/components/favorites/favorites/favorites_bloc.dart';
import 'package:com_noopeshop_app/components/feed/feed/feed_bloc.dart';
import 'package:com_noopeshop_app/repositories/authentication_repository.dart';
import 'package:com_noopeshop_app/repositories/favorite_repository.dart';
import 'package:com_noopeshop_app/repositories/feed_repository.dart';
import 'package:com_noopeshop_app/repositories/system_repository.dart';
import 'package:com_noopeshop_app/repositories/swipe_repository.dart';
import 'package:com_noopeshop_app/services/bootstrap/bootstrap_bloc.dart';
import 'package:com_noopeshop_app/services/swipe/swipe_bloc.dart';
import 'package:com_noopeshop_app/services/system/system_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlocRegister extends StatelessWidget {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firebaseFirestore;
  final FirebaseStorage firebaseStorage;
  final Widget child;

  const BlocRegister({
    Key? key,
    required this.child,
    required this.firebaseAuth,
    required this.firebaseFirestore,
    required this.firebaseStorage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SystemRepository systemRepository = SystemRepository();

    final FeedRepository feedRepository = FeedRepository(
      firebaseAuth: firebaseAuth,
      firebaseFirestore: firebaseFirestore,
    );

    final AuthenticationRepository authenticationRepository =
        AuthenticationRepository(
      firebaseAuth: firebaseAuth,
    );

    const SwipeRepository swipeRepository = SwipeRepository();

    final FavoriteRepository favoriteRepository = FavoriteRepository(
      firebaseAuth: firebaseAuth,
      firebaseFirestore: firebaseFirestore,
    );

    return MultiBlocProvider(
      providers: [
        BlocProvider<SystemBloc>(
          create: (context) => SystemBloc(
            systemRepository: systemRepository,
          )..add(OnInitSystemEvent()),
        ),
        BlocProvider<FeedBloc>(
          create: (context) => FeedBloc(
            feedRepository: feedRepository,
          )..add(const OnLoadFeedEvent()),
        ),
        BlocProvider<FavoritesBloc>(
          create: (context) => FavoritesBloc(
            favoriteRepository: favoriteRepository,
          ),
        ),
        BlocProvider<BootstrapBloc>(
          create: (context) => BootstrapBloc(
            authenticationRepository: authenticationRepository,
          ),
        ),
        BlocProvider<FavoriteButtonBloc>(
          create: (context) => FavoriteButtonBloc(
            favoriteRepository: favoriteRepository,
          ),
        ),
        BlocProvider<FeedBloc>(
          create: (context) => FeedBloc(
            feedRepository: feedRepository,
          )..add(const OnLoadFeedEvent()),
        ),
        BlocProvider<SwipeBloc>(
          create: (context) => SwipeBloc(
            swipeRepository: swipeRepository,
          ),
        ),
      ],
      child: child,
    );
  }
}
