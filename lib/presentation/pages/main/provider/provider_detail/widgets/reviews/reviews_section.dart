import 'package:flutter/material.dart';
import 'package:reentry_roadmap/core/extensions/theme_extension.dart';
import 'package:reentry_roadmap/core/utils/app_style.dart';
import 'package:reentry_roadmap/presentation/pages/main/provider/provider_detail/provider_detail_cubit.dart';
import 'package:reentry_roadmap/presentation/pages/main/provider/provider_detail/widgets/provider_detail_button.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_button.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_drop_down.dart';

import '../provider_detail_dropdown.dart';
import 'customer_review_widget.dart';
import 'rating_sub_section.dart';

class ReviewsSection extends StatelessWidget {
  final ProviderDetailCubit cubit;
  const ReviewsSection({super.key,required this.cubit});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const RatingSubSection(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Reviews",
              style: AppStyle.providerDetailTitle(context),
            ),
            Row(
              children: [
                ProviderDetailButton(
                  title: "Add Review",
                  icon: Icons.add,
                  onTap: cubit.addReviewAction,
                  isPrimary: true,
                ),
                const SizedBox(width: 10,),
                ProviderDetailDropdown<String>(
                  items: const ["Newest First","Oldest First","Highest Rating","Lowest Rating"],
                  selectedItem: "Newest First",
                  width: 150,
                 // height: 3,
                  onChanged: (val){},
                ),

              ],
            )
          ],
        ),
        ListView.builder(
          itemCount: 10,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context,index){
            return  const CustomerReviewWidget();
          },
        )
      ],
    );
  }
}
