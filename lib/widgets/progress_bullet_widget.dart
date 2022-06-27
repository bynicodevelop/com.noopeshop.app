import 'package:com_noopeshop_app/config/constants.dart';
import 'package:flutter/material.dart';

class ProgressBulletWidget extends StatelessWidget {
  final bool isFirst;
  final bool isActive;

  const ProgressBulletWidget({
    Key? key,
    this.isFirst = false,
    this.isActive = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (!isFirst)
          AnimatedContainer(
            duration: const Duration(
              milliseconds: 300,
            ),
            height: 2.0,
            width: 25.0,
            color: isActive ? kDefaultColor : kBackgroundColor.withOpacity(.1),
          ),
        AnimatedContainer(
          duration: const Duration(
            milliseconds: 300,
          ),
          height: 30.0,
          width: 30.0,
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: isActive ? kDefaultColor : kBackgroundColor.withOpacity(.1),
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
