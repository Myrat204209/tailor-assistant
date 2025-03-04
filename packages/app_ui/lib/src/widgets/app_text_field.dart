// ignore_for_file:  sort_constructors_first
// ignore_for_file: public_member_api_docs

import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    required this.titleText,
    required this.colorScheme,
    required this.hintText,
    super.key,
    this.textFieldKey,
    this.isClose = false,
    this.controller,
    this.errorText,
    this.onChanged,
    this.onSubmitted,
    this.onRemove,
    this.isNext = false,
    this.focusNode,
  });

  final Key? textFieldKey;
  final bool isClose;
  final TextEditingController? controller;
  final String titleText;
  final ColorScheme colorScheme;
  final String hintText;
  final String? errorText;
  // ignore: inference_failure_on_function_return_type
  final Function(String)? onChanged;
  // ignore: inference_failure_on_function_return_type
  final Function(String)? onSubmitted;
  final VoidCallback? onRemove;
  final bool isNext;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      titleText,
                      softWrap: true,
                      style: const AppTextStyle.text().lg().regular(),
                    ),
                  ),
                  if (isClose)
                    IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: onRemove,
                      icon: const Icon(
                        Icons.close,
                        size: 25,
                        color: AppColors.alertAccent,
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 14),
              TextField(
                obscureText: isClose == false && !isNext,
                onSubmitted: onSubmitted,
                key: textFieldKey,
                onChanged: onChanged,
                textInputAction:
                    isNext ? TextInputAction.next : TextInputAction.done,
                controller: controller,
                focusNode: focusNode,
                keyboardType:
                    isClose ? TextInputType.number : TextInputType.text,
                textAlign: isClose ? TextAlign.end : TextAlign.start,
                decoration: InputDecoration(
                  hintText: hintText,
                  errorText: errorText,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(
                      color: colorScheme.onPrimary,
                    ),
                  ),
                ),
              ),
            ],
          ).paddingAll(20).colorize(colorScheme.surface),
        ),
        const Divider(height: 0.1),
      ],
    );
  }
}
