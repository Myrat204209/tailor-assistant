// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// App card
class AppCard extends StatelessWidget {
  /// Constructor
  const AppCard({
    required this.orderName,
    required this.orderId,
    required this.contents,
    super.key,
  });

  final String orderName;
  final String orderId;

  final Map<String, List<String>> contents;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return SizedBox(
      child: Card(
        shape: ShapeBorderX.roundedRectangle(15),
        color: AppColors.bgSecond,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '...',
              style: const AppTextStyle.display().headline1().copyWith(
                    letterSpacing: 5,
                    height: 0.6,
                    color: AppColors.thirdLightAccent,
                  ),
            ),
            SizedBox(
              width: width * 0.779,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    orderId,
                    style: const AppTextStyle.text()
                        .headline5()
                        .xl()
                        .withColor(AppColors.majorAccent),
                  ).centralize(),
                  SizedBox(
                    width: (width * 0.779) * 0.413,
                    child: const ColoredBox(
                      color: AppColors.mainAccent,
                    ),
                  ),
                ],
              ).paddingSymmetric(vertical: 6),
            )
                .colorize(AppColors.thirdLightAccent)
                .clipper(100)
                .paddingOnly(right: 24, left: 68),
            Text(
              orderName,
              style: const AppTextStyle.text().headline5(),
            ).paddingSymmetric(vertical: 15),
            ...contents.entries.map(
              (e) => AppCardRichText(title: e.key, values: e.value),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    DateFormat('dd/MM/yyyy').format(DateTime.now()),
                    style: const AppTextStyle.text()
                        .subtitle1()
                        .md()
                        .copyWith(color: AppColors.thirdAccent, height: 0.6),
                  ).paddingOnly(right: 10),
                  SizedBox.square(
                    dimension: 30,
                    child: const ColoredBox(
                      color: AppColors.majorLightAccent,
                    ).clipperOnly(13),
                  ),
                ],
              ),
            ),
          ],
        ).paddingOnly(left: 15),
      ).paddingSymmetric(vertical: 24, horizontal: 20),
    );
  }
}

class AppCardRichText extends StatelessWidget {
  const AppCardRichText({
    required this.title,
    required this.values,
    super.key,
  });
  final String title;
  final List<String> values;
  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: '$title: ', // Text before the colon
            style: const AppTextStyle.text()
                .subtitle1()
                .lg()
                .withColor(AppColors.textLight),
          ),
          TextSpan(
            text: values
                .map(
                  (word) => word != values.last ? '$word, ' : word,
                )
                .join(), // Text after the colon
            style: const AppTextStyle.text()
                .subtitle1()
                .lg()
                .withColor(AppColors.textLightTitle),
          ),
        ],
      ),
    ).paddingOnly(bottom: 5);
  }
}
