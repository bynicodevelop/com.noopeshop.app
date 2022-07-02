import 'package:com_noopeshop_app/config/constants.dart';
import 'package:flutter/material.dart';

class SelectorWidget extends StatelessWidget {
  final Widget selector;
  final bool isSelected;

  const SelectorWidget({
    Key? key,
    required this.selector,
    this.isSelected = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50.0,
      height: 50.0,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(50.0),
        child: AnimatedContainer(
          duration: const Duration(
            milliseconds: 300,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50.0),
            color: Colors.white,
            border: Border.all(
              color: isSelected
                  ? kBackgroundColor.withOpacity(.6)
                  : Colors.transparent,
              width: 1.0,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(
              2.0,
            ),
            child: selector,
          ),
        ),
      ),
    );
  }
}
