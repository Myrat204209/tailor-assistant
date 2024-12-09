// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app_ui/app_ui.dart';

import 'package:dap_foreman_assis/auth/auth.dart';
import 'package:dap_foreman_assis/orders/orders.dart';
import 'package:dap_foreman_assis/theme_selector/theme_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class OrdersAppBar extends HookWidget {
  const OrdersAppBar({
    required this.quantity,
    super.key,
  });
  final int quantity;
  @override
  Widget build(BuildContext context) {
    final themeBloc = context.select((ThemeModeBloc bloc) => bloc.state);
    final colorScheme = Theme.of(useContext()).colorScheme;
    return UiAppBar(
      title: 'Изделия',
      quantity: quantity,
      colorScheme: colorScheme,
      icons: [
        UiAppBarIcon(
          icon: Icons.cached_rounded,
          onTap: () {
            showAppDialog(
              context,
              'После обновления будут стёрты заполненные данные?',
              'Обновить',
              () => context.read<OrdersBloc>().add(const OrdersRequested()),
            );
          },
        ),
        UiAppBarIcon(
          icon: Icons.logout_rounded,
          onTap: () {
            showAppDialog(context, 'Выйти из аккаунта?', 'Выход', () {
              context.read<AuthBloc>().add(AuthLogoutRequested());
              // Navigator.of(context)
              //     .popUntil((route) => route.settings.name == '/login');
            });
          },
        ),
        UiAppBarIcon(
            icon: themeBloc == ThemeMode.dark
                ? Icons.light_mode_rounded
                : Icons.dark_mode_rounded,
            onTap: () =>
                context.read<ThemeModeBloc>().add(const ThemeModeChanged())),
      ],
    );
  }
}
