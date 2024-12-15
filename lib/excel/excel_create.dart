// ignore_for_file: lines_longer_than_80_chars

import 'dart:developer';
import 'dart:io';

import 'package:data_provider/data_provider.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart';

Future<void> exportReportItemsToExcel(List<ReportItem> reportItems) async {
  // Create workbook and worksheet
  final workbook = Workbook();
  final sheet = workbook.worksheets[0];

  // Set fixed header row labels (№, Швея, Изделия, Операция, Количество)
  final fixedHeader = ['№', 'Швея', 'Изделия', 'Операция', 'Количество'];
  for (var colIndex = 1; colIndex <= fixedHeader.length; colIndex++) {
    sheet.getRangeByIndex(1, colIndex).setText(fixedHeader[colIndex - 1]);
  }
  
  // Freeze the first row (header)
  // sheet.freezePanes(1, 1, 1, fixedHeader.length);

  // Extract unique items and operations
  var index = 2;
  for (final report in reportItems) {
    sheet.getRangeByIndex(index, 1).setNumber(index - 1);
    sheet.getRangeByIndex(index, 2).setText(report.employeeName);
    sheet.getRangeByIndex(index, 3).setText(report.itemName);
    sheet.getRangeByIndex(index, 4).setText(report.workName);
    sheet
        .getRangeByIndex(index, 5)
        .setNumber(report.workQuantity?.toDouble() ?? 0);
    index++;
  }

  // Save the workbook
  final bytes = workbook.saveAsStream();
  workbook.dispose();

  // Generate the dynamic filename
  final now = DateTime.now();
  final formattedDate =
      '${now.day.toString().padLeft(2, '0')}-${now.month.toString().padLeft(2, '0')}-${now.year}';
  final formattedTime =
      '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}';
  final fileName = 'Report_${formattedDate}_$formattedTime.xlsx';

  // Use the path_provider package to get the directory to store the file
  final directory = await getApplicationDocumentsDirectory();
  final path = '${directory.path}/$fileName';

  // Write the file to local storage
  final file = File(path);
  await file.writeAsBytes(bytes);

  log('Excel file saved at $path');
  // Code to save the file locally or share (e.g., using file picker)
}
