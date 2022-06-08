import 'package:com_noopeshop_app/components/favorites/favorite_button_component.dart';
import 'package:com_noopeshop_app/components/feed/feed/feed_bloc.dart';
import 'package:com_noopeshop_app/models/feed_model.dart';
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
      bloc: context.read<FeedBloc>()..add(const OnLoadFeedEvent()),
      builder: (context, state) {
        return PageView(
          onPageChanged: (value) {
            context.read<SystemBloc>().add(
                  const OnUpdateSystemEvent(
                    key: "swipe",
                    value: true,
                  ),
                );

            if (value > _currentIndex) {
              context.read<SwipeBloc>().add(OnSwipeUpEvent());
            } else {
              context.read<SwipeBloc>().add(OnSwipeDownEvent());
            }

            setState(() => _currentIndex = value);
          },
          scrollDirection: Axis.vertical,
          children: (state as FeedInitialState).feeds.map((product) {
            return GestureDetector(
              onDoubleTap: () {
                context.read<SystemBloc>().add(
                      const OnUpdateSystemEvent(
                        key: "favorite",
                        value: true,
                      ),
                    );
              },
              child: Stack(
                fit: StackFit.expand,
                children: [
                  product.mediaType == MediaTypeEnum.image
                      ? Image.asset(
                          product.media,
                          fit: BoxFit.cover,
                        )
                      : VideoPlayerWidget(
                          feedModel: product,
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
                                  product.title,
                                  style: Theme.of(context).textTheme.headline1,
                                ),
                              ),
                              const FavoriteButtonComponent(
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
          }).toList(),
        );
      },
    );
  }
}
