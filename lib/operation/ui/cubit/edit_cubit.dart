import 'package:data_provider/data_provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'edit_state.dart';

class EditCubit extends Cubit<EditState> {
  EditCubit() : super(EditState(operations: []));

  void setOperations(List<OperationItem> operations) {
    emit(state.copyWith(operations: operations));
  }

  OperationItem? findOperationByWorkCode(String workCode) {
    // Search for an operation with the matching workCode
    final operation = state.operations.firstWhere(
      (op) => op.workCode == workCode,
    );

    return operation;
  }
}
