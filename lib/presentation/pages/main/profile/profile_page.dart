import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reentry_roadmap/core/utils/constants.dart';
import 'package:reentry_roadmap/domain/entities/login_user.dart';
import 'package:reentry_roadmap/domain/stores/user_store.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_button.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_scroll_view.dart';
import 'profile_cubit.dart';
import 'profile_initial_params.dart';
import 'profile_state.dart';
import 'widgets/profile_contact_details.dart';
import 'widgets/profile_current_needs.dart';
import 'widgets/profile_incarceration_details.dart';
import 'widgets/profile_personal_details.dart';
import 'widgets/profile_banner_section.dart';
import 'widgets/profile_header_section.dart';
import 'widgets/profile_service_provider_accessed.dart';

class ProfilePage extends StatefulWidget {
  final ProfileCubit cubit;
  final ProfileInitialParams initialParams;

  static const path = '/ProfilePage';

  const ProfilePage({
    super.key,
    required this.cubit,
    required this.initialParams,
  });

  @override
  State<ProfilePage> createState() => _ProfileState();
}

class _ProfileState extends State<ProfilePage> {
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
              const SizedBox(
                height: 16,
              ),
              const ProfileHeaderSection(),
              const SizedBox(
                height: 16,
              ),
              const ProfileBannerSection(),
              const SizedBox(
                height: 16,
              ),
              const ProfileContactDetailsSection(),
              const SizedBox(
                height: 15,
              ),
              const ProfilePersonalDetails(),
              const SizedBox(
                height: 15,
              ),
              const ProfileIncarcerationDetails(),
              const SizedBox(
                height: 15,
              ),
              const ProfileCurrentNeeds(),
              const SizedBox(
                height: 15,
              ),
              const ProfileServiceProvidersAccessed(),
              const SizedBox(
                height: 15,
              ),
              BlocBuilder<UserStore, LoginUser>(
                bloc: cubit.userStore,
                builder: (context, user) {
                  return BlocBuilder<ProfileCubit, ProfileState>(
                    bloc: cubit,
                    builder: (context, state) {
                      return user.isLoggedIn
                          ? Center(
                              child: CustomButton(
                                text: "Logout",
                                onTap: cubit.logoutAction,
                              ),
                            )
                          : const SizedBox();
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
