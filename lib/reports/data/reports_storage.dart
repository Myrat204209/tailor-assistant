part of 'storage_repository.dart';

/// Storage keys for the [StorageRepository].
abstract class StorageStorageKeys {
  /// The file data stored in external storage.
  static const storedFileData = '__stored_file_data_key__';
}

/// {@template storage_storage}
/// Storage for the [StorageRepository].
/// Manages reading and writing files in external storage.
/// {@endtemplate}
class ReportsStorage {
  /// {@macro storage_storage}
  const ReportsStorage();

  /// Writes data to storage for a given file.
  Future<void> writeFile({
    required String filename,
    required String content,
  }) async {
    try {
      // Use the file system to write to external storage
      final directory = await _getStorageDirectory();
      final file = File('${directory.path}/$filename');
      await file.writeAsString(content);
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(WriteToStorageFailure(error), stackTrace);
    }
  }

  /// Reads data from storage for a given file.
  Future<String?> readFile({required String filename}) async {
    try {
      final directory = await _getStorageDirectory();
      final file = File('${directory.path}/$filename');

      if (await file.exists()) {
        return await file.readAsString();
      } else {
        return null;
      }
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(ReadFromStorageFailure(error), stackTrace);
    }
  }

  /// Deletes a file from external storage.
  Future<void> deleteFile({required String filename}) async {
    try {
      final directory = await _getStorageDirectory();
      final file = File('${directory.path}/$filename');
      if (await file.exists()) {
        await file.delete();
      }
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(WriteToStorageFailure(error), stackTrace);
    }
  }

  /// Helper method to get the external storage directory.
  Future<Directory> _getStorageDirectory() async {
    final directory = await getExternalStorageDirectory();
    if (directory == null) {
      throw DirectoryNotFoundException(
        'Unable to access external storage directory',
      );
    }
    return directory;
  }
}
