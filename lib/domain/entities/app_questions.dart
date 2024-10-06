class Question {
  final String id;
  final String type; // text, checkbox, radio
  final String question;
  final List<String>? options; // for radio/checkbox type questions
  
  Question({
    required this.id,
    required this.type,
    required this.question,
    this.options,
  });
}
