import 'package:flutter/material.dart';

class CustomSingleChildScrollView extends StatelessWidget {
  final Widget child;
  const CustomSingleChildScrollView({super.key,required this.child});

  @override
  Widget build(BuildContext context) {
    return  CustomScrollView(
      slivers:[
        SliverToBoxAdapter(
          child: child,
        )
      ],
    );
  }
}
