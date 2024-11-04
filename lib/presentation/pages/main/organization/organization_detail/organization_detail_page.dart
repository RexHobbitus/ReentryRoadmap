import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:reentry_roadmap/core/extensions/theme_extension.dart';
import 'package:reentry_roadmap/core/navigation/app_navigator.dart';
import 'package:reentry_roadmap/core/theme/light_theme.dart';
import 'package:reentry_roadmap/core/utils/constants.dart';
import 'package:reentry_roadmap/domain/stores/user_store.dart';
import 'package:reentry_roadmap/presentation/pages/authentication/sign_up/sign_up_page.dart';
import 'package:reentry_roadmap/presentation/pages/main/organization/organization_detail/organization_detail_cubit.dart';
import 'package:reentry_roadmap/presentation/widgets/header_logo.dart';

import '../../../../../core/utils/assets.dart';
import '../../../../../domain/entities/login_user.dart';
import '../../../../widgets/custom_cached_image.dart';
import '../../../../widgets/custom_expansion_tile.dart';
import '../../../../widgets/header_auth_buttons.dart';
import '../../../../widgets/service_card_category_chip.dart';
import '../../../authentication/login/login_page.dart';
import '../../notification/notification_page.dart';

class OrganizationDetailPage extends StatelessWidget {
  final OrganizationDetailCubit cubit;

  static const path = '/OrganizationDetailPage';

