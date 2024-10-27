import '../../domain/entities/check_in.dart';
import 'current_needs_info_json.dart';

class CheckInJson {
  CurrentNeedsInfoJson? currentNeedsInfo;
  List<String>? legalChallenges;
  String? otherLegalChallenge;
  String? howMuchHappyCurrently;
  String? experienceWithDignifi;

  CheckInJson({
    this.currentNeedsInfo,
    this.legalChallenges,
    this.otherLegalChallenge,
    this.howMuchHappyCurrently,
    this.experienceWithDignifi,
  });

  CheckInJson.fromJson(Map<String, dynamic> json) {
    currentNeedsInfo = json['currentNeedsInfo'] != null
        ? CurrentNeedsInfoJson.fromJson(json['currentNeedsInfo'])
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

  CheckIn toDomain() {
    return CheckIn(
      currentNeedsInfo: currentNeedsInfo?.toDomain(),
      legalChallenges: legalChallenges,
      otherLegalChallenge: otherLegalChallenge,
      howMuchHappyCurrently: howMuchHappyCurrently,
      experienceWithDignifi: experienceWithDignifi,
    );
  }
}
