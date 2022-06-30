// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'checkout_event.dart';
part 'checkout_state.dart';

class CheckoutBloc extends Bloc<CheckoutEvent, CheckoutState> {
  CheckoutBloc() : super(const CheckoutInitialState()) {
    on<OnFormUpdatedCheckoutEvent>((event, emit) {
      emit((state as CheckoutInitialState).copyWith(
        name: event.formData["name"],
        email: event.formData["email"],
        shippingAddress: event.formData["shippingAddress"],
        shippingCity: event.formData["shippingCity"],
        shippingPostalCode: event.formData["shippingPostalCode"],
        cardNumber: (event.formData["cardNumber"] ?? "").isNotEmpty
            ? event.formData["cardNumber"].replaceAll(' ', '')
            : null,
        cardExpiry: (event.formData["cardExpiry"] ?? "").isNotEmpty
            ? event.formData["cardExpiry"].replaceAll(RegExp(r'[ /]*'), '')
            : null,
        cardCvv: event.formData["cardCvv"],
      ));
    });
  }
}
