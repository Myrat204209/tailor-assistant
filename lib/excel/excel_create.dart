import 'dart:developer';
import 'dart:io';

import 'package:data_provider/data_provider.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart';

Future<void> exportReportItemsToExcel(List<ReportItem> reportItems) async {
  // Group data by employee and item
  final groupedData = <String, Map<String, List<ReportItem>>>{};
  for (final item in reportItems) {
    groupedData.putIfAbsent(item.employeeName!, () => {});
    groupedData[item.employeeName!]!.putIfAbsent(item.itemName!, () => []);
    groupedData[item.employeeName!]![item.itemName!]!.add(item);
  }

  // Extract unique items and operations
  final itemOperations = <String, List<String>>{};
  for (final item in reportItems) {
    itemOperations.putIfAbsent(item.itemName!, () => []);
    if (!itemOperations[item.itemName!]!.contains(item.workName)) {
      itemOperations[item.itemName!]!.add(item.workName!);
    }
  }

  // Create workbook and worksheet
  final workbook = Workbook();
  final sheet = workbook.worksheets[0];

  // Add the main header "Orders"
  sheet.getRangeByIndex(1, 1).setText('Orders');

  var colIndex = 2;

  // Set item headers with merged cells for operations
  for (final entry in itemOperations.entries) {
    final itemName = entry.key;
    final operations = entry.value;

    // Merge cells for the item name
    sheet
        .getRangeByIndex(1, colIndex, 1, colIndex + operations.length - 1)
        .merge();
    sheet.getRangeByIndex(1, colIndex).setText(itemName);

    // Add operation headers below the item
    for (final operation in operations) {
      sheet.getRangeByIndex(2, colIndex).setText(operation);
      colIndex++;
    }
  }

  // Add "EmpName/OperName" in the first column of the second row
  sheet.getRangeByIndex(2, 1).setText('EmpName/OperName');

  // Populate rows with employee data
  var rowIndex = 3;
  for (final employeeEntry in groupedData.entries) {
    final employeeName = employeeEntry.key;
    final items = employeeEntry.value;

    // Set employee name
    sheet.getRangeByIndex(rowIndex, 1).setText(employeeName);

    colIndex = 2;

    // Add data for each item and operation
    for (final itemEntry in itemOperations.entries) {
      final itemName = itemEntry.key;
      final operations = itemEntry.value;

      // Find corresponding ReportItems for this employee and item
      final reportItems = items[itemName];

      // Map operation names to quantities
      final operationQuantities = <String, int>{};
      if (reportItems != null) {
        for (final reportItem in reportItems) {
          operationQuantities[reportItem.workName!] = reportItem.workQuantity!;
        }
      }

      // Add quantities or placeholder
      for (final operation in operations) {
        final quantity = operationQuantities[operation];
        sheet
            .getRangeByIndex(rowIndex, colIndex)
            .setText(quantity != null ? quantity.toString() : '-');
        colIndex++;
      }
    }
    rowIndex++;
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
