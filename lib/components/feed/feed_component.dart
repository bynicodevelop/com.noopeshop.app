import 'package:com_noopeshop_app/components/favorites/favorite_button/favorite_button_bloc.dart';
import 'package:com_noopeshop_app/components/favorites/favorite_button_component.dart';
import 'package:com_noopeshop_app/components/feed/feed/feed_bloc.dart';
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
  const FeedComponent({Key? key}) : super(key: key);

  @override
  State<FeedComponent> createState() => _FeedComponentState();
}

class _FeedComponentState extends State<FeedComponent> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FeedBloc, FeedState>(
      builder: (context, state) {
        final List<ProductModel> feeds = (state as FeedInitialState).feeds;

        return PageView.builder(
          onPageChanged: (int value) {
            context.read<SystemBloc>().add(
                  const OnUpdateSystemEvent(
                    key: "swipe",
                    value: true,
                  ),
                );

            if (value > _currentIndex) {
              context.read<SwipeBloc>().add(OnSwipeUpEvent());
              context.read<FeedBloc>().add(
                    OnLoadFeedEvent(
                      index: value,
                    ),
                  );
            } else {
              context.read<SwipeBloc>().add(OnSwipeDownEvent());
            }

            setState(() => _currentIndex = value);
          },
          scrollDirection: Axis.vertical,
          itemCount: feeds.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onDoubleTap: () {
                // TODO: Ajouter une condition pour savoir si le système est configuré (à voir)
                context.read<SystemBloc>().add(
                      const OnUpdateSystemEvent(
                        key: "favorite",
                        value: true,
                      ),
                    );

                context.read<FavoriteButtonBloc>().add(OnFavoriteButtonPressed(
                      productModel: feeds[index],
                    ));
              },
              child: Stack(
                fit: StackFit.expand,
                children: [
                  feeds[index].mediaType == MediaTypeEnum.image
                      ? Image.asset(
                          feeds[index].media,
                          fit: BoxFit.cover,
                        )
                      : VideoPlayerWidget(
                          productModel: feeds[index],
                        ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.15),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        bottom: 70.0,
                      ),
                      child: SizedBox(
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16.0,
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  state.feeds[index].title,
                                  style: Theme.of(context).textTheme.headline1,
                                ),
                              ),
                              FavoriteButtonComponent(
                                productModel: state.feeds[index],
                                defaultSize: 25.0,
                                blurButton: true,
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
  }
}
