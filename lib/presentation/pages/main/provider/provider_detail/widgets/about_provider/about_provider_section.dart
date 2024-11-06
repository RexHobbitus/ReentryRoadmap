import 'package:flutter/material.dart';
import 'package:reentry_roadmap/core/utils/app_style.dart';
import 'package:reentry_roadmap/presentation/pages/main/provider/provider_detail/provider_detail_state.dart';

import '../../provider_detail_cubit.dart';
import '../provider_detail_title.dart';
import 'about_provider_all_programs.dart';
import 'about_provider_general_services.dart';

class AboutProviderSection extends StatelessWidget {
  final ProviderDetailCubit cubit;

  const AboutProviderSection({super.key, required this.cubit});

  ProviderDetailState get state => cubit.state;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ProviderDetailTitle(
          title:
          "About ${state.provider.onboardingInfo?.providerDetails
              ?.providerNameLocation}",
        ),
        Text(
          "${state.provider.onboardingInfo?.providerDetails
              ?.providerLocationDescribe}",
          style: AppStyle.providerDetailBody(context),
        ),
        const SizedBox(
          height: 50,
        ),
        (state.provider.onboardingInfo?.generalService == null ||
            state.provider.onboardingInfo?.generalService?.serviceCategories
                ?.isEmpty == true
        ) ? const SizedBox.shrink():
        AboutProviderGeneralServices(
          cubit: cubit,
        ),
        AboutProviderAllPrograms(
          cubit: cubit,
        ),
      ],
    );
  }
}
