import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:reentry_roadmap/core/extensions/theme_extension.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  _CustomAppBarState createState() => _CustomAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(62); // Standard AppBar height
}

class _CustomAppBarState extends State<CustomAppBar> {
  // State variables to track selected tab
  bool isApplicationSelected = true; // Initially, "Applications" is selected

  void _selectApplication() {
    setState(() {
      isApplicationSelected = true;
    });
  }

  void _selectProviderProfile() {
    setState(() {
      isApplicationSelected = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isMobile = MediaQuery.of(context).size.width <= 600;
        return AppBar(
          title: Row(
            children: [
              const Icon(Icons.flag),
              Text(
                'Dignifi for providers',
                style: context.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w500),
              ),
            ],
          ),
          actions: [
            !isMobile
                ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: _selectApplication,
                  child: Text(
                    'Applications',
                    style: context.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                      color: isApplicationSelected ? Colors.blue : Colors.black, // Change color based on selection
                    ),
                  ),
                ),
                Gap(18),
                GestureDetector(
                  onTap: _selectProviderProfile,
                  child: Text(
                    'Provider Profile',
                    style: context.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                      color: !isApplicationSelected ? Colors.blue : Colors.black, // Change color based on selection
                    ),
                  ),
                ),
                Gap(12),
              ],
            )
                : SizedBox(
              width: MediaQuery.of(context).size.width * 0.25,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: _selectApplication,
                    child: Text(
                      'Applications',
                      style: context.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w500,
                        color: isApplicationSelected ? Colors.blue : Colors.black, // Change color based on selection
                      ),
                    ),
                  ),
                  Gap(3),
                  GestureDetector(
                    onTap: _selectProviderProfile,
                    child: Text(
                      'Provider Profile',
                      style: context.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w500,
                        color: !isApplicationSelected ? Colors.blue : Colors.black, // Change color based on selection
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.mail_outline_rounded, size: 19),
            Gap(12),
            const CircleAvatar(
              radius: 18,
              backgroundColor: Colors.black,
            ),
            Gap(12),
          ],
        );
      },
    );
  }
}
