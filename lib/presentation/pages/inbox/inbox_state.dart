import 'package:equatable/equatable.dart';

import '../../../data/models/inbox_messages_model.dart';

class InboxState extends Equatable {
  final bool loading;
  final int selectedIndex;
  final int messageListIndex;
  final List<InboxMessagesModel> messages;

  const InboxState({
    required this.loading,
    required this.selectedIndex,
    required this.messageListIndex,
    required this.messages,
  });

  factory InboxState.initial() => const InboxState(
      loading: false, selectedIndex: 0, messageListIndex: -1, messages: []);

  InboxState copyWith({
    bool? loading,
    int? selectedIndex,
    int? messageListIndex,
    List<InboxMessagesModel>? messages,
  }) {
    return InboxState(
      loading: loading ?? this.loading,
      selectedIndex: selectedIndex ?? this.selectedIndex,
      messageListIndex: messageListIndex ?? this.messageListIndex,
      messages: messages ?? this.messages,
    );
  }

  @override
  List<Object?> get props =>
      [loading, selectedIndex, messageListIndex, messages];
}
