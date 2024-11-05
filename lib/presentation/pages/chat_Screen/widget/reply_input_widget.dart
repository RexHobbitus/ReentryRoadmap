import 'package:flutter/material.dart';
import 'package:reentry_roadmap/core/extensions/theme_extension.dart';
import 'package:reentry_roadmap/data/models/chat_reply_list_model.dart';
import 'package:reentry_roadmap/presentation/pages/chat_Screen/chat_cubit.dart';

class ReplyInputWidget extends StatefulWidget {
  final ChatCubit cubit;

  const ReplyInputWidget({Key? key, required this.cubit}) : super(key: key);

  @override
  _ReplyInputWidgetState createState() => _ReplyInputWidgetState();
}

class _ReplyInputWidgetState extends State<ReplyInputWidget> {
  final TextEditingController _replyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(width: 1.0, color: Colors.grey),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: TextField(
                controller: _replyController,
                maxLines: null,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.zero,
                  hintText: "Enter your reply...",
                  border: InputBorder.none,
                  hintStyle: TextStyle(color: Colors.grey),
                ),
                style: const TextStyle(fontSize: 16),
              ),
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    widget.cubit.toggleReplying(false);
                  },
                  child: SizedBox(
                    height: 36,
                    width: 70,
                    child: Center(
                      child: Text(
                        "Cancel",
                        style: context.textTheme.titleSmall?.copyWith(
                          color: Colors.black38,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                GestureDetector(
                  onTap: () {
                    // Create a new reply
                    if (_replyController.text.isNotEmpty) {
                      final newReply = ChatReplyListModel(
                        id: UniqueKey().toString(),
                        name: "Your Name",
                        description: _replyController.text,
                        iconPath: 'assets/icons/service_providers/opendoor.png',
                      );

                      widget.cubit.addReply(newReply);
                      _replyController.clear();
                      widget.cubit.toggleReplying(false);
                    }
                  },
                  child: Container(
                    height: 30,
                    width: 75,
                    decoration: BoxDecoration(
                      color: context.themeData.colorScheme.primary,
                      borderRadius: BorderRadius.circular(6.7),
                    ),
                    child: Center(
                      child: Text(
                        "Send",
                        style: context.textTheme.titleSmall?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
