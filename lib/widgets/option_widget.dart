import 'package:com_noopeshop_app/config/constants.dart';
import 'package:com_noopeshop_app/models/option_model.dart';
import 'package:flutter/material.dart';

class OptionWidget extends StatelessWidget {
  final OptionModel optionModel;
  final Function(OptionModel) onSelected;
  final bool isSelected;

  const OptionWidget({
    Key? key,
    required this.optionModel,
    required this.onSelected,
    this.isSelected = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50.0,
      height: 50.0,
      child: Padding(
        padding: const EdgeInsets.all(
          2.0,
        ),
        child: SizedBox(
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
                child: Material(
                  shape: const CircleBorder(),
                  clipBehavior: Clip.hardEdge,
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () => onSelected(optionModel),
                    child: CircleAvatar(
                      backgroundColor: Colors.transparent,
                      radius: 25.0,
                      child: Text(
                        optionModel.key,
                        style: const TextStyle(
                          color: kBackgroundColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
