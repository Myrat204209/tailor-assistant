part of 'app_card.dart';

/// Decoration widget for top corner of card widget
class CardTopCornerDecoration extends StatelessWidget {
  /// Constructor
  const CardTopCornerDecoration({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      '...',
      style: const AppTextStyle.display().pageTitleBold().copyWith(
            letterSpacing: 5,
            fontSize: 30,
            height: 0.6,
            color: AppColors.thirdLightAccent,
          ),
    );
  }
}

/// Decoration widget of card widget
class CardCornerDecoration extends StatelessWidget {
  /// Constructor
  const CardCornerDecoration({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            DateFormat('dd/MM/yyyy').format(DateTime.now()),
            style: const AppTextStyle.text()
                .description()
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
    );
  }
}
