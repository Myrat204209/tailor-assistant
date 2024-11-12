part of 'app_card.dart';

/// Card content text creator widget
class AppCardRichText extends StatelessWidget {
  /// Constructor
  const AppCardRichText({
    required this.title,
    required this.values,
    super.key,
  });

  /// Title for content of card
  final String title;

  /// Values for specific title of card
  final List<String> values;
  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: '$title: ', // Text before the colon
            style: const AppTextStyle.text()
                .title()
                .withColor(AppColors.textLight),
          ),
          TextSpan(
            text: values
                .map(
                  (word) => word != values.last ? '$word, ' : word,
                )
                .join(), // Text after the colon
            style: const AppTextStyle.text()
                .description()
                .withColor(AppColors.textLightTitle),
          ),
        ],
      ),
    ).paddingOnly(bottom: 5);
  }
}
