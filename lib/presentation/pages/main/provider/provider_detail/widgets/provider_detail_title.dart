import 'package:flutter/material.dart';
import 'package:reentry_roadmap/core/utils/app_style.dart';

class ProviderDetailTitle extends StatelessWidget {
  final String title;

  const ProviderDetailTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Text(
        title,
        style: AppStyle.providerDetailTitle(context),
      ),
    );
  }
}
