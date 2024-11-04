import 'package:equatable/equatable.dart';

import '../../../data/models/inbox_messages_model.dart';

class InboxState extends Equatable {
  final bool loading;
  final int selectedIndex;
  final List<InboxMessagesModel> messages;

  const InboxState(
      {required this.loading,
      required this.selectedIndex,
      required this.messages});

  factory InboxState.initial() =>
      const InboxState(loading: false, selectedIndex: 0, messages: []);

  InboxState copyWith(
      {bool? loading,
      int? selectedIndex,
      List<InboxMessagesModel>? messageFilter}) {
    return InboxState(
        loading: loading ?? this.loading,
        selectedIndex: selectedIndex ?? this.selectedIndex,
        messages: messageFilter ?? messages);
  }

  @override
  // TODO: implement props
  List<Object?> get props => [selectedIndex, messages];
}
