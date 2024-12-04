import 'package:permission_handler/permission_handler.dart';

export 'package:permission_handler/permission_handler.dart'
    show PermissionStatus, PermissionStatusGetters;

class PermissionClient {
  const PermissionClient();

  /// Initialize method to check and request permissions when the app starts.
  /// It will ask for permissions that are not already granted.
  Future<void> init() async {
    await _checkAndRequestPermission(Permission.storage);
    await _checkAndRequestPermission(Permission.manageExternalStorage);
    // Add other permissions here as needed
  }

  /// Request a specific permission if not already granted.
  Future<void> _checkAndRequestPermission(Permission permission) async {
    final status = await permission.status;
    if (!status.isGranted) {
      await permission.request();
    }
  }

  /// Request access to storage permissions (for Android < 10),
  /// if access hasn't been previously granted.
  Future<PermissionStatus> requestStoragePermissions() async {
    final storageStatus = await Permission.storage.request();
    if (storageStatus.isDenied || storageStatus.isPermanentlyDenied) {
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

  /// Returns the current permission status for `MANAGE_EXTERNAL_STORAGE` (Android 10+).
  Future<PermissionStatus> manageExternalStorageStatus() =>
      Permission.manageExternalStorage.status;

  /// Opens the app settings page.
  Future<bool> openPermissionSettings() => openAppSettings();
}
