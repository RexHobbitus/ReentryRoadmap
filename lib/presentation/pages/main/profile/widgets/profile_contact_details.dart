import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:reentry_roadmap/core/extensions/theme_extension.dart';
import 'package:reentry_roadmap/presentation/pages/main/profile/profile_cubit.dart';
import 'package:reentry_roadmap/presentation/pages/main/profile/widgets/profile_title_tile.dart';

import '../../../../../core/utils/assets.dart';
import '../../../../../core/utils/constants.dart';
import '../../../../widgets/custom_drop_down.dart';
import '../../../../widgets/custom_textfield.dart';
import '../profile_state.dart';

class ProfileContactDetailsSection extends StatelessWidget {
  const ProfileContactDetailsSection({super.key, required this.cubit});

  final ProfileCubit cubit;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      bloc: cubit,
      builder: (context, state) {
        return Container(
          width: context.sw,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: context.themeData.cardColor),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _heading(context: context, state: state),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
                child: state.edit ? editDetails(context) : viewOnlyDetails(context),
              ),
            ],
          ),
        );
      },
    );
  }

  Column editDetails(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ProfileTile(
          title: 'Phone Number',
          child: CustomTextField(
            initialValue: cubit.phoneNumber,
            keyboard: TextInputType.phone,
            width: double.maxFinite,
            onChange: (val) {
              cubit.phoneNumber = val;
              cubit.notifyTextFieldUpdates();
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            'Location',
            style: context.textTheme.titleSmall!.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.end,
          alignment: WrapAlignment.start,
          runAlignment: WrapAlignment.start,
          spacing: 10,
          children: [
            CustomTextField(
              initialValue: cubit.locationStreet,
              onChange: (val) {
                cubit.locationStreet = val;
                cubit.notifyTextFieldUpdates();
              },
              label: "Street Address (optional)",
            ),
            CustomTextField(
              initialValue: cubit.locationCity,
              onChange: (val) {
                cubit.locationCity = val;
                cubit.notifyTextFieldUpdates();
              },
              label: "City",
            ),
            CustomDropDown<String>(
              items: kUSStates,
              selectedItem: cubit.locationState.isEmpty ? null : cubit.locationState,
              onChange: (state) {
                cubit.locationState = state ?? "";
                cubit.notifyTextFieldUpdates();
              },
              label: "State",
            ),
          ],
        )
      ],
    );
  }

  Column viewOnlyDetails(BuildContext context) {
    return Column(
      children: [
        ListTile(
          dense: true,
          minLeadingWidth: 0,
          titleAlignment: ListTileTitleAlignment.center,
          visualDensity: const VisualDensity(vertical: -3),
          leading: SvgPicture.asset(
            Assets.phone,
            height: 16,
            width: 16,
          ),
          title: Text(
            cubit.phoneNumber,
            style: context.textTheme.bodyLarge,
          ),
        ),
        ListTile(
          dense: true,
          minLeadingWidth: 0,
          titleAlignment: ListTileTitleAlignment.center,
          visualDensity: const VisualDensity(vertical: -3),
          leading: SvgPicture.asset(
            Assets.email,
            height: 14,
            width: 14,
          ),
          title: Text(
            cubit.email,
            style: context.textTheme.bodyLarge,
          ),
        ),
        ListTile(
          dense: true,
          minLeadingWidth: 0,
          titleAlignment: ListTileTitleAlignment.center,
          visualDensity: const VisualDensity(vertical: -3),
          leading: SvgPicture.asset(
            Assets.location,
            height: 16,
            width: 16,
          ),
          title: Text(
            '${cubit.locationStreet}, ${cubit.locationCity}, ${cubit.locationState}',
            style: context.textTheme.bodyLarge,
          ),
        ),
      ],
    );
  }

  Widget _heading({required BuildContext context, required ProfileState state}) {
    return Container(
      width: context.sw,
      padding: const EdgeInsets.symmetric(horizontal: kScreenHorizontalPadding, vertical: 10),
      decoration: BoxDecoration(
          color: context.colorScheme.secondary,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          )),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Contact Details',
            style: context.textTheme.bodyMedium?.copyWith(
              color: context.colorScheme.onSecondary,
              fontWeight: FontWeight.w500,
            ),
          ),
          state.loading
              ? TextButton.icon(
                  onPressed: cubit.editAction,
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap, // Reduce the touch target size
                    visualDensity: VisualDensity.compact,
                  ),
                  label: CircularProgressIndicator(
                    color: context.colorScheme.onSecondary,
                  ),
                )
              : !state.edit
                  ? TextButton.icon(
                      onPressed: cubit.editAction,
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap, // Reduce the touch target size
                        visualDensity: VisualDensity.compact,
                      ),
                      label: Text(
                        'Edit',
                        style: context.textTheme.titleMedium!.copyWith(
                          color: context.colorScheme.onSecondary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      icon: Icon(
                        Icons.edit,
                        color: context.colorScheme.onSecondary,
                      ),
                    )
                  : TextButton(
                      onPressed: cubit.saveAction,
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap, // Reduce the touch target size
                        visualDensity: VisualDensity.compact,
                      ),
                      child: Text(
                        'Save',
                        style: context.textTheme.titleMedium!.copyWith(
                          color: context.colorScheme.onSecondary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    )
        ],
      ),
    );
  }
}
