import 'package:com_noopeshop_app/config/constants.dart';
import 'package:flutter/material.dart';

class MainButton extends StatelessWidget {
  final Function()? onPressed;
  final String label;

  const MainButton({
    Key? key,
    required this.onPressed,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 55.0,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          primary: kDefaultColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
        ),
        child: Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16.0,
            letterSpacing: 1.1,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
