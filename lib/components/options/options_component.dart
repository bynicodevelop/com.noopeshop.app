import 'package:com_noopeshop_app/components/options/options/options_bloc.dart';
import 'package:com_noopeshop_app/models/option_model.dart';
import 'package:com_noopeshop_app/widgets/option_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OptionsComponent extends StatelessWidget {
  final List<OptionModel> options;
  final Function(OptionModel) onSelectOption;

  const OptionsComponent({
    Key? key,
    required this.options,
    required this.onSelectOption,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OptionsBloc, OptionsState>(
      builder: (context, state) {
        if ((state as OptionsInitialState).optionModel.isEmpty) {
          return const SizedBox.shrink();
        }

        final OptionModel currentOption = (state).optionModel;

        return Row(
          children: options.map((optionModel) {
            return Padding(
              padding: const EdgeInsets.only(
                right: 16.0,
              ),
              child: OptionWidget(
                optionModel: optionModel,
                onSelected: (optionModel) {
                  context.read<OptionsBloc>().add(
                        OnChangeOptionsEvent(
                          option: optionModel,
                        ),
                      );

                  onSelectOption(optionModel);
                },
                isSelected: currentOption.key == optionModel.key,
              ),
            );
          }).toList(),
        );
      },
    );
  }
}
