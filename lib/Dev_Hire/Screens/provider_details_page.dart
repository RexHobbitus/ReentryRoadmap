import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:reentry_roadmap/Dev_Hire/Utils/Customs/Widgets/provider_personal_info.dart';
import 'package:reentry_roadmap/Dev_Hire/Utils/Customs/custom_appbar.dart';
import 'package:reentry_roadmap/presentation/pages/photos/photos_page.dart';
import 'package:reentry_roadmap/presentation/pages/program_details/program_details_screen.dart';
import 'package:reentry_roadmap/presentation/pages/review/review_page.dart';
import '../Utils/Customs/Widgets/custom_profile.dart';
import '../Utils/Customs/Widgets/custom_tabbar.dart';
import '../Utils/Customs/Widgets/provider_contact_details.dart';
import 'provider_details_bloc.dart'; // Import the bloc file

class ProviderDetailsPage extends StatelessWidget {
  const ProviderDetailsPage({super.key});

  static const path = '/ProviderDetailsPage';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProviderDetailsBloc(),
      child: const ProviderDetailsView(),
    );
  }
}

class ProviderDetailsView extends StatelessWidget {
  const ProviderDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return BlocBuilder<ProviderDetailsBloc, ProviderDetailsState>(
          builder: (context, state) {
            // Get the selected index from the state
            final selectedIndex =
                state is ProviderDetailsInitial ? state.selectedIndex : 0;

            return Scaffold(
              appBar: const CustomAppBar(),
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: ScrollConfiguration(
                  behavior: const ScrollBehavior()
                      .copyWith(overscroll: false, scrollbars: false),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Column(
                          children: [
                            const Gap(21),
                            const CustomProfile(),
                            const Gap(21),
                            CustomTabBar(selectedIndex: selectedIndex),
                            const Divider(color: Color(0xffBFD4D9)),
                            // Display different content based on selected tab index
                            Center(
                              child: _buildContent(
                                  selectedIndex), // Call the new method to get the content
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  // Method to return different containers based on selected index
  Widget _buildContent(int index) {
    switch (index) {
      case 0:
        return Column(
          children: [
            ProviderContactDetails(),
            const Gap(48),
            ProviderPersonalInfo()
          ],
        );
      case 1:
        return const ProgramDetailsScreen();
      case 2:
        return PhotosPage();
      case 3:
        return const ReviewPage();
      default:
        return const SizedBox(); // Default empty container
    }
  }
}