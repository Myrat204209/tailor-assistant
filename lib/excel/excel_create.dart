import 'dart:developer';
import 'dart:io';

import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart' as xlsio;

Future<void> createAndSaveExcelFile() async {
  // Create a workbook
  final workbook = xlsio.Workbook();

  // Access the first worksheet
  final sheet = workbook.worksheets[0];

  // Leave A1 empty and merge B1:D1 for Order Name
  const orderName = 'Order ABC';
  sheet.getRangeByName('B1:D1').merge(); // Merge cells for order name
  sheet.getRangeByName('B1').setText(orderName);
  sheet.getRangeByName('B1').cellStyle.bold = true;
  sheet.getRangeByName('B1').cellStyle.hAlign = xlsio.HAlignType.center;

  // Column headers (Operations)
  const operations = <String>['Operation 1', 'Operation 2', 'Operation 3'];
  for (var i = 0; i < operations.length; i++) {
    sheet.getRangeByIndex(2, i + 2).setText(operations[i]);
    sheet.getRangeByIndex(2, i + 2).cellStyle.bold = true;
    sheet.getRangeByIndex(2, i + 2).cellStyle.hAlign = xlsio.HAlignType.center;
  }

  // Row headers (Employees) and sample data
  const employees = <String>['Employee 1', 'Employee 2', 'Employee 3'];
  const data = <List<int>>[
    [5, 3, 7], // Quantities for Employee 1
    [2, 4, 1], // Quantities for Employee 2
    [6, 8, 5], // Quantities for Employee 3
  ];

  for (var i = 0; i < employees.length; i++) {
    // Set employee name
    sheet.getRangeByIndex(i + 3, 1).setText(employees[i]);
    sheet.getRangeByIndex(i + 3, 1).cellStyle.bold = true;

    // Set data for each operation
    for (var j = 0; j < operations.length; j++) {
      sheet.getRangeByIndex(i + 3, j + 2).number = data[i][j].toDouble();
    }
  }

  // Save the workbook
  final bytes = workbook.saveAsStream();
  workbook.dispose();

  // Save the file locally
  final directory = await getApplicationDocumentsDirectory();
  final path = '${directory.path}/OrderDetails.xlsx';
  final file = File(path);
  await file.writeAsBytes(bytes, flush: true);

  // Open the file
  log('Opening...........$path ');
  await OpenFile.open(path);
}
