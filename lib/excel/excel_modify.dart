import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

/// Function to list all Excel files in the local storage directory
Future<List<File>> listExcelFiles() async {
  // Get the directory where files are saved
  final directory = await getApplicationDocumentsDirectory();

  // List all files in the directory
  final excelFiles = <File>[];
  final files = directory.listSync();
  for (final file in files) {
    if (file is File && file.path.endsWith('.xlsx')) {
      excelFiles.add(file);
    }
  }
  return excelFiles;
}

/// Function to open a selected file
Future<void> openExcelFile(String filePath) async {
  final result = await OpenFile.open(filePath);
  if (result.type != ResultType.done) {
    print('Error opening file: ${result.message}');
  }
}

/// Example usage to display a file picker and open a selected Excel file
Future<void> browseAndOpenExcelFile() async {
  // Browse and list all Excel files
  final excelFiles = await listExcelFiles();

  // Use FilePicker or a custom UI to allow the user to select one
  final selectedPath = await FilePicker.platform
      .pickFiles(
        initialDirectory: (await getApplicationDocumentsDirectory()).path,
        allowedExtensions: ['xlsx'],
        type: FileType.custom,
      )
      .then((result) => result?.files.single.path);

  // Open the selected file
  if (selectedPath != null) {
    await openExcelFile(selectedPath);
  } else {
    print('No file selected.');
  }
}
