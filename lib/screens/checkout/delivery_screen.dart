import 'package:com_noopeshop_app/config/functions/translate.dart';
import 'package:flutter/material.dart';

class DeliveryScreen extends StatelessWidget {
  const DeliveryScreen({Key? key}) : super(key: key);

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
