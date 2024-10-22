import 'package:equatable/equatable.dart';

class ProgramServiceInfo extends Equatable {
  String? specificProgram;
  List<String>? programsList;

  ProgramServiceInfo({
    this.specificProgram,
    this.programsList,
  });

  ProgramServiceInfo.fromJson(Map<String, dynamic> json) {
    specificProgram = json['specificProgram'];
    programsList = List<String>.from(json['programsList'] ?? []);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['specificProgram'] = specificProgram;
    data['programsList'] = programsList;
    return data;
  }

  ProgramServiceInfo copyWith({
    String? specificProgram,
    List<String>? programsList,
  }) {
    return ProgramServiceInfo(
      specificProgram: specificProgram ?? this.specificProgram,
      programsList: programsList ?? this.programsList,
    );
  }

  @override
  List<Object?> get props => [
        specificProgram,
        programsList,
      ];
}
