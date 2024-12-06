part of 'edit_cubit.dart';

class EditState {
  EditState({required this.operations});

  final List<OperationItem> operations;

  EditState copyWith({List<OperationItem>? operations}) {
    return EditState(operations: operations ?? this.operations);
  }
}
