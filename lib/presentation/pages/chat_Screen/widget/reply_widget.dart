import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reentry_roadmap/core/extensions/theme_extension.dart';
import 'package:reentry_roadmap/presentation/pages/chat_Screen/chat_cubit.dart';
import 'package:reentry_roadmap/presentation/pages/chat_Screen/widget/reply_input_widget.dart';

import '../../../../data/models/chat_reply_list_model.dart'; // Update with your actual input widget path

class ReplyWidget extends StatelessWidget {
  final ChatReplyListModel reply;
  final ChatCubit cubit;
  final bool isLastReply;
  final bool isReplying;
  final Function() onReplyToggle;

  const ReplyWidget({
    Key? key,
    required this.reply,
    required this.cubit,
    required this.isLastReply,
    required this.isReplying,
    required this.onReplyToggle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 48,
                    width: 48,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: Image.asset(
                      reply.iconPath,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          reply.name,
                          style: context.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          "View Provider >",
                          style: context.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Text(
                reply.description,
                style: context.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 15),
            ],
          ),
        ),
        // Divider between replies
        if (!isLastReply) const Divider(height: 1, thickness: 1),
        const SizedBox(height: 20),
        if (isLastReply) ...[
          if (!isReplying)
            Row(
              children: [
                GestureDetector(
                  onTap: onReplyToggle,
                  child: Container(
                    height: 48,
                    width: 88,
                    decoration: BoxDecoration(
                      color: context.themeData.colorScheme.secondary,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Icon(
                          CupertinoIcons.reply,
                          size: 20,
                          color: Colors.white,
                        ),
                        Text(
                          "Reply",
                          style: context.textTheme.titleSmall?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          if (isReplying) ReplyInputWidget(cubit: cubit),
        ],
      ],
    );
  }
}