  const OrganizationDetailPage({
    super.key,
    required this.cubit,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leadingWidth: double.maxFinite,
        leading: LayoutBuilder(builder: (con, constraints) {
          debugPrint("Leading layout ${constraints.maxWidth.toString()}");
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const HeaderLogo(),
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: BlocBuilder<UserStore, LoginUser>(
                  bloc: cubit.userStore,
                  builder: (ctx, state) {
                    return state.isLoggedIn
                        ? IconButton(
                            onPressed: () => AppNavigator()
                                .push(context, NotificationPage.path, null),
                            icon: SvgPicture.asset(Assets.notification))
                        : HeaderAuthButtons(
                            loginAction: () => AppNavigator()
                                .push(context, LoginPage.path, null),
                            signUpAction: () => AppNavigator()
                                .push(context, SignUpPage.path, null),
                            isMobileView: true,
                          );
                  },
                ),
              )
            ],
          );
        }),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 26),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "OpenGate Foundation",
                    style: context.textTheme.bodyMedium?.copyWith(
                        color: context.themeData.colorScheme.onSurface,
                        fontSize: 20,
                        fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 27),
                  Text(
                    "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum. It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum. It is a long established fact that a reader. It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum. It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum. It is a long established fact that a reader. The point of using Lorem Ipsum. It is a long established fact that a reader.",
                    style: context.textTheme.bodyMedium?.copyWith(
                        color: context.themeData.colorScheme.onSurface,
                        fontSize: 15,
                        fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 25),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomExpansionTile(
                        title: "Education",
                        children: [
                          _subCategoryTile(
                              context: context, title: "No formal education"),
                          _subCategoryTile(
                              context: context, title: "Primary education"),
                          _subCategoryTile(
                              context: context,
                              title: "Secondary education or high school"),
                          _subCategoryTile(
                              context: context, title: "Bachelor's degree"),
                          _subCategoryTile(
                              context: context, title: "Master's degree"),
                        ],
                      ),
                      CustomExpansionTile(
                        title: "Employment",
                        children: [
                          _subCategoryTile(context: context, title: "Employed"),
                          _subCategoryTile(
                              context: context, title: "Self-employed"),
                          _subCategoryTile(
                              context: context, title: "Out of work"),
                          _subCategoryTile(
                              context: context, title: "Homemaker"),
                          _subCategoryTile(context: context, title: "Student"),
                          _subCategoryTile(context: context, title: "Retired"),
                        ],
                      ),
                      CustomExpansionTile(
                        title: "Housing",
                        showLine: false,
                        children: [
                          _subCategoryTile(
                              context: context, title: "Apartment"),
                          _subCategoryTile(context: context, title: "Condo"),
                          _subCategoryTile(
                              context: context, title: "Townhouse"),
                          _subCategoryTile(
                              context: context, title: "Single-family Home"),
                          _subCategoryTile(context: context, title: "Duplex"),
                          _subCategoryTile(context: context, title: "Studio"),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
            Container(
              width: double.maxFinite,
              decoration: const BoxDecoration(
                color: lightBlueColor,
                // color: Color(0xFFF1F6F8)
              ),
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Our Take",
                    style: context.textTheme.bodyMedium?.copyWith(
                        color: context.themeData.colorScheme.onSurface,
                        fontSize: 20,
                        fontWeight: FontWeight.w600),
                  ),
                  Row(
                    children: [
                      Text(
                        "Our Rating",
                        style: context.textTheme.bodyMedium?.copyWith(
                            color: context.themeData.colorScheme.onSurface,
                            fontSize: 15,
                            fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(width: 10),
                      _ourRating(context: context),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Text(
                    "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum. It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum. It is a long established fact that a reader. It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum. It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum. It is a long established fact that a reader. The point of using Lorem Ipsum. It is a long established fact that a reader. It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.",
                    style: context.textTheme.bodyMedium?.copyWith(
                        color: context.themeData.colorScheme.onSurface,
                        fontSize: 12,
                        fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 30),
                  _ceoInformation(context: context),
                  const SizedBox(height: 30),
                  Container(
                    decoration: BoxDecoration(
                        // color: context.themeData.colorScheme.tertiaryContainer,
                        color: const Color(0XffBFD4D9),
                        borderRadius: BorderRadius.circular(10)),
                    padding: const EdgeInsets.symmetric(
                        vertical: 23, horizontal: 28),
                    child: Text(
                      "Disclaimer: This is our opinions, meant to help you make a decision and not a factual disclaimer of the company. Our team has attempted to make it as accurate as possible at the time of publishing",
                      style: context.textTheme.bodyMedium?.copyWith(
                          color: context.themeData.colorScheme.onSurface,
                          fontSize: 12,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.all(30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Providers under this organization",
                    style: context.textTheme.bodyMedium?.copyWith(
                        color: context.themeData.colorScheme.onSurface,
                        fontSize: 20,
                        fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 30),
                  ListView.separated(
                      itemCount: 3,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) => Container(
                            decoration: BoxDecoration(
                              color: lightBlueColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 26, vertical: 28),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _serviceImage(context: context),
                                  const SizedBox(height: 20),
                                  Row(
                                    children: [
                                      Text(
                                        "Opengate Foundation",
                                        style: context.textTheme.bodyMedium
                                            ?.copyWith(
                                          color: lightGreenColor,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 15,
                                          decoration: TextDecoration.underline,
                                        ),
                                      ),
                                      Text(
                                        " >",
                                        style: context.textTheme.bodyMedium
                                            ?.copyWith(
                                          color: lightGreenColor,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 5),
                                  _serviceTitle(
                                      context: context,
                                      title: "OpenGate Oakland"),
                                  const SizedBox(height: 5),
                                  _locationWidget(
                                      context: context,
                                      location:
                                          "5506 Martha Ave, Hayward, CA 99922"),
                                  const SizedBox(height: 20),
                                  _serviceCategories(context: context),
                                  const SizedBox(height: 32),
                                  Text(
                                    "Eligibility Criteria",
                                    style: context.textTheme.bodyMedium
                                        ?.copyWith(fontWeight: FontWeight.w600),
                                  ),
                                  const SizedBox(height: 10),
                                  _featureOrEligibilityTile(
                                      context: context, title: 'Woman'),
                                  _featureOrEligibilityTile(
                                      context: context,
                                      title: 'Within 5 years of incarceration',
                                      showCheck: index == 0),
                                  const SizedBox(height: 15),
                                  Text(
                                    "Features",
                                    style: context.textTheme.bodyMedium
                                        ?.copyWith(fontWeight: FontWeight.w600),
                                  ),
                                  const SizedBox(height: 10),
                                  _featureOrEligibilityTile(
                                      context: context,
                                      title: 'Holistsic Wrap-around Service'),
                                  _featureOrEligibilityTile(
                                      context: context,
                                      title:
                                          'Formerly Incarcerated Leadership'),
                                  const SizedBox(height: 30),
                                  Container(
                                    width: double.maxFinite,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 15, horizontal: 10),
                                    decoration: BoxDecoration(
                                        color: context.themeData.primaryColor,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Row(
                                      children: [
                                        SvgPicture.asset(Assets.starCheck),
                                        const SizedBox(width: 5),
                                        Text(
                                          index == 0
                                              ? "Eligible!"
                                              : "Most Likely Eligible",
                                          style: context.textTheme.bodyMedium
                                              ?.copyWith(
                                                  color: context.themeData
                                                      .colorScheme.onPrimary,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500),
                                        ),
                                        const Spacer(),
                                        Text(
                                          "for 4 programs",
                                          style: context.textTheme.bodySmall
                                              ?.copyWith(
                                                  color: context.themeData
                                                      .colorScheme.onPrimary
                                                      .withOpacity(0.5),
                                                  fontSize: 12),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 30)),
                ],
              ),
            )
          ],
        ),
      ),
      // bottomNavigationBar: ProviderDetailFooter(
      //   cubit: cubit,
      // ),
    );
  }

  Widget _subCategoryTile(
      {required BuildContext context,
      required String title,
      bool hideDivider = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: context.textTheme.bodyMedium,
          ),
          hideDivider
              ? const SizedBox.shrink()
              : const SizedBox(
                  height: 5,
                ),
          hideDivider
              ? const SizedBox.shrink()
              : const Divider(
                  thickness: 0.5,
                  height: 2,
                ),
        ],
      ),
    );
  }

  Widget _ourRating({required BuildContext context}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
          // color: context.themeData.colorScheme.secondary,
          color: const Color(0xFF11404C),
          borderRadius: BorderRadius.circular(5)),
      child: Row(
        children: [
          const Icon(
            Icons.star,
            size: 14,
            // color: context.colorScheme.onSecondary,
            // color: context.colorScheme.tertiaryContainer,
            color: Color(0xFFBFD4D9),
          ),
          Text(
            " 4.2",
            style: context.textTheme.bodySmall?.copyWith(
                color: context.colorScheme.onSecondary,
                fontWeight: FontWeight.w500),
          )
        ],
      ),
    );
  }

  Widget _ceoInformation({required BuildContext context}) {
    return Row(
      children: [
        const CircleAvatar(
          radius: 20,
          backgroundImage: CachedNetworkImageProvider(
              "https://images.ctfassets.net/h6goo9gw1hh6/2sNZtFAWOdP1lmQ33VwRN3/24e953b920a9cd0ff2e1d587742a2472/1-intro-photo-final.jpg?w=1200&h=992&fl=progressive&q=70&fm=jpg"),
        ),
        const SizedBox(width: 20),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Danny Yoon",
              style: context.textTheme.bodyMedium
                  ?.copyWith(fontSize: 15, fontWeight: FontWeight.w500),
            ),
            Text(
              "CEO of Dignifi",
              style: context.textTheme.bodyMedium
                  ?.copyWith(fontSize: 12, fontWeight: FontWeight.w500),
            ),
          ],
        )
      ],
    );
  }

  Widget _serviceImage({required BuildContext context}) {
    return Stack(
      children: [
        const CustomCachedImage(
          radius: 10,
          width: double.maxFinite,
          height: 210,
          imgUrl: kPlaceHolderImage,
        ),
        // Gradient overlay
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: LinearGradient(
                begin: Alignment.bottomCenter, // Bottom
                end: Alignment.topCenter, // Top
                colors: [
                  Colors.black.withOpacity(0.8),
                  // Start with black at the bottom
                  Colors.black.withOpacity(0.0),
                  // Gradually become transparent at the top
                ],
                stops: const [
                  0.0068,
                  0.3274
                ], // Corresponding to 0.68% and 32.74%
              ),
            ),
          ),
        ),
        Positioned.fill(
          child: Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              decoration: BoxDecoration(
                color: context.themeData.colorScheme.primary,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.star,
                    color: context.themeData.colorScheme.tertiaryContainer,
                    size: 10,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    "4.9 (189)",
                    style: context.textTheme.bodySmall
                        ?.copyWith(color: context.colorScheme.onPrimary),
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget _locationWidget(
      {required String location, required BuildContext context}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgPicture.asset(Assets.location),
        const SizedBox(
          width: 5,
        ),
        Text(
          location,
          style: context.textTheme.bodySmall?.copyWith(
            color: lightGreenColor,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        )
      ],
    );
  }

  Widget _serviceTitle({required String title, required BuildContext context}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          style: context.textTheme.titleSmall?.copyWith(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(width: 10),
        SvgPicture.asset(Assets.verified, height: 16, width: 15),
      ],
    );
  }

  Widget _serviceCategories({required BuildContext context}) {
    List<String> categories = kServiceCategories.map((e) => e.title).toList();
    int maxLimit = 4;
    return Wrap(
      //  mainAxisSize: MainAxisSize.min,
      runSpacing: 10,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        for (var category in List.from(categories).take(maxLimit).toList())
          ServiceCardCategoryChip(
            title: category,
            bgColor: const Color(0xFFBFD4D9),
          ),
        categories.length > maxLimit
            ? Text(
                "+ ${categories.length - maxLimit} More",
                style: context.textTheme.bodyMedium?.copyWith(
                    color: context.themeData.colorScheme.tertiary,
                    fontSize: 10,
                    fontWeight: FontWeight.w500),
              )
            : const SizedBox.shrink(),
      ],
    );
  }

  Widget _featureOrEligibilityTile(
      {required BuildContext context,
      required String title,
      bool showCheck = true}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          if (showCheck)
            CircleAvatar(
              radius: 8,
              backgroundColor: context.colorScheme.primary,
              child: Icon(
                Icons.check,
                size: 10,
                color: context.colorScheme.onPrimary,
              ),
            )
          else
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: CircleAvatar(
                radius: 3.5,
                backgroundColor: context.themeData.colorScheme.secondary,
              ),
            ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              title,
              style: context.textTheme.bodyMedium,
            ),
          )
        ],
      ),
    );
  }
}
