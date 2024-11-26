import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

class EditCubit extends Cubit<EditState> {
  EditCubit()
      : super(
          EditState(
            operations: [],
            selectedOperations: [],
            operationValues: {},
          ),
        );

  // Map of TextEditingControllers, each operation can have multiple fields
  final Map<String, Map<String, TextEditingController>> _controllers = {};

  // Get a controller for a specific operation and field
  TextEditingController getController(String operation, String fieldId) {
    return _controllers.putIfAbsent(operation, () => {})[fieldId] ??
        (_controllers[operation]![fieldId] = TextEditingController());
  }

  // Remove a controller for a specific operation and field
  void removeController(String operation, String fieldId) {
    _controllers[operation]?.remove(fieldId);
    _controllers[operation]
        ?.values
        .forEach((controller) => controller.dispose());
  }

  // Add an operation to the selected list
  void addOperation(String operation) {
    if (!state.selectedOperations.contains(operation)) {
      emit(
        state.copyWith(
          selectedOperations: [...state.selectedOperations, operation],
        ),
      );
    }
  }

  // Remove an operation from the selected list
  void removeOperation(String operation) {
    final updatedOperations =
        state.selectedOperations.where((o) => o != operation).toList();
    emit(state.copyWith(selectedOperations: updatedOperations));
    // Optionally clear values when an operation is removed
    removeOperationValues(operation);
  }

  // Clear all selected operations
  void clearOperations() {
    emit(state.copyWith(selectedOperations: []));
    // Optionally clear values when all operations are cleared
    clearOperationValues();
  }

  // Set the list of available operations
  void setOperations(List<String> operations) {
    emit(state.copyWith(operations: operations));
  }

  // Update the value for a specific field in an operation
  void updateFieldValue(String operation, String fieldId, String value) {
    final updatedValues =
        Map<String, String>.from(state.operationValues[operation] ?? {});
    updatedValues[fieldId] = value;
    final updatedOperationValues =
        Map<String, Map<String, String>>.from(state.operationValues)
          ..[operation] = updatedValues;

    emit(state.copyWith(operationValues: updatedOperationValues));
  }

  // Get the saved value for a specific field of an operation
  String? getFieldValue(String operation, String fieldId) {
    return state.operationValues[operation]?[fieldId];
  }

  // Clear all values for a specific operation
  void removeOperationValues(String operation) {
    final updatedValues =
        Map<String, Map<String, String>>.from(state.operationValues)
          ..remove(operation);
    emit(state.copyWith(operationValues: updatedValues));
  }

  // Clear all operation values
  void clearOperationValues() {
    emit(state.copyWith(operationValues: {}));
  }

  // Dispose all controllers for a specific operation
  void disposeControllers() {
    _controllers.forEach((operation, fields) {
      for (final controller in fields.values) {
        controller.dispose();
      }
    });
  }
}
