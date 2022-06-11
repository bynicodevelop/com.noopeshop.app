import 'package:com_noopeshop_app/components/favorites/favorite_button/favorite_button_bloc.dart';
import 'package:com_noopeshop_app/components/favorites/favorite_button_component.dart';
import 'package:com_noopeshop_app/components/feed/current_index/current_index_bloc.dart';
import 'package:com_noopeshop_app/components/feed/feed/feed_bloc.dart';
import 'package:com_noopeshop_app/config/constants.dart';
import 'package:com_noopeshop_app/models/feed_model.dart';
import 'package:com_noopeshop_app/models/product_model.dart';
import 'package:com_noopeshop_app/models/system_model.dart';
import 'package:com_noopeshop_app/services/swipe/swipe_bloc.dart';
import 'package:com_noopeshop_app/services/system/system_bloc.dart';
import 'package:com_noopeshop_app/widgets/tutorial_widget.dart';
import 'package:com_noopeshop_app/widgets/video_play_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FeedComponent extends StatefulWidget {
  final PageController controller;

  const FeedComponent({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  State<FeedComponent> createState() => _FeedComponentState();
}

class _FeedComponentState extends State<FeedComponent> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrentIndexBloc, CurrentIndexState>(
      builder: (context, state) {
        final int currentIndex =
            (state as CurrentIndexInitialState).currentIndex;

        return BlocBuilder<FeedBloc, FeedState>(
          builder: (context, state) {
            final List<ProductModel> feeds = (state as FeedInitialState).feeds;

            return PageView.builder(
              controller: widget.controller,
              onPageChanged: (int value) {
                context.read<SystemBloc>().add(
                      const OnUpdateSystemEvent(
                        key: "swipe",
                        value: true,
                      ),
                    );

                if (value > currentIndex) {
                  context.read<SwipeBloc>().add(OnSwipeUpEvent());
                  context.read<FeedBloc>().add(
                        OnLoadFeedEvent(
                          index: value,
                        ),
                      );
                } else {
                  context.read<SwipeBloc>().add(OnSwipeDownEvent());
                }

                context.read<CurrentIndexBloc>().add(OnUpdateCurrentIndexEvent(
                      currentIndex: value,
                    ));
              },
              scrollDirection: Axis.vertical,
              itemCount: feeds.length,
              itemBuilder: (context, index) {
                return BlocBuilder<FavoriteButtonBloc, FavoriteButtonState>(
                  bloc: context.read<FavoriteButtonBloc>()
                    ..add(OnInitilizeFavoriteButtonEvent(
                      productModel: feeds[currentIndex],
                    )),
                  builder: (context, state) {
                    return GestureDetector(
                      onDoubleTap: () {
                        // TODO: Ajouter une condition pour savoir si le système est configuré (à voir)
                        context.read<SystemBloc>().add(
                              const OnUpdateSystemEvent(
                                key: "favorite",
                                value: true,
                              ),
                            );

                        context.read<FavoriteButtonBloc>().add(
                              OnFavoriteButtonPressed(
                                // Important de prendre le currentIndex pour eviter
                                //un conflit avec tous les boutons like
                                productModel: feeds[currentIndex],
                              ),
                            );
                      },
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          feeds[index].mediaType == MediaTypeEnum.image
                              ? Image.network(
                                  feeds[index].media[0],
                                  fit: BoxFit.cover,
                                )
                              : VideoPlayerWidget(
                                  productModel: feeds[index],
                                ),
                          Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                stops: const [.01, .4],
                                colors: [
                                  kBackgroundColor.withOpacity(.9),
                                  Colors.transparent,
                                ],
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                bottom: 120.0,
                              ),
                              child: SizedBox(
                                width: double.infinity,
                                height: 120.0,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                            right: 8.0,
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Text(
                                                feeds[index].title,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline1,
                                              ),
                                              Text(
                                                feeds[index].description,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText1!
                                                    .copyWith(
                                                  color: Colors.white,
                                                  shadows: [
                                                    Shadow(
                                                      color: Colors.black
                                                          .withOpacity(.6),
                                                      blurRadius: 5,
                                                      offset:
                                                          const Offset(1, 1),
                                                    ),
                                                  ],
                                                ),
                                                maxLines: 2,
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      FavoriteButtonComponent(
                                        // Important de prendre le currentIndex pour eviter
                                        //un conflit avec tous les boutons like
                                        productModel: feeds[currentIndex],
                                        defaultSize: 25.0,
                                        blurButton: false,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          BlocBuilder<SystemBloc, SystemState>(
                            builder: (context, state) {
                              final SystemModel systemModel =
                                  (state as SystemInitialState).system;

                              if (!systemModel.hasSwipe) {
                                return const TutorialWidget(
                                  icon: Icons.swipe_up_outlined,
                                  title: "Swipe up to see more",
                                );
                              }

                              if (!systemModel.hasAddToFavorites) {
                                return const TutorialWidget(
                                  icon: Icons.touch_app_outlined,
                                  title: "Double tap to add to favorites",
                                );
                              }

                              return const SizedBox.shrink();
                            },
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            );
          },
        );
      },
    );
  }
}
