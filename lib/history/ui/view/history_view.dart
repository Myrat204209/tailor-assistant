import 'dart:io';

import 'package:app_ui/app_ui.dart';
import 'package:dap_foreman_assis/excel/excel.dart';
import 'package:dap_foreman_assis/history/history.dart';
import 'package:flutter/material.dart';

class HistoryView extends StatelessWidget {
  const HistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    // final colorScheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const HistoryAppBar(),
        Expanded(
            child: FutureBuilder<List<File>>(
          future: listExcelFiles(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator.adaptive().centralize();
            }
            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Text(
                'Нет отправленных отчетов',
                style: const AppTextStyle.text().pageTitle(),
              ).centralize();
            }

            final files = snapshot.data!;
            return ListView.builder(
              itemCount: files.length,
              itemBuilder: (context, index) {
                final file = files[index];
                return HistoryTile(
                  name: file.path.split('/').last,
                  onTap: () => openExcelFile(file.path),
                );
              },
            );
          },
        )),
      ],
    );
  }
}
