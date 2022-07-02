part of 'payment_bloc.dart';

abstract class PaymentState extends Equatable {
  const PaymentState();

  @override
  List<Object> get props => [];
}

class PaymentInitialState extends PaymentState {}

class PaymentLoadingState extends PaymentState {}

class PaymentSuccessState extends PaymentState {}

class PaymentErrorState extends PaymentState {
  final String error;

  const PaymentErrorState({
    required this.error,
  });

  @override
  List<Object> get props => [
        error,
      ];
}
