import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:path/path.dart';
import 'package:reentry_roadmap/core/extensions/theme_extension.dart';
import 'package:reentry_roadmap/core/utils/assets.dart';
import 'package:reentry_roadmap/core/utils/constants.dart';
import 'package:reentry_roadmap/presentation/pages/main/provider/provider_detail/provider_detail_cubit.dart';
import 'package:reentry_roadmap/presentation/pages/main/provider/provider_detail/provider_detail_state.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_button.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_cached_image.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_responsive_builder.dart';

import 'provider_detail_footer.dart';

class ProviderDetailHeader extends StatelessWidget {
  final ProviderDetailCubit cubit;

  ProviderDetailHeader({super.key, required this.cubit});

  final CustomInfoWindowController _customInfoWindowController =
      CustomInfoWindowController();

  ProviderDetailState get state => cubit.state;

  @override
  Widget build(BuildContext context) {
    return CustomResponsiveBuilder(builder: (context, constraints, deviceSize) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: deviceSize == DeviceSize.web ? 450 : null,
            padding: const EdgeInsets.all(15),
            margin: deviceSize == DeviceSize.web? const EdgeInsets.symmetric(
              horizontal: 40,
              vertical: 20
            ):null,
            decoration: BoxDecoration(
              color: context.colorScheme.surfaceDim,
              borderRadius: deviceSize == DeviceSize.web?BorderRadius.circular(20):null
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                _headerTopSection(context),
                const SizedBox(
                  height: 20,
                ),
                const Divider(
                  thickness: 1,
                  height: 0,
                ),
                const SizedBox(
                  height: 20,
                ),
                _headerMiddleSection(context),
                const SizedBox(
                  height: 10,
                ),
                _headerMapSection(context),
                const SizedBox(
                  height: 22,
                ),
                deviceSize == DeviceSize.web?const SizedBox.shrink():ProviderDetailFooter(
                  cubit: cubit,
                ),
              ],
            ),
          ),
          Visibility(
            visible: deviceSize == DeviceSize.web,
            child: CustomButton(
              text:
                  "Contact ${state.provider.onboardingInfo!.providerDetails!.providerNameLocation}",
              onTap: cubit.contactAction,
              width: 450,
              height: 70,
            ),
          )
        ],
      );
    });
  }

  Widget _headerTopSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "${state.provider.onboardingInfo!.providerDetails!.providerNameLocation} >",
          style: context.textTheme.bodyLarge?.copyWith(
            color: context.colorScheme.secondaryFixed,
            decoration: TextDecoration.underline,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          "${state.provider.onboardingInfo!.providerDetails!.providerNameLocation}",
          style: context.textTheme.titleMedium,
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
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
                    "${state.provider.avgRating} (${state.provider.totalReviews})",
                    style: context.textTheme.bodyMedium
                        ?.copyWith(color: context.colorScheme.onPrimary),
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            SvgPicture.asset(
              Assets.verified,
              height: 15,
              width: 15,
            ),
            const SizedBox(
              width: 5,
            ),
            Text(
              "Claimed",
              style: context.textTheme.bodyLarge?.copyWith(
                color: context.colorScheme.secondaryFixed,
              ),
            ),
          ],
        )
      ],
    );
  }

  Widget _headerMiddleSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 10,
          children: [
            _categoryContainer(title: "Education", context: context),
            _categoryContainer(title: "Employment", context: context),
            _categoryContainer(title: "Life Skills", context: context),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        _iconWithText(
            iconPath: Assets.arrow,
            title:
                "${state.provider.onboardingInfo!.providerDetails!.relationReentry}",
            context: context),
        _iconWithText(
            iconPath: Assets.web,
            title:
                "${state.provider.onboardingInfo!.providerDetails!.orgWebsite}",
            context: context),
        _iconWithText(
            iconPath: Assets.clock,
            title: "Mon - Sun, 9am - 5am",
            context: context),
        _iconWithText(
            iconPath: Assets.location,
            title: state.provider.completeAddress,
            context: context),
      ],
    );
  }

  Widget _categoryContainer(
      {required BuildContext context, required String title}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: context.colorScheme.secondaryFixed,
      ),
      child: Text(
        title,
        style: context.textTheme.bodySmall
            ?.copyWith(color: context.colorScheme.onSecondary),
      ),
    );
  }

  Widget _headerMapSection(BuildContext context) {
    return SizedBox(
      height: 255,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Stack(
          children: [
            GoogleMap(
              mapType: MapType.normal,
              zoomControlsEnabled: false,
              zoomGesturesEnabled: false,
              markers: {
                const Marker(
                  markerId: MarkerId("123"),
                  position: LatLng(37.42796133580664, -122.085749655962),
                )
              },
              initialCameraPosition: const CameraPosition(
                target: LatLng(37.42796133580664, -122.085749655962),
                zoom: 14.4746,
              ),
              onMapCreated: (GoogleMapController controller) {
                _customInfoWindowController.googleMapController = controller;
                _showInfoWindowOverMap(context);
              },
            ),
            CustomInfoWindow(
              controller: _customInfoWindowController,
              height: 80,
              width: 180,
              offset: 10,
            ),
          ],
        ),
      ),
    );
  }

  _showInfoWindowOverMap(BuildContext context) {
    _customInfoWindowController.addInfoWindow!(
        Container(
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(15)),
          child: Row(
            children: [
              CustomCachedImage(
                width: 80,
                borderRadius: BorderRadius.circular(10),
                imgUrl:
                    "${state.provider.onboardingInfo?.providerDetails?.images?.first ?? kPlaceHolderImage}",
              ),
              const SizedBox(
                width: 10,
              ),
              SizedBox(
                width: 70,
                child: Text(
                  "${state.provider.onboardingInfo?.providerDetails?.providerNameLocation}",
                  style: context.textTheme.bodySmall
                      ?.copyWith(fontWeight: FontWeight.bold),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              )
            ],
          ),
        ),
        LatLng(37.42796133580664, -122.085749655962));
  }

  Widget _iconWithText(
      {required String iconPath,
      required String title,
      required BuildContext context}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          SvgPicture.asset(
            iconPath,
            height: 15,
            width: 15,
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Text(
              title,
              style: context.textTheme.bodyLarge?.copyWith(
                color: context.colorScheme.secondaryFixed,
              ),
            ),
          )
        ],
      ),
    );
  }
}
