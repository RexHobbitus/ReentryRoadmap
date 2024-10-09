
import '../../domain/entities/current_needs_info.dart';

class CurrentNeedsInfoJson  {
  List<String>? currentTopPriorities;
  String? preferredServiceProviderSize;
  String? currentHousingStatus;
  String? needOfImmediateHousing;
  String? highestLevelOfEducation;
  List<String>? tradeCertifications;
  List<String>? skillsToImproveOn;
  String? currentEmploymentStatus;
  String? currentCareerStatus;
  String? currentSalaryStatus;
  String? lookingForCareerChange;
  List<String>? aspiringCareerTrack;
  String? aspiringSalaryLevel;
  String? otherResourceWanted;

  CurrentNeedsInfoJson({
    this.currentTopPriorities,
    this.preferredServiceProviderSize,
    this.currentHousingStatus,
    this.needOfImmediateHousing,
    this.highestLevelOfEducation,
    this.tradeCertifications,
    this.skillsToImproveOn,
    this.currentEmploymentStatus,
    this.currentCareerStatus,
    this.currentSalaryStatus,
    this.lookingForCareerChange,
    this.aspiringCareerTrack,
    this.aspiringSalaryLevel,
    this.otherResourceWanted,
  });

  CurrentNeedsInfoJson.fromJson(Map<String, dynamic> json) {
    currentTopPriorities = json['currentTopPriorities']?.cast<String>() ?? [];
    preferredServiceProviderSize = json['preferredServiceProviderSize'];
    currentHousingStatus = json['currentHousingStatus'];
    needOfImmediateHousing = json['needOfImmediateHousing'];
    highestLevelOfEducation = json['highestLevelOfEducation'];
    tradeCertifications = json['tradeCertifications']?.cast<String>()?? [];
    skillsToImproveOn = json['skillsToImproveOn']?.cast<String>()?? [];
    currentEmploymentStatus = json['currentEmploymentStatus'];
    currentCareerStatus = json['currentCareerStatus'];
    currentSalaryStatus = json['currentSalaryStatus'];
    lookingForCareerChange = json['lookingForCareerChange'];
    aspiringCareerTrack = json['aspiringCareerTrack']?.cast<String>()?? [];
    aspiringSalaryLevel = json['aspiringSalaryLevel'];
    otherResourceWanted = json['otherResourceWanted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['currentTopPriorities'] = this.currentTopPriorities;
    data['preferredServiceProviderSize'] = this.preferredServiceProviderSize;
    data['currentHousingStatus'] = this.currentHousingStatus;
    data['needOfImmediateHousing'] = this.needOfImmediateHousing;
    data['highestLevelOfEducation'] = this.highestLevelOfEducation;
    data['tradeCertifications'] = this.tradeCertifications;
    data['skillsToImproveOn'] = this.skillsToImproveOn;
    data['currentEmploymentStatus'] = this.currentEmploymentStatus;
    data['currentCareerStatus'] = this.currentCareerStatus;
    data['currentSalaryStatus'] = this.currentSalaryStatus;
    data['lookingForCareerChange'] = this.lookingForCareerChange;
    data['aspiringCareerTrack'] = this.aspiringCareerTrack;
    data['aspiringSalaryLevel'] = this.aspiringSalaryLevel;
    data['otherResourceWanted'] = this.otherResourceWanted;
    return data;
  }

  CurrentNeedsInfo toDomain() {
    return CurrentNeedsInfo(
      currentTopPriorities: currentTopPriorities ?? [],
      preferredServiceProviderSize: preferredServiceProviderSize ?? '',
      currentHousingStatus: currentHousingStatus ?? '',
      needOfImmediateHousing: needOfImmediateHousing ?? '',
      highestLevelOfEducation: highestLevelOfEducation ?? '',
      tradeCertifications: tradeCertifications ?? [],
      skillsToImproveOn: skillsToImproveOn ?? [],
      currentEmploymentStatus: currentEmploymentStatus ?? '',
      currentCareerStatus: currentCareerStatus ?? '',
      currentSalaryStatus: currentSalaryStatus ?? '',
      lookingForCareerChange: lookingForCareerChange ?? '',
      aspiringCareerTrack: aspiringCareerTrack ?? [],
      aspiringSalaryLevel: aspiringSalaryLevel ?? '',
      otherResourceWanted: otherResourceWanted ?? '',
    );
  }

  CurrentNeedsInfoJson copyWith({
    List<String>? currentTopPriorities,
    String? preferredServiceProviderSize,
    String? currentHousingStatus,
    String? needOfImmediateHousing,
    String? highestLevelOfEducation,
    List<String>? tradeCertifications,
    List<String>? skillsToImproveOn,
    String? currentEmploymentStatus,
    String? currentCareerStatus,
    String? currentSalaryStatus,
    String? lookingForCareerChange,
    List<String>? aspiringCareerTrack,
    String? aspiringSalaryLevel,
    String? otherResourceWanted,
  }) {
    return CurrentNeedsInfoJson(
      currentTopPriorities: currentTopPriorities ?? this.currentTopPriorities,
      preferredServiceProviderSize: preferredServiceProviderSize ?? this.preferredServiceProviderSize,
      currentHousingStatus: currentHousingStatus ?? this.currentHousingStatus,
      needOfImmediateHousing: needOfImmediateHousing ?? this.needOfImmediateHousing,
      highestLevelOfEducation: highestLevelOfEducation ?? this.highestLevelOfEducation,
      tradeCertifications: tradeCertifications ?? this.tradeCertifications,
      skillsToImproveOn: skillsToImproveOn ?? this.skillsToImproveOn,
      currentEmploymentStatus: currentEmploymentStatus ?? this.currentEmploymentStatus,
      currentCareerStatus: currentCareerStatus ?? this.currentCareerStatus,
      currentSalaryStatus: currentSalaryStatus ?? this.currentSalaryStatus,
      lookingForCareerChange: lookingForCareerChange ?? this.lookingForCareerChange,
      aspiringCareerTrack: aspiringCareerTrack ?? this.aspiringCareerTrack,
      aspiringSalaryLevel: aspiringSalaryLevel ?? this.aspiringSalaryLevel,
      otherResourceWanted: otherResourceWanted ?? this.otherResourceWanted,
    );
  }

}