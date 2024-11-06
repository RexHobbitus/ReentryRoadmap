import 'package:flutter/material.dart';
import 'package:reentry_roadmap/core/utils/assets.dart';
import 'package:reentry_roadmap/presentation/pages/main/search/search_cubit.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_textfield.dart';

class SearchMobileField extends StatelessWidget {
  final SearchCubit cubit;
  const SearchMobileField({super.key,required this.cubit});

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      controller: cubit.searchController,
      hint: "Search",
      suffixPath: Assets.search,
      suffixAction: () {
        cubit.onSearch();
      },
      textFieldMode: TextFieldMode.search,
      height: 60,
    );
  }
}
