import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:reentry_roadmap/presentation/pages/main/review/review_cubit.dart';
import 'package:reentry_roadmap/presentation/pages/main/review/widgets/service_provider_card.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../../core/utils/constants.dart';
import '../../../../../data/repositories/database/services_provider_accessed_imp.dart';
import '../../../../../domain/entities/login_user.dart';
import '../../../../../domain/entities/provider.dart';
import '../../../../../domain/stores/user_store.dart';
import '../../../../widgets/provider_service_card.dart';
import '../../explore/widgets/explore_services_slider.dart';
import '../review_state.dart';
/// The Service Provider Card need to be changed with the new Service Card that need to be created
class ReviewServicesSection extends StatelessWidget {
  final ReviewCubit cubit;

  const ReviewServicesSection({Key? key, required this.cubit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReviewCubit, ReviewState>(
      bloc: cubit, // Reuse the provided cubit instead of creating a new one
      builder: (context, state) {
        if (state.loading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state.services.isEmpty) {
          return const Center(child: Text("No services accessed yet."));
        }

        return LayoutBuilder(builder: (context, constraints) {
          return
            constraints.maxWidth < kMenuBreakPoint ?
            ListView.builder(
              itemCount: state.services.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final serviceProviderAccessed = state.services[index];
                return ServiceProviderCard(
                  serviceProvider: serviceProviderAccessed, onTap: () {
                  cubit.showRateCard(title: serviceProviderAccessed.name ??
                      "Service Provider");
                },
                );
              },
            ) : GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4, // Number of columns
                childAspectRatio: 0.7, // Adjust aspect ratio for card size
                crossAxisSpacing: 16.0, // Space between columns
                mainAxisSpacing: 16.0, // Space between rows
              ),
              itemCount: state.services.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final serviceProviderAccessed = state.services[index];
                //ToDo: The Service Provider Card need to be changed with the new Service Card that need to be created
                return ServiceProviderCard(
                  serviceProvider: serviceProviderAccessed,
                    onTap: () {
                  cubit.showRateCard(title: serviceProviderAccessed.name ??
                      "Service Provider");
                  }
                );
              },


            );
        },
        );
      });
  }
  }

