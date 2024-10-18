import 'package:equatable/equatable.dart';

class ProgramService extends Equatable {
  String? specificProgram;
  List<String>? programsList;

  ProgramService({
    this.specificProgram,
    this.programsList,
  });

  ProgramService.fromJson(Map<String, dynamic> json) {
    specificProgram = json['specificProgram'];
    programsList = List<String>.from(json['programsList'] ?? []);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['specificProgram'] = specificProgram;
    data['programsList'] = programsList;
    return data;
  }

  ProgramService copyWith({
    String? specificProgram,
    List<String>? programsList,
  }) {
    return ProgramService(
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
