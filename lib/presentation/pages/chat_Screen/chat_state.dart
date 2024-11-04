import 'package:equatable/equatable.dart';
import 'package:reentry_roadmap/presentation/pages/chat_Screen/widget/chat_list.dart';

import '../../../data/models/chat_reply_list_model.dart';

class ChatState extends Equatable {
  final bool isLoading;
  final List<ChatReplyListModel> replies;
  final bool isReplying;

  const ChatState({
    required this.isLoading,
    required this.replies,
    required this.isReplying,
  });

  factory ChatState.initial() => ChatState(
        isLoading: false,
        replies: ChatList.serviceProviders,
        isReplying: false,
      );

  ChatState copyWith({
    bool? isLoading,
    List<ChatReplyListModel>? replies,
    bool? isReplying,
  }) =>
      ChatState(
        isLoading: isLoading ?? this.isLoading,
        replies: replies ?? this.replies,
        isReplying: isReplying ?? this.isReplying,
      );

  @override
  List<Object?> get props => [isLoading, replies, isReplying];
}
