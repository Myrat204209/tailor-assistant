import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'edit_state.dart';

class EditCubit extends Cubit<EditState> {
  EditCubit()
      : super(
          EditState(
            operations: [],
            selectedOperations: [],
            operationValues: {},
          ),
        );

  void setOperations(List<String> operations) {
    emit(state.copyWith(operations: operations));
  }

  final Map<String, Map<String, TextEditingController>> _controllers = {};

  // Get or create a controller for a specific operation and field
  TextEditingController getController(String operation, String fieldId) {
    return _controllers.putIfAbsent(operation, () => {})[fieldId] ??
        (_controllers[operation]![fieldId] = TextEditingController());
  }

  // Remove the controller for a specific operation and field
  void removeController(String operation, String fieldId) {
    _controllers[operation]?.remove(fieldId);
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
    removeOperationValues(operation);
  }

  // Update the field value for a specific operation and field
  void updateFieldValue(String operation, String fieldId, String value) {
    final updatedValues =
        Map<String, String>.from(state.operationValues[operation] ?? {});
    updatedValues[fieldId] = value;

    final updatedOperationValues =
        Map<String, Map<String, String>>.from(state.operationValues)
          ..[operation] = updatedValues;

    emit(state.copyWith(operationValues: updatedOperationValues));
  }

  // Remove all values for a specific operation
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

  // Dispose controllers when no longer needed
  void disposeControllers() {
    _controllers.forEach((operation, fields) {
      for (final controller in fields.values) {
        controller.dispose();
      }
    });
  }
}
