import 'package:data_provider/src/hive/hive.dart';
import 'package:hive_ce/hive.dart';

part 'hive_adapters.g.dart';

@GenerateAdapters([
  AdapterSpec<OperationMap>(),
  AdapterSpec<OrderMap>(),
])
class HiveAdapters {}
