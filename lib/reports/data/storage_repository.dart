import 'dart:async';
import 'dart:io';

import 'package:data_provider/data_provider.dart';
import 'package:equatable/equatable.dart';
import 'package:path_provider/path_provider.dart'; // For accessing the file system

part 'reports_storage.dart'; // For reading and writing file operations

/// {@template storage_failure}
/// A base failure for the storage repository failures.
/// {@endtemplate}
abstract class StorageFailure with EquatableMixin implements Exception {
  const StorageFailure(this.error);

  final Object error;

  @override
  List<Object> get props => [error];
}

/// {@template initialize_storage_failure}
/// Thrown when initializing storage preferences fails.
/// {@endtemplate}
class InitializeStorageFailure extends StorageFailure {
  const InitializeStorageFailure(super.error);
}

/// {@template write_to_storage_failure}
/// Thrown when writing to storage fails.
/// {@endtemplate}
class WriteToStorageFailure extends StorageFailure {
  const WriteToStorageFailure(super.error);
}

/// {@template read_from_storage_failure}
/// Thrown when reading from storage fails.
/// {@endtemplate}
class ReadFromStorageFailure extends StorageFailure {
  const ReadFromStorageFailure(super.error);
}

/// {@template storage_repository}
/// A repository that manages file operations (read/write) to external storage.
/// It requests permission to access the external storage before performing the operations.
/// {@endtemplate}
class StorageRepository {
  StorageRepository({
    required PermissionClient permissionClient,
  }) : _permissionClient = permissionClient;

  final PermissionClient _permissionClient;
  // final ReportsStorage _storage;

  /// Request permission to read and write from external storage.
  Future<void> requestPermission() async {
    // Check Android version to request the correct permission
    if (Platform.isAndroid) {
      if (await _isAndroid10OrAbove()) {
        // For Android 10 and above, request "MANAGE_EXTERNAL_STORAGE"
        final status =
            await _permissionClient.requestManageExternalStoragePermission();
        if (!status.isGranted) {
          throw Exception(
            'Storage permission (MANAGE_EXTERNAL_STORAGE) denied',
          );
        }
      } else {
        final status = await _permissionClient.requestStoragePermissions();
        if (!status.isGranted) {
          throw Exception('Storage permission denied');
        }
      }
    }
  }

  /// Write data to the external storage (file).
  Future<void> writeToStorage(String filename, String content) async {
    try {
      // Request permission to access the storage.
      await requestPermission();

      // Get the directory for storing the file.
      final directory = await _getStorageDirectory();
      final file = File('${directory.path}/$filename');

      // Write content to the file.
      await file.writeAsString(content);
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(WriteToStorageFailure(error), stackTrace);
    }
  }

  /// Read data from the external storage (file).
  Future<String> readFromStorage(String filename) async {
    try {
      // Request permission to access the storage.
      await requestPermission();

      // Get the directory for accessing the file.
      final directory = await _getStorageDirectory();
      final file = File('${directory.path}/$filename');

      // Read the content of the file.
      if (file.existsSync()) {
        return await file.readAsString();
      } else {
        throw FileNotFoundException('File not found');
      }
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(ReadFromStorageFailure(error), stackTrace);
    }
  }

  /// Get the directory where files are stored on external storage.
  Future<Directory> _getStorageDirectory() async {
    final directory = await getExternalStorageDirectory();
    if (directory == null) {
      throw DirectoryNotFoundException(
        'Unable to access external storage directory',
      );
    }
    return directory;
  }

  /// Check if the Android version is 10 or above.
  Future<bool> _isAndroid10OrAbove() async {
    if (Platform.isAndroid) {
      final version = int.parse(
        Platform.operatingSystemVersion.split(' ')[0].split('.').first,
      );
      return version >= 10;
    }
    return false;
  }
}

/// Custom Exception: File Not Found
class FileNotFoundException implements Exception {
  FileNotFoundException(this.message);
  final String message;
}

/// Custom Exception: Directory Not Found
class DirectoryNotFoundException implements Exception {
  DirectoryNotFoundException(this.message);
  final String message;
}
