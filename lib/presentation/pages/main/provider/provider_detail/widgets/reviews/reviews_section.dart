import 'package:flutter/material.dart';
import 'package:reentry_roadmap/core/extensions/theme_extension.dart';
import 'package:reentry_roadmap/core/utils/app_style.dart';
import 'package:reentry_roadmap/presentation/pages/main/provider/provider_detail/widgets/provider_detail_button.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_button.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_drop_down.dart';

import '../provider_detail_dropdown.dart';
import 'customer_review_widget.dart';
import 'rating_sub_section.dart';

class ReviewsSection extends StatelessWidget {
  const ReviewsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RatingSubSection(),
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
                  onTap: () {},
                  isPrimary: true,
                ),
                const SizedBox(width: 10,),
                ProviderDetailDropdown<String>(
                  items: const ["Newest","Oldest"],
                  selectedItem: "Newest",
                  width: 120,
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
