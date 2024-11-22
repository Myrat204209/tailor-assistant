import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditState {
  EditState({
    required this.operations,
    required this.selectedOperations,
  });
  final List<String> operations;
  final List<String> selectedOperations;

  EditState copyWith({
    List<String>? operations,
    List<String>? selectedOperations,
  }) {
    return EditState(
      operations: operations ?? this.operations,
      selectedOperations: selectedOperations ?? this.selectedOperations,
    );
  }
}

class EditCubit extends Cubit<EditState> {
  EditCubit() : super(EditState(operations: [], selectedOperations: []));

  final Map<String, TextEditingController> _controllers = {};

  TextEditingController getController(String operation) {
    return _controllers.putIfAbsent(operation, TextEditingController.new);
  }

  void removeController(String operation) {
    _controllers[operation]?.dispose();
    _controllers.remove(operation);
  }

  void addOperation(String operation) {
    if (!state.selectedOperations.contains(operation)) {
      emit(
        state.copyWith(
          selectedOperations: [...state.selectedOperations, operation],
        ),
      );
    }
  }

  void removeOperation(String operation) {
    final updatedOperations =
        state.selectedOperations.where((o) => o != operation).toList();
    emit(state.copyWith(selectedOperations: updatedOperations));
    removeController(operation);
  }

  void clearOperations() {
    final updatedSelected = List<String>.from(state.selectedOperations)
      ..clear();
    emit(state.copyWith(selectedOperations: updatedSelected));
  }

  void setOperations(List<String> operations) {
    emit(state.copyWith(operations: operations));
  }
}
