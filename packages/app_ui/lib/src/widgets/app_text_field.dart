import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    required this.controller,
    required this.titleText,
    required this.hintText,
    this.isClose = false,
    super.key,
  });

  final bool isClose;
  final TextEditingController controller;
  final String titleText;
  final String hintText;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          child: ColoredBox(
            color: AppColors.bgSecond,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      titleText,
                      style: const AppTextStyle.text().lg().regular(),
                    ),
                    if (isClose)
                      IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {},
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
                  textAlign: isClose ? TextAlign.end : TextAlign.start,
                  decoration: InputDecoration(
                    hintText: hintText,
                    contentPadding: const EdgeInsets.all(14),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(color: AppColors.border),
                    ),
                  ),
                ),
              ],
            ).paddingAll(20),
          ),
        ),
        const Divider(
          height: 2,
          color: AppColors.secondAccent,
        ),
      ],
    );
  }
}
