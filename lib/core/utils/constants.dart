import 'package:reentry_roadmap/core/utils/assets.dart';
import 'package:reentry_roadmap/domain/entities/service_category.dart';

const String kAppName = "Dignifi Reentry";
const double kScreenHorizontalPadding = 20;
const kPlaceHolderImage =
    "https://developers.elementor.com/docs/assets/img/elementor-placeholder-image.png";
const double kMenuBreakPoint = 650;

final List<ServiceCategory> kServiceCategories = [
  ServiceCategory(icon: Assets.education, title: "Education"),
  ServiceCategory(icon: Assets.employment, title: "Employment"),
  ServiceCategory(icon: Assets.housing, title: "Housing"),
  ServiceCategory(icon: Assets.lifeSkills, title: "Life Skills"),
  ServiceCategory(icon: Assets.finance, title: "Finance"),
  ServiceCategory(icon: Assets.legal, title: "Legal"),
  ServiceCategory(icon: Assets.transportation, title: "Transportation"),
  ServiceCategory(icon: Assets.community, title: "Community"),
  ServiceCategory(icon: Assets.health, title: "Health"),
  ServiceCategory(icon: Assets.friendsAndFamily, title: "Friends & Family"),
  ServiceCategory(icon: Assets.spirituality, title: "Spirituality"),
  ServiceCategory(icon: Assets.mentalHealth, title: "Mental Health"),
  ServiceCategory(icon: Assets.firstSteps, title: "First Steps"),
  ServiceCategory(
      icon: Assets.personalizedServices, title: "Personalized Services"),
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

const List<String> transportationSubCategories = [
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
