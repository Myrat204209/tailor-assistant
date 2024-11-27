part of 'edit_cubit.dart';

class EditState {
  EditState({
    required this.operations,
    required this.selectedOperations,
    required this.operationValues, // Store values of each operation
  });

  final List<String> operations;
  final List<String> selectedOperations;
  final Map<String, Map<String, String>>
      operationValues; // Stores values for each operation's fields

  EditState copyWith({
    List<String>? operations,
    List<String>? selectedOperations,
    Map<String, Map<String, String>>? operationValues,
  }) {
    return EditState(
      operations: operations ?? this.operations,
      selectedOperations: selectedOperations ?? this.selectedOperations,
      operationValues: operationValues ?? this.operationValues,
    );
  }
}
