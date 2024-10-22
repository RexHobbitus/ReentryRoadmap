import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:path/path.dart';
import 'package:reentry_roadmap/core/extensions/theme_extension.dart';
import 'package:reentry_roadmap/core/utils/assets.dart';
import 'package:reentry_roadmap/presentation/pages/main/provider/provider_detail/provider_detail_cubit.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_button.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_cached_image.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_responsive_builder.dart';

class ProviderDetailHeader extends StatelessWidget {
  final ProviderDetailCubit cubit;
  ProviderDetailHeader({super.key,required this.cubit});

  final CustomInfoWindowController _customInfoWindowController =
      CustomInfoWindowController();

  @override
  Widget build(BuildContext context) {
    return CustomResponsiveBuilder(
      builder: (context,constraints,deviceSize) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: deviceSize==DeviceSize.web?450:null,
              padding: const EdgeInsets.all(15),
              margin: const EdgeInsets.symmetric(vertical: 20),
              decoration: BoxDecoration(
                  color: context.themeData.cardColor,
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  _headerTopSection(context),
                  const SizedBox(
                    height: 10,
                  ),
                  const Divider(
                    thickness: 1,
                    height: 0,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  _headerMiddleSection(context),
                  const SizedBox(
                    height: 10,
                  ),
                  _headerMapSection(context),
                ],
              ),
            ),
            Visibility(
              visible: deviceSize==DeviceSize.web,
              child: CustomButton(
                text: "Contact OpenGate",
                onTap:cubit.contactAction,
                width: 450,
              ),
            )
          ],
        );
      }
    );
  }

  Widget _headerTopSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Opengate Foundation >",
          style: context.textTheme.bodyMedium?.copyWith(
            color: context.colorScheme.secondary,
            decoration: TextDecoration.underline,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          "OpenGate Hayward",
          style: context.textTheme.titleLarge
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        Row(
          children: [
            Container(
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
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            SvgPicture.asset(
              Assets.verified,
              height: 20,
            ),
            const SizedBox(
              width: 5,
            ),
            Text(
              "Claimed",
              style: context.textTheme.titleMedium?.copyWith(
                color: context.colorScheme.secondary,
                fontWeight: FontWeight.w500,
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
            title: "Reentry Adjacent",
            context: context),
        _iconWithText(
            iconPath: Assets.web, title: "Opengate.com", context: context),
        _iconWithText(
            iconPath: Assets.clock,
            title: "Mon - Sun, 9am - 5am",
            context: context),
        _iconWithText(
            iconPath: Assets.location,
            title: "630 Cherry Ave Long Beach, CA 90802",
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
        color: context.colorScheme.secondary,
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
      height: 200,
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
                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQhfZzej8jcEaKL35PlQhX4fY01mI5ubNIR7Q&s",
              ),
              const SizedBox(
                width: 10,
              ),
              SizedBox(
                width: 70,
                child: Text(
                  "OpenGate Foundation",
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
            height: 18,
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            title,
            style: context.textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: context.colorScheme.secondary),
          )
        ],
      ),
    );
  }
}
