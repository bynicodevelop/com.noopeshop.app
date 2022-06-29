import 'package:bloc/bloc.dart';
import 'package:com_noopeshop_app/repositories/payment_repository.dart';
import 'package:equatable/equatable.dart';

part 'payment_event.dart';
part 'payment_state.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  final PaymentRepository paymentRepository;

  PaymentBloc({
    required this.paymentRepository,
  }) : super(PaymentInitialState()) {
    on<OnIntentPaymentBloc>((event, emit) async {
      emit(PaymentLoadingState());

      await paymentRepository.intentPayment(event.checkout);

      emit(PaymentSuccessState());
    });
  }
}
