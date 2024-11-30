import 'package:permission_handler/permission_handler.dart';

export 'package:permission_handler/permission_handler.dart'
    show PermissionStatus, PermissionStatusGetters;

/// {@template permission_client}
/// A client that handles requesting permissions on a device.
/// {@endtemplate}
class PermissionClient {
  /// {@macro permission_client}
  const PermissionClient();

  /// Request access to storage permissions (for Android < 10),
  /// if access hasn't been previously granted.
  Future<PermissionStatus> requestStoragePermissions() async {
    // Request for storage permissions
    final storageStatus = await Permission.storage.request();
    if (storageStatus.isDenied || storageStatus.isPermanentlyDenied) {
      // If denied, you can open app settings for the user to grant manually
      await openAppSettings();
    }
    return storageStatus;
  }

  /// Request for the `MANAGE_EXTERNAL_STORAGE` permission (for Android 10+)
  /// if broader storage access is needed.
  Future<PermissionStatus> requestManageExternalStoragePermission() async {
    final manageExternalStorageStatus =
        await Permission.manageExternalStorage.request();
    if (manageExternalStorageStatus.isDenied ||
        manageExternalStorageStatus.isPermanentlyDenied) {
      await openAppSettings();
    }
    return manageExternalStorageStatus;
  }

  /// Returns the current permission status for storage.
  Future<PermissionStatus> storageStatus() => Permission.storage.status;

  /// Returns the current permission status for `MANAGE_EXTERNAL_STORAGE`.
  Future<PermissionStatus> manageExternalStorageStatus() =>
      Permission.manageExternalStorage.status;

  /// Opens the app settings page.
  ///
  /// Returns true if the settings could be opened, otherwise false.
  Future<bool> openPermissionSettings() => openAppSettings();
}
