import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:reentry_roadmap/core/extensions/double_extension.dart';
import 'package:reentry_roadmap/core/extensions/theme_extension.dart';
import 'package:reentry_roadmap/core/utils/constants.dart';
import 'package:reentry_roadmap/core/utils/resposive.dart';
import 'package:reentry_roadmap/domain/entities/my_service.dart';
import 'package:reentry_roadmap/presentation/pages/main/my_services/cubits/my_services_tile_cubit.dart';
import 'package:reentry_roadmap/presentation/pages/main/my_services/my_services_state.dart';
import 'package:reentry_roadmap/presentation/pages/main/my_services/widgets/desktop_tab_bar.dart';
import 'package:reentry_roadmap/presentation/pages/main/my_services/widgets/services_tile.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_responsive_builder.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_scroll_view.dart';

import 'my_services_cubit.dart';
import 'my_services_initial_params.dart';

class MyServicesPage extends StatefulWidget {
  final MyServicesCubit cubit;
  final MyServicesInitialParams initialParams;

  static const path = '/MyServicesPage';

  const MyServicesPage({
    Key? key,
    required this.cubit,
    required this.initialParams,
  }) : super(key: key);

  @override
  State<MyServicesPage> createState() => _MyServicesState();
}

class _MyServicesState extends State<MyServicesPage>
    with SingleTickerProviderStateMixin {
  MyServicesCubit get cubit => widget.cubit;

  late TabController tabController;

  // addDummyData() {
  //   FirebaseFirestore.instance
  //       .collection("users")
  //       .doc(FirebaseAuth.instance.currentUser?.uid)
  //       .collection("myServices")
  //       .withConverter<MyService>(
  //         fromFirestore: (snapshot, options) =>
  //             MyService.fromJson(snapshot.data() ?? {}),
  //         toFirestore: (value, options) => value.toJson(),
  //       )
  //       .doc().set(MyService(
  //           provider: Provider(
  //               email: "test@provder.com",
  //               avgRating: 3,
  //               onboardingInfo: ProviderOnboardingInfo(
  //                   generalService: GeneralService(eligibilityCriteria: [
  //                     "Within 5 Years of Incarceration"
  //                   ], features: [
  //                     "Local Hiring and Fair Minimum Wage"
  //                   ], serviceCategories: [
  //                     ProgramCategory(title: "Spirituality", subCategories: [
  //                       "Faith Based",
  //                       "General",
  //                       "Non-specific Spiritual Services"
  //                     ]),
  //                     ProgramCategory(title: "Community", subCategories: [
  //                       "Community Resource Centers",
  //                       "Social Networking",
  //                       "Support Groups"
  //                     ]),
  //                   ]),
  //                   programs: [
  //                     Program(
  //                         features: [
  //                           "Youth Programs Available",
  //                           "ACA Accreditation"
  //                         ],
  //                         eligibilityCriteria: [
  //                           "Elderly",
  //                           "Justice Impact Families in Alameda County"
  //                         ],
  //                         name: "Atomic Program",
  //                         description: "This is atomic proram",
  //                         programCategories: [
  //                           ProgramCategory(title: "Finance", subCategories: [
  //                             "Employment Benefits Counseling",
  //                             "Financial Literacy Programs"
  //                           ]),
  //                           ProgramCategory(title: "Health", subCategories: [
  //                             "General",
  //                             "Inpatient and Outpatient Rehabilitation"
  //                           ]),
  //                         ]),
  //                     Program(
  //                         features: [
  //                           "Youth Programs Available",
  //                           "ACA Accreditation"
  //                         ],
  //                         eligibilityCriteria: [
  //                           "Elderly",
  //                           "Justice Impact Families in Alameda County"
  //                         ],
  //                         name: "Atomic Program",
  //                         description: "This is atomic proram",
  //                         programCategories: [
  //                           ProgramCategory(title: "Finance", subCategories: [
  //                             "Employment Benefits Counseling",
  //                             "Financial Literacy Programs"
  //                           ]),
  //                           ProgramCategory(title: "Health", subCategories: [
  //                             "General",
  //                             "Inpatient and Outpatient Rehabilitation"
  //                           ]),
  //                         ]),
  //                   ],
  //                   providerDetails: ProviderDetailsInfo(
  //                       city: "Lahore",
  //                       contactPerson: "John doe",
  //                       country: "Pakistan",
  //                       images: const [
  //                         "https://firebasestorage.googleapis.com/v0/b/diginifi.appspot.com/o/uploads%2F1730213183478?alt=media&token=9cabe148-d74f-429f-8532-259f1ec671c0",
  //                         "https://firebasestorage.googleapis.com/v0/b/diginifi.appspot.com/o/uploads%2F1730213183499?alt=media&token=5f055004-1eb9-4a29-b7f6-3f448928ad73"
  //                       ],
  //                       officialEmail: "test@eemail.com",
  //                       officialFax: "1223343",
  //                       officialNumber: "+9212345678",
  //                       operatingHours: [
  //                         OperatingHour(
  //                             day: "SUN",
  //                             startTime: DateTime.now(),
  //                             endTime: DateTime.now()),
  //                         OperatingHour(
  //                             day: "MON",
  //                             startTime: DateTime.now(),
  //                             endTime: DateTime.now()),
  //                         OperatingHour(
  //                             day: "TUE",
  //                             startTime: DateTime.now(),
  //                             endTime: DateTime.now()),
  //                         OperatingHour(
  //                             day: "WED",
  //                             startTime: DateTime.now(),
  //                             endTime: DateTime.now())
  //                       ],
  //                       orgWebsite: "www.website.com",
  //                       providerLocationDescribe:
  //                           "This is nestedpie organizaiton",
  //                       providerNameLocation: "NestedPie",
  //                       relationReentry: "Reentry adjacent",
  //                       state: "Alaska",
  //                       street: "",
  //                       zipCode: "1234")),
  //                  createdAt: FieldValue.serverTimestamp().toString(),
  //                  updatedAt: FieldValue.serverTimestamp().toString(),
  //               ratingCount: RatingCount(i2: 1, i4: 1),
  //               totalReviews: 2,
  //               userId: "6LPJyTXlJmObVAaM0liJt73l5ay1"),
  //           serviceStatus: MyServicesStatus.ineligibleServices,
  //           statusUpdates: ["Reason for rejection","Do not meet eligibility criteria"]));
  // }

  @override
  void initState() {
    tabController =
        TabController(length: kMyServicesTabBarItems.length, vsync: this);
    cubit.navigator.context = context;
    cubit.onInit(widget.initialParams);
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
      widget.cubit
        ..getMyServices(FirebaseAuth.instance.currentUser!.uid),
      child: Builder(
          builder: (context) {
            return Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Responsive.isDesktop(context) ? 80 : 24),
              child: Scaffold(
                appBar: PreferredSize(
                    preferredSize:
                    Size.fromHeight(Responsive.isDesktop(context) ? 210 : 140),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Responsive.isDesktop(context)
                            ? 30.verticalSpace
                            : 14.verticalSpace,
                        Text(
                          "My Services",
                          style: context.textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.w500,
                              fontSize: Responsive.isDesktop(context)
                                  ? 30
                                  : 16),
                        ),
                        Responsive.isDesktop(context)
                            ? 30.verticalSpace
                            : 12.verticalSpace,
                        Responsive.isDesktop(context)
                            ? DesktopTabBar(
                          tabController: tabController,
                        )
                            : TabBar(

                          onTap: (index) {
                            context.read<MyServicesCubit>().updateServices(
                                kMyServicesTabBarItems[index]);
                          },
                          controller: tabController,
                          indicator: null,
                          isScrollable: Responsive.isMobile(context),
                          labelColor: context.colorScheme.primary,
                          labelStyle: context.textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                          unselectedLabelColor: context.colorScheme.onSurface,
                          indicatorColor: Colors.transparent,
                          unselectedLabelStyle:
                          context.textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                          tabs: kMyServicesTabBarItems
                              .map((title) =>
                              Tab(

                                text: title,
                              ))
                              .toList(),
                        ),
                        Responsive.isMobile(context) || Responsive.isTablet(context)
                            ? Column(
                          children: [
                            Divider(
                              height: 20,
                              thickness: 1.5,
                              color: context.colorScheme.tertiaryContainer,
                              indent: 0,
                            ),
                            20.verticalSpace,
                          ],
                        )
                            : 40.verticalSpace,
                      ],
                    )),
                body: BlocBuilder<MyServicesCubit, MyServicesState>(
                  builder: (context, state) {
                    if (state.loading) {
                      return const Center(child: CircularProgressIndicator());
                    } else {
                      return TabBarView(

                        physics: Responsive.isDesktop(context)
                            ? const NeverScrollableScrollPhysics()
                            : const BouncingScrollPhysics(),
                        controller: tabController,
                        children: List.generate(
                          kMyServicesTabBarItems.length,
                              (index) {
                            return CustomSingleChildScrollView(
                              child: CustomResponsiveBuilder(
                                builder: (context, constraints, deviseSize) {
                                  return Center(
                                    child: Wrap(spacing: 20,runSpacing: 20,children: List.generate(
                                      state.myServices.length, (index) {
                                      return BlocProvider(
                                        create: (context) => MyServicesTileCubit(state.myServices[index]),
                                        child: ServicesTile(
                                          onTap: (p0) {},
                                          myService: state.myServices[index],
                                        ),
                                      );
                                    },),),
                                  );
                                },
                              ),
                            );
                          },
                        ),
                      );
                    }
                  },
                ),
              ),
            );
          }
      ),
    );
  }
}
//
// AlignedGridView.count(
// padding: EdgeInsets.zero,
// crossAxisCount: Responsive.getResponsiveValue(
// context, 1, 2, 4,
// largeTablet: 3),
// mainAxisSpacing: 13,
// crossAxisSpacing: 13,
// shrinkWrap: true,
// primary: false,
// itemCount: state.myServices.length,
// itemBuilder: (context, index) {
// // Provider provider =state.loading?
// // Provider.shimmer():
// //  state.services[index];
// return BlocProvider(
// create: (context) => MyServicesTileCubit(state.myServices[index]),
// child: ServicesTile(
// onTap: (p0) {},
// myService: state.myServices[index],
// ),
// );
// },
//)