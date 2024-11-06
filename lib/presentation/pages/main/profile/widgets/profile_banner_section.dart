import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:reentry_roadmap/core/extensions/theme_extension.dart';
import 'package:reentry_roadmap/presentation/pages/main/profile/profile_cubit.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_button.dart';

class ProfileBannerSection extends StatelessWidget {
  const ProfileBannerSection({
    super.key,
    required this.cubit,
  });

  final ProfileCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: context.colorScheme.secondary,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(20),
      child: Wrap(
        alignment: WrapAlignment.spaceBetween,
        crossAxisAlignment: WrapCrossAlignment.center,
        runAlignment: WrapAlignment.end,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                textAlign: TextAlign.start,
                text: TextSpan(
                    text: 'Update your profile with a ',
                    style: context.textTheme.titleLarge
                        ?.copyWith(color: context.themeData.colorScheme.onSecondary, fontWeight: FontWeight.w600),
                    children: [
                      TextSpan(
                        text: 'Check-In',
                        style: context.textTheme.titleLarge?.copyWith(
                            color: context.themeData.colorScheme.onSecondary,
                            fontWeight: FontWeight.w600,
                            decoration: TextDecoration.underline),
                        recognizer: TapGestureRecognizer()..onTap = () {},
                      ),
                    ]),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Check-ins help us learn your latest needs so we can get you the best services',
                maxLines: 10,
                style: context.textTheme.bodyMedium
                    ?.copyWith(fontWeight: FontWeight.w500, fontSize: 15, color: Colors.white),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
          LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return CustomButton(
                text: 'Learn More',
                width: constraints.maxWidth > 350 ? 200 : constraints.maxWidth,
                onTap: cubit.openMore,
              );
            },
          )
        ],
      ),
    );
  }
}
