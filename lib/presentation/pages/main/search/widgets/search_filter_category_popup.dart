import 'package:flutter/material.dart';
import 'package:reentry_roadmap/core/extensions/theme_extension.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_responsive_builder.dart';

class SearchFilterCategoryPopup extends StatelessWidget {
  final String title;
  final List<String> list;
  final List<String> selectedList;

  const SearchFilterCategoryPopup({
    super.key,
    required this.title,
    required this.list,
    required this.selectedList,
  });

  @override
  Widget build(BuildContext context) {
    return CustomResponsiveBuilder(
      builder: (context, constraints, deviceSize) {
        return SizedBox(
          width: deviceSize == DeviceSize.web ? 600 : null,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: context.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
                  ),
                  CloseButton(
                    style: IconButton.styleFrom(
                      visualDensity: const VisualDensity(vertical: -4, horizontal: -4),
                      padding: EdgeInsets.zero,
                    ),
                  )
                ],
              ),
              const SizedBox(height: 10),
              Flexible(
                child: GridView.builder(
                  shrinkWrap: true,
                  itemCount: list.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisExtent: 40,
                  ),
                  itemBuilder: (context, index) {
                    return Row(
                      children: [
                        SizedBox(
                          height: 18,
                          width: 18,
                          child: Checkbox(
                            visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                            value: index % 2 == 0,
                            onChanged: (value) {},
                            checkColor: Colors.transparent,
                            activeColor: context.colorScheme.secondary,
                            side: BorderSide(color: context.colorScheme.onSurface.withOpacity(0.5)),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            list[index],
                            style: context.textTheme.labelMedium?.copyWith(
                              color: context.colorScheme.onSurface.withOpacity(0.5),
                              fontWeight: FontWeight.w600,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              const SizedBox(height: 10),
              Container(
                height: 60,
                width: double.infinity,
                decoration: BoxDecoration(color: context.colorScheme.primary, borderRadius: BorderRadius.circular(10)),
                child: Center(
                  child: Text(
                    "Select $title",
                    style: context.textTheme.labelLarge?.copyWith(color: context.colorScheme.onSecondary),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
