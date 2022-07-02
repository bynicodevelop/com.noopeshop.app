part of 'payment_bloc.dart';

abstract class PaymentEvent extends Equatable {
  const PaymentEvent();

  @override
  List<Object> get props => [];
}

class OnIntentPaymentBloc extends PaymentEvent {
  final Map<String, dynamic> checkout;

  const OnIntentPaymentBloc({
    required this.checkout,
  });

  @override
  List<Object> get props => [
        checkout,
      ];
}
