import 'package:dap_foreman_assis/app/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final themeCubit = ThemeCubit()..loadTheme();
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: themeCubit),
      ],
      child: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return ScreenUtilInit(
              designSize: Size(constraints.maxWidth, constraints.maxHeight),
              builder: (context, child) => const AppView(),
            );
          },
        ),
      ),
    );
  }
}
