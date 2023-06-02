class Question {
  final String question;
  final List<String> options;
  final String answer;

  Question(
      {required this.question, required this.options, required this.answer});

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      question: json['question'],
      options: List<String>.from(json['options']),
      answer: json['answer'],
    );
  }
}
