import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:reentry_roadmap/core/extensions/theme_extension.dart';
import 'package:reentry_roadmap/core/navigation/app_navigator.dart';
import 'package:reentry_roadmap/core/theme/light_theme.dart';
import 'package:reentry_roadmap/core/utils/constants.dart';
import 'package:reentry_roadmap/domain/entities/provider.dart';
import 'package:reentry_roadmap/domain/stores/user_store.dart';
import 'package:reentry_roadmap/presentation/pages/authentication/sign_up/sign_up_page.dart';
import 'package:reentry_roadmap/presentation/pages/main/notification/notification_initial_params.dart';
import 'package:reentry_roadmap/presentation/pages/main/organization/organization_detail/organization_detail_cubit.dart';
import 'package:reentry_roadmap/presentation/pages/main/organization/organization_detail/organization_detail_state.dart';
import 'package:reentry_roadmap/presentation/widgets/header_logo.dart';

import '../../../../../core/utils/assets.dart';
import '../../../../../domain/entities/login_user.dart';
import '../../../../widgets/custom_cached_image.dart';
import '../../../../widgets/custom_expansion_tile.dart';
import '../../../../widgets/header_auth_buttons.dart';
import '../../../../widgets/service_card_category_chip.dart';
import '../../../authentication/login/login_initial_params.dart';
import '../../../authentication/login/login_page.dart';
import '../../../authentication/sign_up/sign_up_initial_params.dart';
import '../../notification/notification_page.dart';
import 'organization_detail_initial_params.dart';

class OrganizationDetailPage extends StatefulWidget {
  final OrganizationDetailCubit cubit;
  final OrganizationDetailInitialParams initialParams;

  static const path = '/OrganizationDetailPage';

  const OrganizationDetailPage({
    super.key,
    required this.cubit,
    required this.initialParams,
  });

  @override
  State<OrganizationDetailPage> createState() => _OrganizationDetailPageState();
}

class _OrganizationDetailPageState extends State<OrganizationDetailPage> {
  OrganizationDetailCubit get cubit => widget.cubit;

