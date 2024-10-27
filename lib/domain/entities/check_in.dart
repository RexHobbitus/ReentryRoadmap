import 'current_needs_info.dart';

class CheckIn {
  CurrentNeedsInfo? currentNeedsInfo;
  List<String>? legalChallenges;
  String? otherLegalChallenge;
  String? howMuchHappyCurrently;
  String? experienceWithDignifi;

  CheckIn({
    this.currentNeedsInfo,
    this.legalChallenges,
    this.otherLegalChallenge,
    this.howMuchHappyCurrently,
    this.experienceWithDignifi,
  });

  CheckIn.fromJson(Map<String, dynamic> json) {
    currentNeedsInfo = json['currentNeedsInfo'] != null
        ? CurrentNeedsInfo.fromJson(json['currentNeedsInfo'])
        : null;
    legalChallenges = json['legalChallenges']?.cast<String>() ?? [];
    otherLegalChallenge = json['otherLegalChallenge'];
    howMuchHappyCurrently = json['howMuchHappyCurrently'];
    experienceWithDignifi = json['experienceWithDignifi'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (this.currentNeedsInfo != null) {
      data['currentNeedsInfo'] = this.currentNeedsInfo!.toJson();
    }
    legalChallenges = legalChallenges;
    otherLegalChallenge = otherLegalChallenge;
    howMuchHappyCurrently = howMuchHappyCurrently;
    experienceWithDignifi = experienceWithDignifi;

    return data;
  }

  // CopyWith method
  CheckIn copyWith({
    CurrentNeedsInfo? currentNeedsInfo,
    List<String>? legalChallenges,
    String? otherLegalChallenge,
    String? howMuchHappyCurrently,
    String? experienceWithDignifi,
  }) {
    return CheckIn(
      currentNeedsInfo: currentNeedsInfo ?? this.currentNeedsInfo,
      legalChallenges: legalChallenges ?? this.legalChallenges,
      otherLegalChallenge: otherLegalChallenge ?? this.otherLegalChallenge,
      howMuchHappyCurrently:
          howMuchHappyCurrently ?? this.howMuchHappyCurrently,
      experienceWithDignifi:
          experienceWithDignifi ?? this.experienceWithDignifi,
    );
  }
}
