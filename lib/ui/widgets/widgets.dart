import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:ticket_sales/ui/theme/theme.dart';

class TextFieldWidet extends StatelessWidget {
  final Widget? prefixIcon;
  final String? inputText;
  final controller = TextEditingController();
  final void Function(String) onChanged;
  final void Function() onTap;
  final String hintText;
  final Widget? sufixIcon;
  final List<TextInputFormatter> inputFormatters;
  final bool readOnly;
  TextFieldWidet({
    super.key,
    required this.hintText,
    required this.onChanged,
    required this.onTap,
    required this.inputText,
    required this.prefixIcon,
    required this.sufixIcon,
    required this.inputFormatters,
    required this.readOnly,
  });

  @override
  Widget build(BuildContext context) {
    controller.text = inputText ?? '';
    controller.selection =
        TextSelection.collapsed(offset: controller.text.length);
    return TextField(
      readOnly: readOnly,
      textAlignVertical: TextAlignVertical.center,
      controller: controller,
      onTap: onTap,
      onChanged: onChanged,
      inputFormatters: inputFormatters,
      style: Theme.of(context).textTheme.titleMedium,
      decoration: InputDecoration(
        suffixIcon: sufixIcon,
        prefixIcon: prefixIcon,
        suffixIconConstraints: const BoxConstraints(),
        isDense: true,
        border: InputBorder.none,
        hintText: hintText,
        hintStyle: Theme.of(context)
            .textTheme
            .titleMedium
            ?.copyWith(color: ThemeApp.greySix),
      ),
    );
  }
}

class GreyContainerWidget extends StatelessWidget {
  final Widget widget;
  final Color color;
  final double radius;
  final double padding;

  const GreyContainerWidget({
    super.key,
    required this.widget,
    required this.color,
    required this.radius,
    required this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: color,
      ),
      child: widget,
    );
  }
}
