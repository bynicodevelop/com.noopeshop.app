import 'package:com_noopeshop_app/config/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SearchAddressScreen extends PlacesAutocompleteWidget {
  final String placeApiKey;

  SearchAddressScreen({
    Key? key,
    required this.placeApiKey,
  }) : super(
          key: key,
          apiKey: placeApiKey,
          sessionToken: const Uuid().v4(),
          language: "fr",
          types: [],
          components: [
            Component(
              Component.country,
              "fr",
            ),
          ],
          strictbounds: false,
          debounce: 500,
        );

  @override
  PlacesAutocompleteState createState() => _SearchAddressScreenState();
}

class _SearchAddressScreenState extends PlacesAutocompleteState {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            color: kBackgroundColor.withOpacity(.8),
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Padding(
          padding: const EdgeInsets.only(
            bottom: 4.0,
          ),
          child: AppBarPlacesAutoCompleteTextField(
            textDecoration: const InputDecoration(
              border: InputBorder.none,
              hintText: "Rechercher une adresse",
            ),
            textStyle: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
      ),
      body: PlacesAutocompleteResult(
        onTap: (place) async {
          String placeId = place.placeId ?? "0";

          if (placeId == "0") {
            Navigator.pop(context, null);
            return;
          }

          if (!mounted) return;
          Navigator.pop(context, placeId);
        },
        logo: Stack(
          alignment: Alignment.topCenter,
          fit: StackFit.expand,
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: (MediaQuery.of(context).size.height -
                        MediaQuery.of(context).size.height * 0.3) /
                    6,
              ),
              child: Align(
                alignment: Alignment.topCenter,
                child: Opacity(
                  opacity: 0.05,
                  child: SvgPicture.asset(
                    "assets/logo.svg",
                    fit: BoxFit.contain,
                    width: MediaQuery.of(context).size.width * 0.3,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void onResponseError(PlacesAutocompleteResponse response) {
    super.onResponseError(response);
  }

  @override
  void onResponse(PlacesAutocompleteResponse? response) {
    super.onResponse(response);
  }
}
