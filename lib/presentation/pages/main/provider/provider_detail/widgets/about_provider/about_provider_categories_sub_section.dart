import 'package:flutter/material.dart';
import 'package:reentry_roadmap/core/extensions/theme_extension.dart';
import 'package:reentry_roadmap/core/utils/app_style.dart';
import 'package:reentry_roadmap/domain/entities/program_category.dart';
import 'package:reentry_roadmap/presentation/pages/main/provider/provider_detail/provider_detail_cubit.dart';
import 'package:reentry_roadmap/presentation/pages/main/provider/provider_detail/provider_detail_state.dart';

import '../../../../../../widgets/custom_expansion_tile.dart';

class AboutProviderCategoriesSubSection extends StatefulWidget {
  final ProviderDetailCubit cubit;

  AboutProviderCategoriesSubSection({
    super.key,
    required this.cubit,
  });

  @override
  State<AboutProviderCategoriesSubSection> createState() =>
      _AboutProviderCategoriesSubSectionState();
}

class _AboutProviderCategoriesSubSectionState
    extends State<AboutProviderCategoriesSubSection> {
  ProviderDetailState get state => widget.cubit.state;
  List<ProgramCategory> _categories = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _categories =
        state.provider.onboardingInfo?.generalService?.serviceCategories ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Categories",
            style: AppStyle.providerDetailUnderlinedSubTitle(context)),
        const SizedBox(
          height: 15,
        ),
        for (var index = 0; index < _categories.length; index++)
          CustomExpansionTile(
            title: _categories[index].title??"N/A",
            children: [
              for(var subCategory in _categories[index].subCategories??[])
              _subCategoryTile(context: context, title:subCategory),
            ],
          ),
      ],
    );
  }

  Widget _subCategoryTile(
      {required BuildContext context,
      required String title,
      bool hideDivider = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: context.textTheme.bodySmall,
          ),
          hideDivider
              ? const SizedBox.shrink()
              : const SizedBox(
                  height: 5,
                ),
          hideDivider
              ? const SizedBox.shrink()
              : const Divider(
                  thickness: 0.5,
                  height: 2,
                ),
        ],
      ),
    );
  }
}
