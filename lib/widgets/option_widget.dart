import 'package:com_noopeshop_app/config/constants.dart';
import 'package:com_noopeshop_app/models/option_model.dart';
import 'package:flutter/material.dart';

class OptionWidget extends StatelessWidget {
  final String optionType;
  final OptionModel optionModel;
  final Function(OptionModel) onSelected;
  final bool isSelected;

  const OptionWidget({
    Key? key,
    required this.optionType,
    required this.optionModel,
    required this.onSelected,
    this.isSelected = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: optionType == "size" ? 40.0 : 90.0,
      height: 40.0,
      child: Padding(
        padding: const EdgeInsets.all(
          2.0,
        ),
        child: SizedBox(
          width: 90.0,
          height: 40.0,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: AnimatedContainer(
              duration: const Duration(
                milliseconds: 300,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
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
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  clipBehavior: Clip.hardEdge,
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () => onSelected(optionModel),
                    child: ClipRRect(
                      // backgroundColor: Colors.transparent,
                      // radius: 25.0,
                      borderRadius: BorderRadius.circular(10.0),
                      child: Center(
                        child: Text(
                          optionType == "size"
                              ? optionModel.key
                              : optionModel.value,
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
      ),
    );
  }
}
