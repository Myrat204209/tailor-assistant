import 'package:data_provider/data_provider.dart';
import 'package:hive/hive.dart';

/// Hive box keys for the [Hive].
abstract class HiveBoxKeys {
  /// User addresses.
  static const String userReportsBoxKey = '__user_reports_key__';
}

typedef UserReportsBox = Box<List<OrderMap>>;

typedef OperationMap = Map<OperationItem, int>;
typedef OrderMap = Map<OrderItem, List<OperationMap>>;
// typedef EmployeesMap = Map<EmployeesItem, List<OrderMap>>;
