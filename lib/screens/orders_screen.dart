import 'package:com_noopeshop_app/config/constants.dart';
import 'package:com_noopeshop_app/config/functions/translate.dart';
import 'package:com_noopeshop_app/models/order_model.dart';
import 'package:com_noopeshop_app/services/orders/orders_bloc.dart';
import 'package:com_noopeshop_app/widgets/progress_bullet_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> status = [
      {
        'status': OrdersStatus.paid,
        'label': t(context)!.paidOrderStatusLabel,
      },
      {
        'status': OrdersStatus.processing,
        'label': t(context)!.processingOrderStatusLabel,
      },
      {
        'status': OrdersStatus.shipping,
        'label': t(context)!.shippingOrderStatusLabem,
      },
      {
        'status': OrdersStatus.delivered,
        'label': t(context)!.deliveredOrderStatusLabem,
      }
    ];

    return BlocBuilder<OrdersBloc, OrdersState>(
      bloc: context.read<OrdersBloc>()..add(OnLoadOrders()),
      builder: (context, state) {
        if (state is! OrdersLoadedState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        final List<OrderModel> ordersModel = state.ordersModel;

        return Scaffold(
          body: CustomScrollView(slivers: <Widget>[
            SliverAppBar(
              floating: true,
              backgroundColor: Colors.white,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(
                  t(context)!.ordersAppBar.toUpperCase(),
                  style: const TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: kBackgroundColor,
                  ),
                ),
              ),
            ),
            if (ordersModel.isEmpty)
              SliverFillRemaining(
                child: Center(
                  child: Text(
                    "No orders",
                    style: Theme.of(context).textTheme.headline4,
                  ),
                ),
              ),
            if (ordersModel.isNotEmpty)
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (_, int index) {
                    final OrderModel orderModel = ordersModel[index];
                    int currentIndex = -1;
                    bool step = false;

                    return Container(
                      margin: const EdgeInsets.only(
                        top: 15.0,
                        bottom: 20.0,
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 22.0,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          16.0,
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              right: 16.0,
                            ),
                            child: SizedBox(
                              width: 120,
                              height: 120,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(
                                  16.0,
                                ),
                                child: Image.network(
                                  orderModel.media,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Flexible(
                            child: Wrap(
                              runSpacing: 10,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        bottom: 8.0,
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Commande n°",
                                            style: Theme.of(context)
                                                .textTheme
                                                .caption,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              bottom: 4.0,
                                            ),
                                            child: Text(
                                              orderModel.id,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline5,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          Text(
                                            NumberFormat.currency(
                                              locale: "fr_FR",
                                              symbol: "€",
                                            ).format(
                                              orderModel.amount / 100,
                                            ),
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline5!
                                                .copyWith(
                                                  color: kDefaultColor,
                                                ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        bottom: 8.0,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children:
                                            status.asMap().entries.map((entry) {
                                          final OrdersStatus ordersStatus =
                                              entry.value['status'];

                                          final bool isActive =
                                              orderModel.status == ordersStatus;

                                          if (!isActive && !step) {
                                            currentIndex++;
                                          } else {
                                            step = true;
                                          }

                                          return ProgressBulletWidget(
                                            isFirst: entry.key == 0,
                                            isActive:
                                                !(currentIndex < entry.key - 1),
                                            size: 20.0,
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          status
                                              .asMap()
                                              .entries
                                              .firstWhere((status) =>
                                                  status.value['status'] ==
                                                  orderModel.status)
                                              .value['label'],
                                          style: Theme.of(context)
                                              .textTheme
                                              .caption!
                                              .copyWith(
                                                color: kDefaultColor,
                                              ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  childCount: ordersModel.length,
                ),
              ),
          ]),
        );
      },
    );
  }
}
