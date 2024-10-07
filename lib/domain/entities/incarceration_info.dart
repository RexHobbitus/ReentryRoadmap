class IncarcerationInfo {
  String? idNumber;
  String? numberOfTimesIncarcerated;
  String? incarceratedHistory;
  String? latestOffenceType;
  String? lengthOfLongestIncarceration;
  String? lengthOfLatestIncarceration;
  String? firstIncarcerationDate;
  String? latestReleaseDate;
  String? mostRecentTermServerIn;
  List<String>? programAttendedWhileIncarcerated;

  IncarcerationInfo(
      {this.idNumber,
        this.numberOfTimesIncarcerated,
        this.incarceratedHistory,
        this.latestOffenceType,
        this.lengthOfLongestIncarceration,
        this.lengthOfLatestIncarceration,
        this.firstIncarcerationDate,
        this.latestReleaseDate,
        this.mostRecentTermServerIn,
        this.programAttendedWhileIncarcerated});

  IncarcerationInfo.fromJson(Map<String, dynamic> json) {
    idNumber = json['idNumber'];
    numberOfTimesIncarcerated = json['numberOfTimesIncarcerated'];
    incarceratedHistory = json['incarceratedHistory'];
    latestOffenceType = json['latestOffenceType'];
    lengthOfLongestIncarceration = json['lengthOfLongestIncarceration'];
    lengthOfLatestIncarceration = json['lengthOfLatestIncarceration'];
    firstIncarcerationDate = json['firstIncarcerationDate'];
    latestReleaseDate = json['latestReleaseDate'];
    mostRecentTermServerIn = json['mostRecentTermServerIn'];
    programAttendedWhileIncarcerated =
        json['programAttendedWhileIncarcerated'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idNumber'] = this.idNumber;
    data['numberOfTimesIncarcerated'] = this.numberOfTimesIncarcerated;
    data['incarceratedHistory'] = this.incarceratedHistory;
    data['latestOffenceType'] = this.latestOffenceType;
    data['lengthOfLongestIncarceration'] = this.lengthOfLongestIncarceration;
    data['lengthOfLatestIncarceration'] = this.lengthOfLatestIncarceration;
    data['firstIncarcerationDate'] = this.firstIncarcerationDate;
    data['latestReleaseDate'] = this.latestReleaseDate;
    data['mostRecentTermServerIn'] = this.mostRecentTermServerIn;
    data['programAttendedWhileIncarcerated'] =
        this.programAttendedWhileIncarcerated;
    return data;
  }
}