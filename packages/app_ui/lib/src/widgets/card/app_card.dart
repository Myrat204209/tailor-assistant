// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

part 'card_corner_decoration.dart';
part 'card_rich_text.dart';

/// App card
class AppCard extends StatelessWidget {
  /// Constructor
  const AppCard({
    required this.startOrder,
    required this.orderName,
    required this.orderId,
    required this.contents,
    required this.quantity,
    required this.colorScheme,
    super.key,
  });
  final String startOrder;
  final String orderName;
  final String orderId;

  final Map<String, List<String>> contents;
  final int quantity;
  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;

    return Card(
      shape: ShapeBorderX.roundedRectangle(15),
      color: colorScheme.surface,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CardTopCornerDecoration(
            cornerTopColor: colorScheme.onTertiary,
          ),
          SizedBox(
            width: width * 0.779,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  flex: 3,
                  child: Text(
                    orderId,
                    style: const AppTextStyle.text()
                        .description()
                        .withColor(colorScheme.secondary),
                  ).centralize(),
                ),
                Expanded(
                  flex: 2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        quantity.toString(),
                        style: const AppTextStyle.text()
                            .titleBold()
                            .withColor(colorScheme.primary),
                      )
                          .paddingSymmetric(vertical: 6, horizontal: 16)
                          .colorizeClip(colorScheme.onPrimary, 100),
                    ],
                  ).colorizeClip(colorScheme.onSecondary, 100),
                ),
              ],
            ),
          )
              .colorizeClip(colorScheme.onTertiary, 100)
              .paddingOnly(right: 24, left: 68),
          Text(
            orderName,
            softWrap: true,
            style: const AppTextStyle.text()
                .contentTitle()
                .withColor(colorScheme.onSurface),
          ).paddingSymmetric(vertical: 15),
          ...contents.entries.where((e) => e.value.isNotEmpty).map(
                (e) => AppCardRichText(
                  title: e.key,
                  values: e.value,
                  colorScheme: colorScheme,
                ),
              ),
          CardCornerDecoration(
            startOrder: startOrder,
            cornerColor: colorScheme.onSecondary,
          ),
        ],
      ).paddingOnly(left: 15),
    ).paddingSymmetric(horizontal: 20);
  }
}
