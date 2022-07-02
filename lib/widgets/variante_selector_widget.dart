import 'package:com_noopeshop_app/models/variante_model.dart';
import 'package:com_noopeshop_app/widgets/selector_widget.dart';
import 'package:flutter/material.dart';

class VarianteSelectorWidget extends StatefulWidget {
  final List<VarianteModel> variantes;
  final VarianteModel selectedVariante;
  final Function(VarianteModel) onSelected;

  const VarianteSelectorWidget({
    Key? key,
    required this.variantes,
    required this.selectedVariante,
    required this.onSelected,
  }) : super(key: key);

  @override
  State<VarianteSelectorWidget> createState() => _VarianteSelectorWidgetState();
}

class _VarianteSelectorWidgetState extends State<VarianteSelectorWidget> {
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
                widget.onSelected(entry.value);
              }),
              child: SelectorWidget(
                isSelected: entry.value.id == widget.selectedVariante.id,
                selector: CircleAvatar(
                  backgroundImage: NetworkImage(entry.value.media),
                  backgroundColor: Colors.transparent,
                  radius: 25.0,
                ),
              ),
            ),
          );
        },
      ).toList(),
    );
  }
}
