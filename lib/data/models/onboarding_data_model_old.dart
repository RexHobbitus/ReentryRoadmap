import 'package:reentry_roadmap/domain/entities/app_questions.dart';

class QuestionModel {
  final String id;
  final String type; //for text, checkbox, radio, dropdown
  final String question;
  final List<String>? options; // for radio/checkbox/dropdown type onboarding questions

  QuestionModel({
    required this.id,
    required this.type,
    required this.question,
    this.options,
  });

  static QuestionModel fromEntity(Question question) {
    return QuestionModel(
      id: question.id,
      type: question.type,
      question: question.question,
      options: question.options,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'question': question,
      'options': options,
    };
  }
}
