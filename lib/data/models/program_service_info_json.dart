import '../../domain/entities/program_service_info.dart';

class ProgramServiceInfoJson {
  String? specificProgram;
  List<String>? programsList;

  ProgramServiceInfoJson({
    this.specificProgram,
    this.programsList,
  });

  ProgramServiceInfoJson.fromJson(Map<String, dynamic> json) {
    specificProgram = json['specificProgram'];
    programsList = json['programsList']?.cast<String>() ?? [];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['specificProgram'] = this.specificProgram;
    data['programsList'] = this.programsList;
    return data;
  }

  ProgramServiceInfo toDomain() {
    return ProgramServiceInfo(
      specificProgram: specificProgram ?? '',
      programsList: programsList ?? [],
    );
  }

  ProgramServiceInfoJson copyWith({
    String? specificProgram,
    List<String>? programsList,
  }) {
    return ProgramServiceInfoJson(
      specificProgram: specificProgram ?? this.specificProgram,
      programsList: programsList ?? this.programsList,
    );
  }
}
