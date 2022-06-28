import 'package:com_noopeshop_app/config/functions/translate.dart';
import 'package:com_noopeshop_app/credential_options.dart';
import 'package:com_noopeshop_app/screens/search_address_screen.dart';
import 'package:com_noopeshop_app/services/checkout/checkout_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:google_api_headers/google_api_headers.dart';

import 'package:flutter/material.dart';

class DeliveryScreen extends StatefulWidget {
  const DeliveryScreen({Key? key}) : super(key: key);

  @override
  State<DeliveryScreen> createState() => _DeliveryScreenState();
}

class _DeliveryScreenState extends State<DeliveryScreen> {
  final TextEditingController _shippingAddressController =
      TextEditingController();
  final TextEditingController _shippingCityController = TextEditingController();
  final TextEditingController _shippingPostalCodeController =
      TextEditingController();

  final FocusNode _shippingAddressFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    _shippingAddressController.addListener(() {
      context.read<CheckoutBloc>().add(OnFormUpdatedCheckoutEvent(
            formData: {
              "shippingAddress": _shippingAddressController.text,
            },
          ));
    });

    _shippingCityController.addListener(() {
      context.read<CheckoutBloc>().add(OnFormUpdatedCheckoutEvent(
            formData: {
              "shippingCity": _shippingCityController.text,
            },
          ));
    });

    _shippingPostalCodeController.addListener(() {
      context.read<CheckoutBloc>().add(OnFormUpdatedCheckoutEvent(
            formData: {
              "shippingPostalCode": _shippingPostalCodeController.text,
            },
          ));
    });

    _shippingAddressFocusNode.requestFocus();
  }

  @override
  void dispose() {
    _shippingAddressController.dispose();
    _shippingCityController.dispose();
    _shippingPostalCodeController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 28.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              bottom: 52.0,
            ),
            child: Text(
              t(context)!.addressAppBar.toUpperCase(),
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              bottom: 22.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 16.0,
                    bottom: 16.0,
                  ),
                  child: Text(
                    t(context)!.deliveryLabelField,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
                TextField(
                  controller: _shippingAddressController,
                  focusNode: _shippingAddressFocusNode,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  onTap: () async {
                    final String? placeId = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SearchAddressScreen(
                          placeApiKey: CredentialOptions.kGooglePlaceApi,
                        ),
                      ),
                    );

                    if (placeId == null) return;

                    final GoogleMapsPlaces plist = GoogleMapsPlaces(
                      apiKey: CredentialOptions.kGooglePlaceApi,
                      apiHeaders: await const GoogleApiHeaders().getHeaders(),
                      //from google_api_headers package
                    );

                    PlacesDetailsResponse placesDetailsResponse =
                        await plist.getDetailsByPlaceId(placeId);

                    final Map<String, dynamic> address = {
                      'address': '',
                      'city': '',
                      'postalCode': '',
                      'country': '',
                    };

                    for (var component
                        in placesDetailsResponse.result.addressComponents) {
                      if (component.types.contains('street_number')) {
                        address['address'] = component.longName;
                      } else if (component.types.contains('route')) {
                        address['address'] += ' ${component.longName}';
                      } else if (component.types.contains('locality')) {
                        address['city'] = component.longName;
                      } else if (component.types.contains('postal_code')) {
                        address['postalCode'] = component.longName;
                      } else if (component.types.contains('country')) {
                        address['country'] = component.longName;
                      }
                    }

                    _shippingAddressController.text = address['address'];
                    _shippingCityController.text = address['city'];
                    _shippingPostalCodeController.text = address['postalCode'];
                  },
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 22.0,
                      vertical: 20.0,
                    ),
                    hintText: "Ex: Rue du commerce",
                    filled: true,
                    fillColor: Colors.grey.withOpacity(.1),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 16.0,
                        bottom: 16.0,
                      ),
                      child: Text(
                        t(context)!.cityLabelField,
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ),
                    TextField(
                      controller: _shippingCityController,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 22.0,
                          vertical: 20.0,
                        ),
                        hintText: "Ex: Paris",
                        filled: true,
                        fillColor: Colors.grey.withOpacity(.1),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(15),
                            topLeft: Radius.circular(15),
                          ),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(15),
                            topLeft: Radius.circular(15),
                          ),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(15),
                            topLeft: Radius.circular(15),
                          ),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        bottom: 16.0,
                      ),
                      child: Text(
                        t(context)!.postalCodeField,
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ),
                    TextField(
                      controller: _shippingPostalCodeController,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(
                        hintText: "Ex: 75000",
                        filled: true,
                        fillColor: Colors.grey.withOpacity(.1),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(15),
                            topRight: Radius.circular(15),
                          ),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(15),
                            topRight: Radius.circular(15),
                          ),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(15),
                            topRight: Radius.circular(15),
                          ),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
