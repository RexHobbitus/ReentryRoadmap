import 'package:equatable/equatable.dart';

class CurrentNeedsInfo extends Equatable {
  final List<String>? currentTopPriorities;
  final String? preferredServiceProviderSize;
  final String? currentHousingStatus;
  final String? highestLevelOfEducation;
  final List<String>? tradeCertifications;
  final List<String>? skillsToImproveOn;
  final String? currentEmploymentStatus;
  final String? currentCareerTrack;
  final String? currentSalaryLevel;
  final List<String>? aspiringCareerTrack;
  final String? aspiringSalaryLevel;
  final String? otherResourcesWanted;

  CurrentNeedsInfo({
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

  // CopyWith method for immutability
  CurrentNeedsInfo copyWith({
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
    return CurrentNeedsInfo(
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

  // Factory constructor for creating an instance from JSON
  factory CurrentNeedsInfo.fromJson(Map<String, dynamic> json) {
    return CurrentNeedsInfo(
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

  // Method for converting an instance to JSON
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

  @override
  List<Object?> get props => [
        currentTopPriorities,
        preferredServiceProviderSize,
        currentHousingStatus,
        highestLevelOfEducation,
        tradeCertifications,
        skillsToImproveOn,
        currentEmploymentStatus,
        currentCareerTrack,
        currentSalaryLevel,
        aspiringCareerTrack,
        aspiringSalaryLevel,
        otherResourcesWanted,
      ];
}