  @override
  void initState() {
    cubit.onInit(widget.initialParams);
    super.initState();
  }

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
                  bloc: widget.cubit.userStore,
                  builder: (ctx, state) {
                    return state.isLoggedIn
                        ? IconButton(
                            onPressed: () => AppNavigator().push(
                                context,
                                NotificationPage.path,
                                const NotificationInitialParams()),
                            icon: SvgPicture.asset(Assets.notification))
                        : HeaderAuthButtons(
                            loginAction: () => AppNavigator().push(context,
                                LoginPage.path, const LoginInitialParams()),
                            signUpAction: () => AppNavigator().push(context,
                                SignUpPage.path, const SignUpInitialParams()),
                            isMobileView: true,
                          );
                  },
                ),
              )
            ],
          );
        }),
      ),
      body: BlocBuilder<OrganizationDetailCubit, OrganizationDetailState>(
        bloc: cubit,
        builder: (context, state) {
          return SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 26),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        state.orgData.orgName ?? "",
                        style: context.textTheme.bodyMedium?.copyWith(
                            color: context.themeData.colorScheme.onSurface,
                            fontSize: 20,
                            fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 27),
                      Text(
                        state.orgData.orgDescription ?? "",
                        style: context.textTheme.bodyMedium?.copyWith(
                            color: context.themeData.colorScheme.onSurface,
                            fontSize: 15,
                            fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 25),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          for (var index = 0;
                              index < (state.orgData.categories ?? []).length;
                              index++)
                            CustomExpansionTile(
                              title: state.orgData.categories?[index].title ??
                                  "N/A",
                              showLine: index !=
                                  (state.orgData.categories ?? []).length - 1,
                              children: [
                                for (var subCategory in state.orgData
                                        .categories?[index].subCategories ??
                                    [])
                                  _subCategoryTile(
                                      context: context, title: subCategory),
                              ],
                            ),
                        ],
                      )
                    ],
                  ),
                ),
                _outTake(),
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
                          itemCount: state.providerList.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) => _providerCard(
                              index: index,
                              providerData: state.providerList[index]),
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 30)),
                    ],
                  ),
                )
              ],
            ),
          );
        },
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

  Widget _outTake() {
    return Container(
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
            padding: const EdgeInsets.symmetric(vertical: 23, horizontal: 28),
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
        Expanded(
          child: Column(
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
          ),
        )
      ],
    );
  }

  Widget _providerCard({required int index, Provider? providerData}) {
    List<String> eligibilityCriteria =
        providerData?.getAllEligibilityCriteria().take(2).toList() ?? [];
    List<String> features =
        providerData?.getAllFeatures().take(2).toList() ?? [];

    return Container(
      decoration: BoxDecoration(
        color: lightBlueColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _serviceImage(context: context, providerData: providerData),
            const SizedBox(height: 20),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: providerData?.onboardingInfo?.providerDetails
                            ?.providerNameLocation ??
                        "",
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: lightGreenColor,
                      fontWeight: FontWeight.w500,
                      overflow: TextOverflow.ellipsis,
                      fontSize: 15,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  TextSpan(
                    text: " >",
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: lightGreenColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 5),
            _serviceTitle(
                context: context,
                title: providerData?.onboardingInfo?.providerDetails
                        ?.providerNameLocation ??
                    ""),
            const SizedBox(height: 5),
            _locationWidget(
                context: context,
                location: providerData?.completeAddress ?? ""),
            const SizedBox(height: 20),
            _serviceCategories(context: context, providerData: providerData),
            const SizedBox(height: 32),
            if (eligibilityCriteria.isNotEmpty) ...[
              Text(
                "Eligibility Criteria",
                style: context.textTheme.bodyMedium
                    ?.copyWith(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 10),
              for (var info in eligibilityCriteria)
                _featureOrEligibilityTile(context: context, title: info),
              SizedBox(height: features.isEmpty ? 30 : 15),
            ],
            if (features.isNotEmpty) ...[
              Text(
                "Features",
                style: context.textTheme.bodyMedium
                    ?.copyWith(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 10),
              for (var info in features)
                _featureOrEligibilityTile(context: context, title: info),
              const SizedBox(height: 30),
            ],
            Container(
              width: double.maxFinite,
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
              decoration: BoxDecoration(
                  color: context.themeData.primaryColor,
                  borderRadius: BorderRadius.circular(10)),
              child: Row(
                children: [
                  SvgPicture.asset(Assets.starCheck),
                  const SizedBox(width: 5),
                  Text(
                    index == 0 ? "Eligible!" : "Most Likely Eligible",
                    style: context.textTheme.bodyMedium?.copyWith(
                        color: context.themeData.colorScheme.onPrimary,
                        fontSize: 12,
                        fontWeight: FontWeight.w500),
                  ),
                  const Spacer(),
                  Text(
                    "for 4 programs",
                    style: context.textTheme.bodySmall?.copyWith(
                        color: context.themeData.colorScheme.onPrimary
                            .withOpacity(0.5),
                        fontSize: 12),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _serviceImage(
      {required BuildContext context, Provider? providerData}) {
    return Stack(
      children: [
        CustomCachedImage(
          radius: 10,
          width: double.maxFinite,
          height: 210,
          imgUrl: (providerData?.onboardingInfo?.providerDetails?.images ?? [])
                  .isEmpty
              ? kPlaceHolderImage
              : providerData?.onboardingInfo?.providerDetails?.images?.first,
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
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
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
                    size: 12,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    "${providerData?.avgRating ?? "0.0"} (${providerData?.totalReviews ?? "0"})",
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
        const SizedBox(width: 5),
        Expanded(
          child: Text(
            location,
            style: context.textTheme.bodySmall?.copyWith(
              color: lightGreenColor,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        )
      ],
    );
  }

  Widget _serviceTitle({required String title, required BuildContext context}) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: title,
            style: context.textTheme.titleSmall?.copyWith(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          WidgetSpan(
              alignment: PlaceholderAlignment.top,
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: SvgPicture.asset(Assets.verified, height: 16, width: 15),
              )),
        ],
      ),
    );
  }

  Widget _serviceCategories(
      {required BuildContext context, Provider? providerData}) {
    List<String> categories = providerData?.getAllCategories() ?? [];
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
