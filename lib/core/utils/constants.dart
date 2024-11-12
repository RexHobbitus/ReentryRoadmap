import 'package:reentry_roadmap/domain/entities/operating_hour.dart';

import '../../domain/entities/service_category.dart';
import 'assets.dart';

const String kAppName = "Dignifi Reentry";
const double kScreenHorizontalPadding = 20;
const kPlaceHolderImage =
    "https://developers.elementor.com/docs/assets/img/elementor-placeholder-image.png";
const double kMenuBreakPoint = 650;
const String kPendingStatus = "Pending";

final kOperatingHours = [
  OperatingHour(day: "Sun"),
  OperatingHour(day: "Mon"),
  OperatingHour(day: "Tue"),
  OperatingHour(day: "Wed"),
  OperatingHour(day: "Thu"),
  OperatingHour(day: "Fri"),
  OperatingHour(day: "Sat"),
];

var kPersonalizedServiceCategory=ServiceCategory(
  icon: Assets.personalizedServices,
  title: "Personalized Services",
  subCategories: []
);

final List<ServiceCategory> kServiceCategories = [
  ServiceCategory(
    icon: Assets.education,
    title: "Education",
    subCategories: kEducationSubCategories,
  ),
  ServiceCategory(
    icon: Assets.employment,
    title: "Employment",
    subCategories: kEmploymentSubCategories,
  ),
  ServiceCategory(
    icon: Assets.housing,
    title: "Housing",
    subCategories: kHousingSubCategories,
  ),
  ServiceCategory(
    icon: Assets.lifeSkills,
    title: "Life Skills",
    subCategories: kLifeSkillsSubCategories,
  ),
  ServiceCategory(
    icon: Assets.finance,
    title: "Finance",
    subCategories: kFinancialSubCategories,
  ),
  ServiceCategory(
    icon: Assets.legal,
    title: "Legal",
    subCategories: kLegalSubCategories,
  ),
  ServiceCategory(
    icon: Assets.transportation,
    title: "Transportation",
    subCategories: kTransportationSubCategories,
  ),
  ServiceCategory(
    icon: Assets.community,
    title: "Community",
    subCategories: kCommunitySubCategories,
  ),
  ServiceCategory(
    icon: Assets.health,
    title: "Health",
    subCategories: kHealthSubCategories,
  ),
  ServiceCategory(
    icon: Assets.friendsAndFamily,
    title: "Friends & Family",
    subCategories: kFirstStepsSubCategories,
  ),
  ServiceCategory(
    icon: Assets.spirituality,
    title: "Spirituality",
    subCategories: kSpiritualitySubCategories,
  ),
  ServiceCategory(
    icon: Assets.mentalHealth,
    title: "Mental Health",
    subCategories: kMentalHealthSubCategories,
  ),
  ServiceCategory(
    icon: Assets.firstSteps,
    title: "First Steps",
    subCategories: kFirstStepsSubCategories,
  ),
];

List<String> kUSStates = [
  'Alabama',
  'Alaska',
  'Arizona',
  'Arkansas',
  'California',
  'Colorado',
  'Connecticut',
  'Delaware',
  'Florida',
  'Georgia',
  'Hawaii',
  'Idaho',
  'Illinois',
  'Indiana',
  'Iowa',
  'Kansas',
  'Kentucky',
  'Louisiana',
  'Maine',
  'Maryland',
  'Massachusetts',
  'Michigan',
  'Minnesota',
  'Mississippi',
  'Missouri',
  'Montana',
  'Nebraska',
  'Nevada',
  'New Hampshire',
  'New Jersey',
  'New Mexico',
  'New York',
  'North Carolina',
  'North Dakota',
  'Ohio',
  'Oklahoma',
  'Oregon',
  'Pennsylvania',
  'Rhode Island',
  'South Carolina',
  'South Dakota',
  'Tennessee',
  'Texas',
  'Utah',
  'Vermont',
  'Virginia',
  'Washington',
  'West Virginia',
  'Wisconsin',
  'Wyoming'
];

// Sub-categories for each category
const List<String> kCommunitySubCategories = [
  'Mentorship Programs',
  'Community Resource Centers',
  'Social Networking',
  'Support Groups',
  'Survivor Engagement',
];

const List<String> kEducationSubCategories = [
  'Adult Education',
  'Vocational Training',
  'Higher Education',
  'GED Courses',
  'General',
];

const List<String> kEmploymentSubCategories = [
  'Job Placement Services',
  'Career Counseling',
  'Apprenticeships and Internships',
  'Resume Building',
  'Soft Skills',
  'General',
  'Second Chance Employer',
  'Entrepreneurship',
];

const List<String> kFinancialSubCategories = [
  'Emergency Financial Aid',
  'Financial Literacy Programs',
  'Employment Benefits Counseling',
];

const List<String> kFriendsAndFamiliesSubCategories = [
  'Family Reunification',
  'Process Support',
];

const List<String> kHealthSubCategories = [
  'Substance Abuse Treatment',
  'Inpatient and Outpatient Rehabilitation',
  'General',
];

const List<String> kHousingSubCategories = [
  'Transitional Housing',
  'Long Term Supportive Housing',
  'Reentrant Friendly Housing',
  'Emergency Shelter',
  'Incarceration Diversion',
  'Referrals',
  'Rental Assistance',
];

const List<String> kLegalSubCategories = [
  'Record Expungement Services',
  'Parole and Probation Support',
  'Legal Advocacy',
  'General',
];

const List<String> kLifeSkillsSubCategories = [
  'Daily Living Skills',
  'Computer Classes',
  'Parenting Classes',
  'Anger Management and Conflict Resolution',
  'Case Management',
  'Barrier Removal',
  'Mindset Change',
];

const List<String> kMentalHealthSubCategories = [
  'Counseling and Therapy',
  'Crisis Intervention',
  'Violence Prevention',
  'Medication Management',
];

const List<String> kSpiritualitySubCategories = [
  'Religious Services',
  'Non-specific Spiritual Services',
  'General',
  'Faith Based',
];

const List<String> kTransportationSubCategories = [
  'General',
  'Public Transit Passes',
  'Ride-Sharing Programs',
  'Driver’s License Reinstatement',
];

const List<String> kFirstStepsSubCategories = [
  'Benefits Acquisition',
];

// Features (examples)
const List<String> kProgramFeatures = [
  'Local Hiring and Fair Minimum Wage',
  'Formerly Incarcerated Leadership',
  'Holistic Wraparound Services',
  'Youth Programs Available',
  'Voluntary',
  'In Custody Interview',
  'Award Winning',
  'Sober Living',
  'Afrocentric',
  'Partnered with SF Probation',
  'Faith Based',
  'Veteran Focused',
  'Food Provided',
  'ACA Accreditation',
  'Children Accepted',
  'In Custody Programs',
  'Restorative Approach',
  '6 Month Program',
  'All in One',
];

// Eligibility Criteria (examples)
const List<String> kEligibilityCriteria = [
  'Within 5 Years of Incarceration',
  'Within 1 Year of Incarceration',
  'Must be Homeless',
  'Women Only',
  'Adults',
  'Completed a Recovery Program',
  '30 Days Clean and Sober',
  'No Sexual Criminal Convictions',
  'No Registered Sex Offenders',
  'Elderly',
  'Referral Required: Alameda County Probation',
  'Justice Impact People in Alameda County',
  'Justice Impact Families in Alameda County',
  'Within 6 Months of Release to Alameda County',
];
