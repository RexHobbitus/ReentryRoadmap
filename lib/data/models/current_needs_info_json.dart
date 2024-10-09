import 'package:reentry_roadmap/domain/entities/current_needs_info.dart';

class CurrentNeedsInfoJson {
  List<String>? currentTopPriorities;
  String? preferredServiceProviderSize;
  String? currentHousingStatus;
  String? highestLevelOfEducation;
  List<String>? tradeCertifications;
  List<String>? skillsToImproveOn;
  String? currentEmploymentStatus;
  String? currentCareerTrack;
  String? currentSalaryLevel;
  List<String>? aspiringCareerTrack;
  String? aspiringSalaryLevel;
  String? otherResourcesWanted;

  CurrentNeedsInfoJson({
    this.currentTopPriorities,
    this.preferredServiceProviderSize,
    this.currentHousingStatus,
    this.highestLevelOfEducation,
    this.tradeCertifications,
    this.skillsToImproveOn,
    this.currentEmploymentStatus,
    this.currentCareerTrack,
    this.currentSalaryLevel,
    this.aspiringCareerTrack,
    this.aspiringSalaryLevel,
    this.otherResourcesWanted,
  });

  // From JSON
  factory CurrentNeedsInfoJson.fromJson(Map<String, dynamic> json) {
    return CurrentNeedsInfoJson(
      currentTopPriorities: List<String>.from(json['currentTopPriorities'] ?? []),
      preferredServiceProviderSize: json['preferredServiceProviderSize'],
      currentHousingStatus: json['currentHousingStatus'],
      highestLevelOfEducation: json['highestLevelOfEducation'],
      tradeCertifications: List<String>.from(json['tradeCertifications'] ?? []),
      skillsToImproveOn: List<String>.from(json['skillsToImproveOn'] ?? []),
      currentEmploymentStatus: json['currentEmploymentStatus'],
      currentCareerTrack: json['currentCareerTrack'],
      currentSalaryLevel: json['currentSalaryLevel'],
      aspiringCareerTrack: List<String>.from(json['aspiringCareerTrack'] ?? []),
      aspiringSalaryLevel: json['aspiringSalaryLevel'],
      otherResourcesWanted: json['otherResourcesWanted'],
    );
  }

  // To JSON
  Map<String, dynamic> toJson() {
    return {
      'currentTopPriorities': currentTopPriorities,
      'preferredServiceProviderSize': preferredServiceProviderSize,
      'currentHousingStatus': currentHousingStatus,
      'highestLevelOfEducation': highestLevelOfEducation,
      'tradeCertifications': tradeCertifications,
      'skillsToImproveOn': skillsToImproveOn,
      'currentEmploymentStatus': currentEmploymentStatus,
      'currentCareerTrack': currentCareerTrack,
      'currentSalaryLevel': currentSalaryLevel,
      'aspiringCareerTrack': aspiringCareerTrack,
      'aspiringSalaryLevel': aspiringSalaryLevel,
      'otherResourcesWanted': otherResourcesWanted,
    };
  }

  // CopyWith method for mutability
  CurrentNeedsInfoJson copyWith({
    List<String>? currentTopPriorities,
    String? preferredServiceProviderSize,
    String? currentHousingStatus,
    String? highestLevelOfEducation,
    List<String>? tradeCertifications,
    List<String>? skillsToImproveOn,
    String? currentEmploymentStatus,
    String? currentCareerTrack,
    String? currentSalaryLevel,
    List<String>? aspiringCareerTrack,
    String? aspiringSalaryLevel,
    String? otherResourcesWanted,
  }) {
    return CurrentNeedsInfoJson(
      currentTopPriorities: currentTopPriorities ?? this.currentTopPriorities,
      preferredServiceProviderSize: preferredServiceProviderSize ?? this.preferredServiceProviderSize,
      currentHousingStatus: currentHousingStatus ?? this.currentHousingStatus,
      highestLevelOfEducation: highestLevelOfEducation ?? this.highestLevelOfEducation,
      tradeCertifications: tradeCertifications ?? this.tradeCertifications,
      skillsToImproveOn: skillsToImproveOn ?? this.skillsToImproveOn,
      currentEmploymentStatus: currentEmploymentStatus ?? this.currentEmploymentStatus,
      currentCareerTrack: currentCareerTrack ?? this.currentCareerTrack,
      currentSalaryLevel: currentSalaryLevel ?? this.currentSalaryLevel,
      aspiringCareerTrack: aspiringCareerTrack ?? this.aspiringCareerTrack,
      aspiringSalaryLevel: aspiringSalaryLevel ?? this.aspiringSalaryLevel,
      otherResourcesWanted: otherResourcesWanted ?? this.otherResourcesWanted,
    );
  }

  CurrentNeedsInfo toDomain() {
    return CurrentNeedsInfo(
      currentTopPriorities: currentTopPriorities,
      preferredServiceProviderSize: preferredServiceProviderSize,
      currentHousingStatus: currentHousingStatus,
      highestLevelOfEducation: highestLevelOfEducation,
      tradeCertifications: tradeCertifications,
      skillsToImproveOn: skillsToImproveOn,
      currentEmploymentStatus: currentEmploymentStatus,
      currentCareerTrack: currentCareerTrack,
      currentSalaryLevel: currentSalaryLevel,
      aspiringCareerTrack: aspiringCareerTrack,
      aspiringSalaryLevel: aspiringSalaryLevel,
      otherResourcesWanted: otherResourcesWanted,
    );
  }
}
