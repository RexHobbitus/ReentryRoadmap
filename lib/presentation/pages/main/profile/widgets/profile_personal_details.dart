import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:reentry_roadmap/presentation/pages/main/profile/profile_cubit.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_title_card.dart';

import '../profile_state.dart';
import 'profile_view_text_field.dart';

class ProfilePersonalDetails extends StatelessWidget {
  const ProfilePersonalDetails({super.key, required this.cubit});

  final ProfileCubit cubit;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      bloc: cubit,
      builder: (context, state) {
        return CustomTitleCard(
          title: 'Personal Details',
          child: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ProfileViewTextField(
                  title: 'Full Name',
                  hint: cubit.fullName(),
                ),
                ProfileViewTextField(
                  title: 'Date of Birth',
                  hint: DateFormat('MMM dd yyyy').format(cubit.selectedDob ?? DateTime.now()),
                ),
                ProfileViewTextField(
                  title: 'Ethnicity',
                  hint: cubit.selectedEthnicity,
                ),
                ProfileViewTextField(
                  title: 'Veteran Status',
                  hint: cubit.selectedVeteran,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
