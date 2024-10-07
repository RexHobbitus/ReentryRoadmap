class PersonalInfo {
  String? fullName;
  String? dateOfBirth;
  String? ethnicity;
  String? gender;
  String? veteranStatus;

  PersonalInfo(
      {this.fullName,
        this.dateOfBirth,
        this.ethnicity,
        this.gender,
        this.veteranStatus});

  PersonalInfo.fromJson(Map<String, dynamic> json) {
    fullName = json['fullName'];
    dateOfBirth = json['dateOfBirth'];
    ethnicity = json['ethnicity'];
    gender = json['gender'];
    veteranStatus = json['veteranStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fullName'] = this.fullName;
    data['dateOfBirth'] = this.dateOfBirth;
    data['ethnicity'] = this.ethnicity;
    data['gender'] = this.gender;
    data['veteranStatus'] = this.veteranStatus;
    return data;
  }
}