import 'package:bloc/bloc.dart';
import 'package:com_noopeshop_app/models/order_model.dart';
import 'package:com_noopeshop_app/repositories/orders_repository.dart';
import 'package:equatable/equatable.dart';

part 'orders_event.dart';
part 'orders_state.dart';

class OrdersBloc extends Bloc<OrdersEvent, OrdersState> {
  final OrdersRepository ordersRepository;

  OrdersBloc({
    required this.ordersRepository,
  }) : super(OrdersInitialState()) {
    on<OnLoadOrders>((event, emit) async {
      emit(OrdersLoadingState());

      List<OrderModel> ordersModel = await ordersRepository.loadOrders();

      emit(OrdersLoadedState(
        ordersModel: ordersModel,
      ));
    });
  }
}
