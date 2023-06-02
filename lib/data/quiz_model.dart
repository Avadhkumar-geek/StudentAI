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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['question'] = this.question;
    data['options'] = this.options;
    data['answer'] = this.answer;
    return data;
  }
}
