import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reentry_roadmap/presentation/pages/main/my_services/cubits/my_services_tile_cubit.dart';
import 'package:reentry_roadmap/presentation/pages/main/my_services/my_services_cubit.dart';
import 'package:reentry_roadmap/presentation/pages/main/my_services/widgets/no_services_view.dart';
import 'package:reentry_roadmap/presentation/pages/main/my_services/widgets/services_tile.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_responsive_builder.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_scroll_view.dart';

class InEligibleServices extends StatelessWidget {
  const InEligibleServices({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomSingleChildScrollView( 
      child: CustomResponsiveBuilder(
        builder: (context, constraints, deviseSize) {
          return context.read<MyServicesCubit>().filteredServices.isEmpty
              ? const NoServicesView(
              title: "You have no ineligible services yet",
              desc: "Ineligible services will appear here") : Center(
            child: Wrap(
              spacing: 20,
              runSpacing: 20,
              children: List.generate(
                context.read<MyServicesCubit>().filteredServices.length,
                    (index) {
                  return BlocProvider(
                    create: (context) =>
                        MyServicesTileCubit(
                            context.read<MyServicesCubit>().filteredServices[index]),
                    child: ServicesTile(
                                  onBtnTap:(){

                                  },
                      onTap: (p0) {},
                      myService: context.read<MyServicesCubit>().filteredServices[index],
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
