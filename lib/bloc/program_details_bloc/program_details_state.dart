import 'package:equatable/equatable.dart';

import '../../data/models/item_selection_model.dart';

class ProgramDetailsState extends Equatable {
  final Set<int> selectedItems;
  final Map<int, ItemSelectionData> selectionData;
  final Map<String, int?> selectedIndicesByCategory;
  final List<String?> selectedCriteria;
  final bool isLoading;
  final bool isSaved;
  final List<Map<String, dynamic>>? data;
  final Map<int, bool> isEditing; // Track edit mode per item

  const ProgramDetailsState({
    required this.selectedItems,
    required this.selectionData,
    required this.selectedIndicesByCategory,
    required this.selectedCriteria,
    this.isLoading = false,
    this.isSaved = false,
    this.data,
    this.isEditing = const {},
  });

  ProgramDetailsState copyWith({
    Set<int>? selectedItems,
    Map<String, int?>? selectedIndicesByCategory,
    List<String?>? selectedCriteria,
    bool? isLoading,
    bool? isSaved,
    List<Map<String, dynamic>>? data,
    Map<int, bool>? isEditing,
    Map<int, ItemSelectionData>? selectionData,
  }) {
    return ProgramDetailsState(
        selectedItems: selectedItems ?? this.selectedItems,
        selectionData: selectionData ?? this.selectionData,
        selectedIndicesByCategory:
            selectedIndicesByCategory ?? this.selectedIndicesByCategory,
        selectedCriteria: selectedCriteria ?? this.selectedCriteria,
        isLoading: isLoading ?? this.isLoading,
        isSaved: isSaved ?? this.isSaved,
        data: data ?? this.data,
        isEditing: isEditing ?? this.isEditing);
  }

  @override
  List<Object?> get props => [
        selectedItems,
        selectedIndicesByCategory,
        selectedCriteria,
        isLoading,
        isSaved,
        data,
        isEditing
      ];
}
