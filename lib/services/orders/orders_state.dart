part of 'orders_bloc.dart';

abstract class OrdersState extends Equatable {
  const OrdersState();

  @override
  List<Object> get props => [];
}

class OrdersInitialState extends OrdersState {}

class OrdersLoadingState extends OrdersState {}

class OrdersLoadedState extends OrdersState {
  final List<OrderModel> ordersModel;

  const OrdersLoadedState({
    this.ordersModel = const [],
  });

  @override
  List<Object> get props => [
        ordersModel,
      ];
}
