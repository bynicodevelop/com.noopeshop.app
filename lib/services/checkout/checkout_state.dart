part of 'checkout_bloc.dart';

abstract class CheckoutState extends Equatable {
  const CheckoutState();

  @override
  List<Object> get props => [];
}

class CheckoutInitialState extends CheckoutState {
  final String name;
  final String email;
  final String shippingAddress;
  final String shippingCity;
  final String shippingPostalCode;
  final String cardNumber;
  final String cardExpiry;
  final String cardCvv;

  const CheckoutInitialState({
    this.name = "",
    this.email = "",
    this.shippingAddress = "",
    this.shippingCity = "",
    this.shippingPostalCode = "",
    this.cardNumber = "",
    this.cardExpiry = "",
    this.cardCvv = "",
  });

  CheckoutInitialState copyWith({
    String? name,
    String? email,
    String? shippingAddress,
    String? shippingCity,
    String? shippingPostalCode,
    String? cardNumber,
    String? cardExpiry,
    String? cardCvv,
  }) {
    return CheckoutInitialState(
      name: name ?? this.name,
      email: email ?? this.email,
      shippingAddress: shippingAddress ?? this.shippingAddress,
      shippingCity: shippingCity ?? this.shippingCity,
      shippingPostalCode: shippingPostalCode ?? this.shippingPostalCode,
      cardNumber: cardNumber ?? this.cardNumber,
      cardExpiry: cardExpiry ?? this.cardExpiry,
      cardCvv: cardCvv ?? this.cardCvv,
    );
  }

  @override
  List<Object> get props => [
        name,
        email,
        shippingAddress,
        shippingCity,
        shippingPostalCode,
        cardNumber,
        cardExpiry,
        cardCvv,
      ];
}
