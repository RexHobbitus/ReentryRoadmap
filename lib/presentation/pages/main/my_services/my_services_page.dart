import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reentry_roadmap/core/enums/my_services_status.dart';
import 'package:reentry_roadmap/core/extensions/double_extension.dart';
import 'package:reentry_roadmap/core/extensions/theme_extension.dart';
import 'package:reentry_roadmap/core/utils/constants.dart';
import 'package:reentry_roadmap/core/utils/resposive.dart';
import 'package:reentry_roadmap/data/models/general_service_json.dart';
import 'package:reentry_roadmap/data/models/my_service_json.dart';
import 'package:reentry_roadmap/data/models/operating_hour_json.dart';
import 'package:reentry_roadmap/data/models/program_category_json.dart';
import 'package:reentry_roadmap/data/models/program_json.dart';
import 'package:reentry_roadmap/data/models/provider_details_info_json.dart';
import 'package:reentry_roadmap/data/models/provider_json.dart';
import 'package:reentry_roadmap/data/models/provider_onboarding_info_json.dart';
import 'package:reentry_roadmap/data/models/rating_count_json.dart';
import 'package:reentry_roadmap/presentation/pages/main/my_services/my_services_state.dart';
import 'package:reentry_roadmap/presentation/pages/main/my_services/tab_bar_views/active_services.dart';
import 'package:reentry_roadmap/presentation/pages/main/my_services/tab_bar_views/completed_services.dart';
import 'package:reentry_roadmap/presentation/pages/main/my_services/tab_bar_views/contacted_services.dart';
import 'package:reentry_roadmap/presentation/pages/main/my_services/tab_bar_views/ineligible_services.dart';
import 'package:reentry_roadmap/presentation/pages/main/my_services/tab_bar_views/saved_services.dart';
import 'package:reentry_roadmap/presentation/pages/main/my_services/widgets/desktop_tab_bar.dart';

import 'my_services_cubit.dart';
import 'my_services_initial_params.dart';

class MyServicesPage extends StatefulWidget {
  final MyServicesCubit cubit;
  final MyServicesInitialParams initialParams;

  static const path = '/MyServicesPage';

  const MyServicesPage({
    super.key,
    required this.cubit,
    required this.initialParams,
  });

  @override
  State<MyServicesPage> createState() => _MyServicesState();
}

