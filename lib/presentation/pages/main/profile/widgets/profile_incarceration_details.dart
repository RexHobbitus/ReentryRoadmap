import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../../widgets/custom_textfield.dart';
import '../../../../widgets/custom_title_card.dart';
import '../profile_cubit.dart';
import '../profile_state.dart';
import 'profile_title_tile.dart';
import 'profile_view_text_field.dart';

class ProfileIncarcerationDetails extends StatelessWidget {
  const ProfileIncarcerationDetails({super.key, required this.cubit});

  final ProfileCubit cubit;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      bloc: cubit,
      builder: (context, state) {
        return CustomTitleCard(
          title: 'Incarceration Details',
          child: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ProfileViewTextField(
                  title: 'ID Number',
                  hint: cubit.idNumber,
                ),
                ProfileViewTextField(
                  title: 'Number of Times Incarcerated',
                  hint: cubit.numberOfTimesIncarcerated,
                ),
                ProfileViewTextField(
                  title: 'Incarceration History',
                  hint: cubit.selectedIncarceratedHistory,
                ),
                ProfileViewTextField(
                  title: 'Latest Offence Type',
                  hint: cubit.selectedTypeOfOffences.isNotEmpty ? cubit.selectedTypeOfOffences.first : 'N/A',
                ),
                ProfileViewTextField(
                  title: 'Length of Longest Incarceration',
                  hint: cubit.selectedLatestIncarcerationLength,
                ),
                ProfileViewTextField(
                  title: 'Length of Latest Incarceration',
                  hint: cubit.selectedLongestIncarcerationLength,
                ),
                ProfileViewTextField(
                  title: 'First Incarceration Date',
                  hint: cubit.firstIncarceratedDate != null
                      ? DateFormat('MMM dd yyyy').format(cubit.firstIncarceratedDate!)
                      : 'N/A',
                ),
                ProfileViewTextField(
                  title: 'Latest Release Date',
                  hint: cubit.latestReleaseDate != null
                      ? DateFormat('MMM dd yyyy').format(cubit.latestReleaseDate!)
                      : 'N/A',
                ),
                ProfileViewTextField(
                  title: 'Most Recent Term Served in',
                  hint: cubit.selectedServeMost,
                ),
                ProfileTile(
                  title: 'Programs Attended While Incarcerated',
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: cubit.selectedPrograms.isNotEmpty
                        ? cubit.selectedPrograms
                            .map((program) => CustomTextField(
                                  width: double.maxFinite,
                                  hint: program,
                                  readOnly: true,
                                ))
                            .toList()
                        : [CustomTextField(width: double.maxFinite, hint: 'No program selected')],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
