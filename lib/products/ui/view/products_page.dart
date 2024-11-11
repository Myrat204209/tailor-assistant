import 'dart:developer';

import 'package:animated_button_bar/animated_button_bar.dart';
import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});
  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const ProductsPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Изделия',
                style: const AppTextStyle.text().headline5(),
              ).paddingOnly(left: 20, right: 5),
              Text(
                '10',
                style: const AppTextStyle.text()
                    .subtitle1()
                    .withColor(Colors.white),
              )
                  .paddingSymmetric(vertical: 4, horizontal: 14)
                  .colorize(AppColors.alertAccent)
                  .clipper(15),
              const Spacer(),
              IconButton.filled(
                padding: const EdgeInsets.all(15),
                color: AppColors.majorAccent,
                onPressed: () {},
                icon: const Icon(
                  Icons.cached,
                  size: 30,
                  color: AppColors.secondAccent,
                ),
              ).paddingOnly(
                right: 10,
              ),
              IconButton.filled(
                padding: const EdgeInsets.all(15),
                color: AppColors.majorAccent,
                onPressed: () {},
                icon: const Icon(
                  Icons.logout,
                  size: 30,
                  color: AppColors.secondAccent,
                ),
              ).paddingOnly(
                right: 10,
              ),
              IconButton.filled(
                padding: const EdgeInsets.all(15),
                onPressed: () {},
                icon: const Icon(
                  Icons.dark_mode_rounded,
                  size: 30,
                  color: AppColors.secondAccent,
                ),
              ).paddingOnly(
                right: 20,
              ),
            ],
          ).paddingOnly(top: 30),
          const AppCard(
            orderName: 'Рубашка мужская',
            orderId: 'НФCB-000002',
            contents: contents,
          ),
          const Spacer(),
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              width: 155,
              height: 80,
              child: AnimatedButtonBar(
                radius: 50,
                backgroundColor: AppColors.secondAccent,
                foregroundColor: AppColors.mainAccent,
                elevation: 20,
                children: [
                  ButtonBarEntry(
                    onTap: () => log('First item tapped'),
                    child: const Icon(
                      Icons.dry_cleaning_rounded,
                      size: 35,
                      color: AppColors.mainAccent,
                    ),
                  ),
                  ButtonBarEntry(
                    onTap: () => log('First item tapped'),
                    child: const Icon(
                      Icons.person_3_rounded,
                      size: 35,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ).paddingOnly(bottom: 40),
          ),
        ],
      ),
    );
  }
}

const Map<String, List<String>> contents = {
  'Цвет': ['Экру', 'Бежевый', 'Черный', 'Темно синий', 'Мышиный'],
  'Коллекция': [
    'Urban SPRING 24',
  ],
  'Вышивка': ['Atlyjam'],
  'Ткань': [
    'Poplin',
  ],
};
