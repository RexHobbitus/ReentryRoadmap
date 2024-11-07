import 'package:flutter/material.dart';
import 'package:reentry_roadmap/core/utils/constants.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_scroll_view.dart';
import 'profile_cubit.dart';
import 'profile_initial_params.dart';
import 'widgets/profile_contact_details.dart';
import 'widgets/profile_incarceration_details.dart';
import 'widgets/profile_personal_details.dart';
import 'widgets/profile_header_section.dart';

class ProfileForProviderPage extends StatefulWidget {
  final ProfileCubit cubit;
  final ProfileInitialParams initialParams;

  static const path = '/ProfileForProviderPage';

  const ProfileForProviderPage({
    super.key,
    required this.cubit,
    required this.initialParams,
  });

  @override
  State<ProfileForProviderPage> createState() => _ProfileForProviderState();
}

class _ProfileForProviderState extends State<ProfileForProviderPage> {
  ProfileCubit get cubit => widget.cubit;

  @override
  void initState() {
    super.initState();
    cubit.navigator.context = context;
    cubit.onInit(widget.initialParams);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kScreenHorizontalPadding),
        child: CustomSingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 30),
              const ProfileHeaderSection(),
              const SizedBox(height: 30),
              ProfileContactDetailsSection(cubit: cubit, isViewOnly: true),
              const SizedBox(height: 30),
              ProfilePersonalDetails(cubit: cubit),
              const SizedBox(height: 30),
              ProfileIncarcerationDetails(cubit: cubit),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
