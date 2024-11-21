// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'app_card.dart';

/// Decoration widget for top corner of card widget
class CardTopCornerDecoration extends StatelessWidget {
  /// Constructor
  const CardTopCornerDecoration({
    required this.cornerTopColor,
    super.key,
  });
  final Color cornerTopColor;
  @override
  Widget build(BuildContext context) {
    return Text(
      '...',
      style: const AppTextStyle.display().pageTitleBold().copyWith(
            letterSpacing: 5,
            fontSize: 30,
            height: 0.6,
            color: cornerTopColor,
          ),
    );
  }
}

/// Decoration widget of card widget
class CardCornerDecoration extends StatelessWidget {
  /// Constructor
  const CardCornerDecoration({
    required this.cornerColor,
    required this.startOrder,
    super.key,
  });
  final Color cornerColor;
  final String startOrder;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            formatDate(startOrder),
            style: const AppTextStyle.text()
                .description()
                .copyWith(color: AppColors.thirdAccent, height: 0.6),
          ).paddingOnly(right: 10),
          SizedBox.square(
            dimension: 30,
            child: ColoredBox(
              color: cornerColor,
            ).clipperOnly(13),
          ),
        ],
      ),
    );
  }
}

String formatDate(String inputDate) {
  final dateTime = DateTime.parse(inputDate);
  final formatter = DateFormat('dd/MM/yyyy');
  return formatter.format(dateTime);
}
