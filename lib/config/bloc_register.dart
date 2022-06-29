import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:com_noopeshop_app/components/favorites/favorite_button/favorite_button_bloc.dart';
import 'package:com_noopeshop_app/components/favorites/favorites/favorites_bloc.dart';
import 'package:com_noopeshop_app/components/feed/current_index/current_index_bloc.dart';
import 'package:com_noopeshop_app/components/feed/feed/feed_bloc.dart';
import 'package:com_noopeshop_app/repositories/authentication_repository.dart';
import 'package:com_noopeshop_app/repositories/cart_repository.dart';
import 'package:com_noopeshop_app/repositories/favorite_repository.dart';
import 'package:com_noopeshop_app/repositories/feed_repository.dart';
import 'package:com_noopeshop_app/repositories/orders_repository.dart';
import 'package:com_noopeshop_app/repositories/payment_repository.dart';
import 'package:com_noopeshop_app/repositories/system_repository.dart';
import 'package:com_noopeshop_app/repositories/swipe_repository.dart';
import 'package:com_noopeshop_app/services/add_to_cart/add_to_cart_bloc.dart';
import 'package:com_noopeshop_app/services/bootstrap/bootstrap_bloc.dart';
import 'package:com_noopeshop_app/services/notifications/notifications_bloc.dart';
import 'package:com_noopeshop_app/services/orders/orders_bloc.dart';
import 'package:com_noopeshop_app/services/payment/payment_bloc.dart';
import 'package:com_noopeshop_app/services/product/product_bloc.dart';
import 'package:com_noopeshop_app/services/swipe/swipe_bloc.dart';
import 'package:com_noopeshop_app/services/system/system_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlocRegister extends StatelessWidget {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firebaseFirestore;
  final FirebaseStorage firebaseStorage;
  final FirebaseFunctions firebaseFunctions;
  final FirebaseMessaging messaging;
  final NotificationsBloc notification;
  final Widget child;

  const BlocRegister({
    Key? key,
    required this.child,
    required this.firebaseAuth,
    required this.firebaseFirestore,
    required this.firebaseStorage,
    required this.firebaseFunctions,
    required this.messaging,
    required this.notification,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SystemRepository systemRepository = SystemRepository();

    final FeedRepository feedRepository = FeedRepository(
      firebaseAuth: firebaseAuth,
      firebaseFirestore: firebaseFirestore,
      firebaseStorage: firebaseStorage,
    );

    final AuthenticationRepository authenticationRepository =
        AuthenticationRepository(
      firebaseAuth: firebaseAuth,
      firebaseFirestore: firebaseFirestore,
      messaging: messaging,
    );

    const SwipeRepository swipeRepository = SwipeRepository();

    final CartRepository cartRepository = CartRepository(
      firebaseAuth: firebaseAuth,
      firebaseFirestore: firebaseFirestore,
      firebaseStorage: firebaseStorage,
    );

    final FavoriteRepository favoriteRepository = FavoriteRepository(
      firebaseAuth: firebaseAuth,
      firebaseFirestore: firebaseFirestore,
      firebaseStorage: firebaseStorage,
    );

    final OrdersRepository ordersRepository = OrdersRepository(
      firebaseAuth: firebaseAuth,
      firebaseFirestore: firebaseFirestore,
      firebaseStorage: firebaseStorage,
    );

    final PaymentRepository paymentRepository = PaymentRepository(
      firebaseFunctions: firebaseFunctions,
    );

    return MultiBlocProvider(
      providers: [
        BlocProvider<NotificationsBloc>(
          create: (context) => notification,
        ),
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
        BlocProvider<CurrentIndexBloc>(
          create: (context) => CurrentIndexBloc()
            ..add(const OnUpdateCurrentIndexEvent(
              currentIndex: 0,
            )),
        ),
        BlocProvider<ProductBloc>(
          create: (context) => ProductBloc(
            favoriteRepository: favoriteRepository,
          ),
        ),
        BlocProvider(
          create: (context) => AddToCartBloc(
            cartRepository: cartRepository,
          )..add(OnLoadCartEvent()),
        ),
        BlocProvider<OrdersBloc>(
          create: (context) => OrdersBloc(
            ordersRepository: ordersRepository,
          ),
        ),
        BlocProvider<PaymentBloc>(
          create: (context) => PaymentBloc(
            paymentRepository: paymentRepository,
          ),
        ),
      ],
      child: child,
    );
  }
}
