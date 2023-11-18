class CustomAppModel {
  final String appId;
  final String title;
  final String desc;
  final String prompt;

  CustomAppModel(
      {required this.appId,
      required this.title,
      required this.desc,
      required this.prompt});

  factory CustomAppModel.fromJson(Map<String, dynamic> json) {
    return CustomAppModel(
        appId: json['appId'],
        title: json['title'],
        desc: json['desc'],
        prompt: json['prompt']);
  }

  Map<String, dynamic> toJson() =>
      {'appId': appId, 'title': title, 'desc': desc, 'prompt': prompt};
}
