import 'package:flutter/material.dart';
import 'package:reentry_roadmap/core/extensions/theme_extension.dart';
import 'package:reentry_roadmap/core/utils/assets.dart';
import 'package:reentry_roadmap/presentation/pages/main/search/search_cubit.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_textfield.dart';

class SearchWebField extends StatelessWidget {
  final SearchCubit cubit;
  const SearchWebField({super.key, required this. cubit});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Spacer(flex: 1),
        Flexible(
          flex: 2,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: context.themeData.cardColor,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: CustomTextField(
                    controller: cubit.searchController,
                    hint: "Search for a service",
                    bottomPadding: 0,
                    textFieldMode: TextFieldMode.search,
                  ),
                ),
                const SizedBox(
                  width: 10,
                  height: 30,
                  child: VerticalDivider(
                    thickness: 2,
                  ),
                ),
                Expanded(
                  child: CustomTextField(
                    controller: cubit.locationController,
                    hint: "Enter Location",
                    suffixPath: Assets.search,
                    suffixAction: () {
                      cubit.onSearch();
                    },
                    bottomPadding: 0,
                    textFieldMode: TextFieldMode.search,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
