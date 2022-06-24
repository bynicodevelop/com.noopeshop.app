import 'package:com_noopeshop_app/widgets/selector_widget.dart';
import 'package:flutter/material.dart';

class ListSizeSelectorWidget extends StatefulWidget {
  final List<Map<String, dynamic>> variantes;

  const ListSizeSelectorWidget({
    Key? key,
    required this.variantes,
  }) : super(key: key);

  @override
  State<ListSizeSelectorWidget> createState() => _VarianteSelectorWidgetState();
}

class _VarianteSelectorWidgetState extends State<ListSizeSelectorWidget> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: widget.variantes.asMap().entries.map(
        (entry) {
          return Padding(
            padding: const EdgeInsets.only(
              right: 16.0,
            ),
            child: GestureDetector(
              onTap: () => setState(() {
                _currentIndex = entry.key;
              }),
              child: SelectorWidget(
                isSelected: entry.key == _currentIndex,
                selector: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 25.0,
                  child: Text(entry.value['size']),
                ),
              ),
            ),
          );
        },
      ).toList(),
    );
  }
}
