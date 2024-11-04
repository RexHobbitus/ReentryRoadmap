import '../../../../data/models/inbox_messages_model.dart';

class InboxUtils {
  static String timeAgo(DateTime date) {
    final Duration difference = DateTime.now().difference(date);

    if (difference.inDays > 0) {
      return '${difference.inDays} days ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hours ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} minutes ago';
    } else {
      return 'just now';
    }
  }

  static List<InboxMessagesModel> messages = [
    InboxMessagesModel(
      title: "CROP",
      detail: "Title of this mail by provider could not be that long",
      isRead: true,
      timestamp: DateTime.now().subtract(Duration(hours: 1)),
    ),
    InboxMessagesModel(
      title: "Weather Update",
      detail: "Weather is sunny today.",
      isRead: false,
      timestamp: DateTime.now().subtract(Duration(hours: 3)),
    ),
    InboxMessagesModel(
      title: "Appointment Reminder",
      detail: "Don't forget your appointment tomorrow.",
      isRead: false,
      timestamp: DateTime.now().subtract(Duration(hours: 5)),
    ),
    InboxMessagesModel(
      title: "Weekly Newsletter",
      detail: "Check out our latest news.",
      isRead: true,
      timestamp: DateTime.now().subtract(Duration(hours: 12)),
    ),
    InboxMessagesModel(
      title: "New Feature Update",
      detail: "New features have been added to your app.",
      isRead: false,
      timestamp: DateTime.now().subtract(Duration(days: 1)),
    ),
  ];
}
