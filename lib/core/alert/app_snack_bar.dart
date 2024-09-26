import 'package:flutter/material.dart';
import '../navigation/app_navigator.dart';

enum SnackBarType { ERROR, SUCCESS, INFO }

 class AppSnackBar {

  BuildContext get context  => AppNavigator.navigatorKey.currentContext!;

  show(String info,{SnackBarType snackBarType = SnackBarType.ERROR}) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5)
        ),
        margin: const EdgeInsets.symmetric(vertical: 5,horizontal: 10),
        content: Row(
          children: [
            Icon(
              getLeadingIcon(snackBarType),
              color: Colors.white,
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Text(
                info,
                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold,color: Colors.white),
              ),
            ),
          ],
        ),
        backgroundColor: getColor(snackBarType,context: context),
        behavior: SnackBarBehavior.floating,
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        elevation: 6.0,
      ),
    );
  }

  Color getColor(SnackBarType snackBarType,{required BuildContext context}) {
    switch (snackBarType) {
      case SnackBarType.ERROR:
        return Colors.red;
      case SnackBarType.INFO:
        return Colors.orange[600]!;
      case SnackBarType.SUCCESS:
        return Colors.green;
    }
  }

  IconData getLeadingIcon(SnackBarType snackBarType) {
    switch (snackBarType) {
      case SnackBarType.ERROR:
        return Icons.close;
      case SnackBarType.INFO:
        return Icons.info;
      case SnackBarType.SUCCESS:
        return Icons.check_circle;
    }
  }
}
