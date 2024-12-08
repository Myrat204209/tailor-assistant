// ignore_for_file: public_member_api_docs

part of 'app_card.dart';

class AppCardRichText extends StatelessWidget {
  const AppCardRichText({
    required this.title,
    required this.values,
    required this.colorScheme, // Add text color as a parameter
    super.key,
  });

  final String title;
  final List<String?> values;
  final ColorScheme colorScheme; // Dynamic text color

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: '$title: ',
              style: const AppTextStyle.text()
                  .description()
                  .withColor(colorScheme.outline),
            ),
            TextSpan(
              text: values.join(', '),
              style: const AppTextStyle.text()
                  .description()
                  .withColor(colorScheme.shadow), // Use dynamic color
            ),
          ],
        ),
      ),
    );
  }
}
