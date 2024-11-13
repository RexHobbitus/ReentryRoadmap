class ItemSelectionData {
  final Set<int> selectedItems;
  final Map<String, int?> selectedIndicesByCategory;
  final List<String?> selectedCriteria;

  ItemSelectionData({
    required this.selectedItems,
    required this.selectedIndicesByCategory,
    required this.selectedCriteria,
  });

  ItemSelectionData copyWith({
    Set<int>? selectedItems,
    Map<String, int?>? selectedIndicesByCategory,
    List<String?>? selectedCriteria,
  }) {
    return ItemSelectionData(
      selectedItems: selectedItems ?? this.selectedItems,
      selectedIndicesByCategory:
          selectedIndicesByCategory ?? this.selectedIndicesByCategory,
      selectedCriteria: selectedCriteria ?? this.selectedCriteria,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'selectedItems': selectedItems.toList(),
      'selectedIndicesByCategory': selectedIndicesByCategory,
      'selectedCriteria': selectedCriteria,
    };
  }

  factory ItemSelectionData.fromMap(Map<String, dynamic> map) {
    return ItemSelectionData(
      selectedItems: Set<int>.from(map['selectedItems'] ?? []),
      selectedIndicesByCategory:
          Map<String, int?>.from(map['selectedIndicesByCategory'] ?? {}),
      selectedCriteria: List<String?>.from(map['selectedCriteria'] ?? []),
    );
  }
}