class _MyServicesState extends State<MyServicesPage>
    with SingleTickerProviderStateMixin {
  MyServicesCubit get cubit => widget.cubit;

  late TabController tabController;

  addDummyData() async {
    final docRef = FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection("myServices")
        .withConverter<MyServiceJson>(
          fromFirestore: (snapshot, options) =>
              MyServiceJson.fromJson(snapshot.data() ?? {}),
          toFirestore: (value, options) => value.toJson(),
        )
        .doc();

    await docRef.set(MyServiceJson(
        serviceId: docRef.id,
        provider: ProviderJson(
            email: "test@provder.com",
            avgRating: 2.5,
            onboardingInfo: ProviderOnboardingInfoJson(
                generalService: GeneralServiceJson(eligibilityCriteria: [
                  "Within 5 Years of Incarceration"
                ], features: [
                  "Local Hiring and Fair Minimum Wage"
                ], serviceCategories: [
                  ProgramCategoryJson(title: "Spirituality", subCategories: [
                    "Faith Based",
                    "General",
                    "Non-specific Spiritual Services"
                  ]),
                  ProgramCategoryJson(title: "Community", subCategories: [
                    "Community Resource Centers",
                    "Social Networking",
                    "Support Groups"
                  ]),
                ]),
                programs: [
                  ProgramJson(
                      features: [
                        "Youth Programs Available",
                        "ACA Accreditation"
                      ],
                      eligibilityCriteria: [
                        "Elderly",
                        "Justice Impact Families in Alameda County"
                      ],
                      name: "Atomic Program",
                      description: "This is atomic proram",
                      programCategories: [
                        ProgramCategoryJson(title: "Finance", subCategories: [
                          "Employment Benefits Counseling",
                          "Financial Literacy Programs"
                        ]),
                        ProgramCategoryJson(title: "Health", subCategories: [
                          "General",
                          "Inpatient and Outpatient Rehabilitation"
                        ]),
                      ]),
                  ProgramJson(
                      features: [
                        "Youth Programs Available",
                        "ACA Accreditation"
                      ],
                      eligibilityCriteria: [
                        "Elderly",
                        "Justice Impact Families in Alameda County"
                      ],
                      name: "Atomic Program",
                      description: "This is atomic proram",
                      programCategories: [
                        ProgramCategoryJson(title: "Finance", subCategories: [
                          "Employment Benefits Counseling",
                          "Financial Literacy Programs"
                        ]),
                        ProgramCategoryJson(title: "Health", subCategories: [
                          "General",
                          "Inpatient and Outpatient Rehabilitation"
                        ]),
                      ]),
                ],
                providerDetails: ProviderDetailsInfoJson(
                    city: "Lahore",
                    contactPerson: "John doe",
                    country: "Pakistan",
                    images: const [
                      "https://firebasestorage.googleapis.com/v0/b/diginifi.appspot.com/o/uploads%2F1730213183478?alt=media&token=9cabe148-d74f-429f-8532-259f1ec671c0",
                      "https://firebasestorage.googleapis.com/v0/b/diginifi.appspot.com/o/uploads%2F1730213183499?alt=media&token=5f055004-1eb9-4a29-b7f6-3f448928ad73"
                    ],
                    officialEmail: "test@eemail.com",
                    officialFax: "1223343",
                    officialNumber: "+9212345678",
                    operatingHours: [
                      OperatingHourJson(
                          day: "SUN",
                          startTime: Timestamp.now(),
                          endTime: Timestamp.now()),
                      OperatingHourJson(
                          day: "MON",
                          startTime: Timestamp.now(),
                          endTime: Timestamp.now()),
                      OperatingHourJson(
                          day: "TUE",
                          startTime: Timestamp.now(),
                          endTime: Timestamp.now()),
                      OperatingHourJson(
                          day: "WED",
                          startTime: Timestamp.now(),
                          endTime: Timestamp.now())
                    ],
                    orgWebsite: "www.website.com",
                    providerLocationDescribe: "This is nestedpie organizaiton",
                    providerNameLocation: "NestedPie",
                    relationReentry: "Reentry adjacent",
                    state: "Alaska",
                    street: "",
                    zipCode: "1234")),
            createdAt: Timestamp.now(),
            updatedAt: Timestamp.now(),
            ratingCount: RatingCountJson(i2: 1, i4: 1),
            totalReviews: 2,
            userId: "6LPJyTXlJmObVAaM0liJt73l5ay1"),
        serviceStatus: MyServicesStatus.activeServices,
        statusUpdates: [
          "Sep 26 2024 - Mar 26 2025",
          "Service used for 6 months",
        ]));
  }

  @override
  void initState() {
    //addDummyData();
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
          widget.cubit..getMyServices(FirebaseAuth.instance.currentUser!.uid),
      child: Builder(builder: (context) {
        return Padding(
          padding: EdgeInsets.symmetric(
              horizontal: Responsive.isDesktop(context) ? 80 : 24,vertical: 10),
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
                          fontSize: Responsive.isDesktop(context) ? 30 : 16),
                    ),
                    Responsive.isDesktop(context)
                        ? 30.verticalSpace
                        : 12.verticalSpace,
                    Responsive.isDesktop(context)
                        ? DesktopTabBar(
                            onTap: (index) {
                              context.read<MyServicesCubit>().updateServices(
                                  kMyServicesTabBarItems[index]);
                            },
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
                                .map((title) => Tab(
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
                      children: const [
                        SavedServices(),
                        ContactedServices(),
                        ActiveServices(),
                        CompletedServices(),
                        InEligibleServices()
                      ]);
                }
              },
            ),
          ),
        );
      }),
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
