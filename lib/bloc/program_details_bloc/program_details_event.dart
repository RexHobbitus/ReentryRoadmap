import 'package:equatable/equatable.dart';

abstract class ProgramDetailsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadProgramDetails extends ProgramDetailsEvent {}

class DeleteProgramDetails extends ProgramDetailsEvent {
  final String documentId;

  DeleteProgramDetails(this.documentId);

  @override
  List<Object> get props => [documentId];
}

class UpdateProgramDetails extends ProgramDetailsEvent {
  final String documentId;
  final Map<String, dynamic> updatedData;

  UpdateProgramDetails(this.documentId, this.updatedData);

  @override
  List<Object> get props => [documentId, updatedData];
}

// UpdateSelectedItems event now accepts outerIndex and innerIndex
class UpdateSelectedItems extends ProgramDetailsEvent {
  final int outerIndex;
  final int innerIndex;

  UpdateSelectedItems(this.outerIndex, this.innerIndex);
}

class UpdateCategorySelection extends ProgramDetailsEvent {
  final int index;
  final String categoryKey;
  final int itemIndex;

  UpdateCategorySelection(this.index, this.categoryKey, this.itemIndex);
}

class UpdateSelectedCriteria extends ProgramDetailsEvent {
  final int outerIndex;
  final int criteriaIndex;
  final String? value;

  UpdateSelectedCriteria(this.outerIndex, this.criteriaIndex, this.value);
}

class AddDropdownCriteria extends ProgramDetailsEvent {
  final int outerIndex;

  AddDropdownCriteria(this.outerIndex);
}

class SaveProgramDetails extends ProgramDetailsEvent {}

class ToggleEditMode extends ProgramDetailsEvent {
  final int index;

  ToggleEditMode(this.index);
}
