import 'package:flutter/material.dart';

class TutorialWidget extends StatelessWidget {
  final IconData icon;
  final String title;

  const TutorialWidget({
    Key? key,
    required this.icon,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.5),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: Colors.white,
            size: 150.0,
          ),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20.0,
            ),
          )
        ],
      ),
    );
  }
}
