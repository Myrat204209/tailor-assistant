import 'dart:developer';

import 'package:data_provider/data_provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'edit_state.dart';

class EditCubit extends Cubit<EditState> {
  EditCubit()
      : super(EditState(
          operations: [],
        ));

  void setOperations(List<OperationItem> operations) {
    emit(state.copyWith(operations: operations));
  }

  void addOperation(OperationItem operation) {
    log('Add operation is working...');
    if (state.operations.contains(operation)) {
      return;
    }
    emit(state.copyWith(operations: [ operation,...state.operations]));
  }

  void removeOperation(OperationItem operation) {
    emit(state.copyWith(
        operations: state.operations.where((op) => op != operation).toList()));
  }

  OperationItem? findOperationByWorkCode(String workCode) {
    if (workCode == '') {
      return OperationItem(workCode: '', workName: '', workPrice: 0);
    }
    final operation = state.operations.firstWhere(
      (op) => op.workCode == workCode,
    );

    return operation;
  }
  void clearOperations() {
    emit(state.copyWith(operations: []));
  }
}
