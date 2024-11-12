import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:reentry_roadmap/core/extensions/double_extension.dart';
import 'package:reentry_roadmap/core/extensions/theme_extension.dart';
import 'package:reentry_roadmap/core/theme/light_theme.dart';
import 'package:reentry_roadmap/core/utils/assets.dart';
import 'package:reentry_roadmap/core/utils/resposive.dart';
import 'package:reentry_roadmap/presentation/pages/main/my_services/my_services_cubit.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_button.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_responsive_builder.dart';

class LoginViewMyServicesSection extends StatelessWidget {
  const LoginViewMyServicesSection({super.key,required this.cubit});
final MyServicesCubit cubit;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: CustomResponsiveBuilder(
        builder: (context, boxConstraints, deviceSize) {

          return deviceSize == DeviceSize.mobile?_buildMobileView(context): Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              SvgPicture.asset(
                Assets.login,
                width: 100,
                height: 150,
              ),
              50.verticalSpace,
              Text(
                "Sign In to save service providers",
                textAlign: TextAlign.center,
                style: context.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w500,
                    fontSize: Responsive.isDesktop(context) ? 30 : 20),
              ),
              24.verticalSpace,
              _buildBtns(context)
            ],
          );
        },
      ),
    );
  }

  _buildMobileView(BuildContext context) {
    return Column(
      children: [
        20.verticalSpace,
        Text(
          "My Services",
          textAlign: TextAlign.center,
          style: context.textTheme.titleLarge
              ?.copyWith(fontWeight: FontWeight.w500, fontSize: 20),
        ),
        const Spacer(),
        SvgPicture.asset(
          Assets.login,
          width: 150,
          height: 130,
        ),
        const Spacer(),
        Text(
          "Sign In to save service providers",
          textAlign: TextAlign.center,
          style: context.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w500,
              fontSize: Responsive.isDesktop(context) ? 30 : 20),
        ),
        20.verticalSpace,
        _buildBtns(context),
        20.verticalSpace,
      ],
    );
  }

  _buildBtns(BuildContext context) {
    return  CustomResponsiveBuilder(
      builder: (context , boxConstraints , deviceSize ) {

        return SizedBox(
          width: deviceSize == DeviceSize.web? MediaQuery.of(context).size.width * 0.4:null,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                  child: CustomButton(
                    color: lightSurfaceContainerColor,

                    onTap:    () {
                        cubit.openLoginScreenAction();
                    },
                    text: "Log in",
                    width: 140,
                    height:deviceSize == DeviceSize.web? 80:60,
                  )),
              20.horizontalSpace,
              Expanded(
                  child: CustomButton(
                    text: "Sign up",
                    width: 100,
                    height:deviceSize == DeviceSize.web? 80: 60,
                    onTap:    () {
                      cubit.openSignupScreenAction();
                    },
                  ))
            ],
          ),
        );
      },

    );
  }
}
